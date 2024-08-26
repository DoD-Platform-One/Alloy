# Alloy Development and Maintenance Guide

## To upgrade the Alloy Package

1. Navigate to the upstream [chart repo and folder](https://github.com/grafana/alloy/tree/main/operations/helm/charts/alloy) and find the tag that corresponds with the new chart version for this update.

    - Check the [upstream changelog](https://github.com/grafana/alloy/blob/main/CHANGELOG.md) for upgrade notices.

2. Checkout the `renovate/ironbank` branch

3. From the root of the repo run `kpt pkg update chart@helm-chart/<tag> --strategy alpha-git-patch`, where tag is found in step 1 (alloy ref: `<tag>`) for example, `helm-chart/0.6.0`

    - Run a KPT update against the main chart folder:

    ```shell
      kpt pkg update chart@<tag> --strategy alpha-git-patch
    ```

    - Restore all BigBang added templates and tests:

    ```shell
      git checkout chart/templates/bigbang/
      git checkout chart/tests/
      git checkout chart/dashboards
      git checkout chart/templates/tests
    ```

    - Follow the [Update main chart](#update-main-chart) section of this document for a list of changes per file to be aware of, for how Big Bang differs from upstream.

4. Modify the version in `Chart.yaml` and append `-bb.0` to the chart version from upstream.

5. Update dependencies and binaries using `helm dependency update ./chart`

    - If needed, log into registry1.

      ```shell
      # Note, if you are using Ubuntu on WSL and get an error about storing credentials or about how `The name org.freedesktop.secrets was not
      # provided by any .service files` when you run the command below, install the libsecret-1-dev and gnome-keyring packages. After doing this,
      # you'll be prompted to set a keyring password the first time you run this command.
      #
      helm registry login https://registry1.dso.mil -u ${registry1.username}
      ```

    - Pull assets and commit the binaries as well as the Chart.lock file that was generated.

      ```shell
      # Note: You may need to resolve merge conflicts in chart/values.yaml before these commands work. Refer to the "Modifications made to upstream"
      # section below for hinsts on how to resolve them. Also, you need to be logged in to registry1 thorough docker.
      export HELM_EXPERIMENTAL_OCI=1
      helm dependency update ./chart
      ```

      Then log out.

      ```shell
      helm registry logout https://registry1.dso.mil
      ```

6. Update `CHANGELOG.md` adding an entry for the new version and noting all changes in a list (at minimum should include `- Updated <chart or dependency> to x.x.x`).

7. Generate the `README.md` updates by following the [guide in gluon](https://repo1.dso.mil/big-bang/product/packages/gluon/-/blob/master/docs/bb-package-readme.md).

8. Push up your changes, add upgrade notices if applicable, validate that CI passes.

    - If there are any failures, follow the information in the pipeline to make the necessary updates.

    - Add the `debug` label to the MR for more detailed information.

    - Reach out to the CODEOWNERS if needed.

9. As part of your MR that modifies bigbang packages, you should modify the bigbang  [bigbang/tests/test-values.yaml](https://repo1.dso.mil/big-bang/bigbang/-/blob/master/tests/test-values.yaml?ref_type=heads) against your branch for the CI/CD MR testing by enabling your packages. 

    - To do this, at a minimum, you will need to follow the instructions at [bigbang/docs/developer/test-package-against-bb.md](https://repo1.dso.mil/big-bang/bigbang/-/blob/master/docs/developer/test-package-against-bb.md?ref_type=heads) with changes for Alloy enabled (the below is a reference, actual changes could be more depending on what changes where made to Alloy in the package MR).

### [test-values.yaml](https://repo1.dso.mil/big-bang/bigbang/-/blob/master/tests/test-values.yaml?ref_type=heads)
    ```yaml
    grafanaAlloy:
      enabled: true
      git:
        tag: null
        branch: <my-package-branch-that-needs-testing>
      values:
        istio:
          hardened:
            enabled: true
      ### Additional compononents of Loki should be changed to reflect testing changes introduced in the package MR
    ```


10. Follow the `Testing new Alloy Version` section of this document for manual testing.

## Update main chart

### ```chart/Chart.yaml```

- update loki `version` and `appVersion`
- Ensure Big Bang version suffix is appended to chart version
- Ensure gluon dependencies are present and up to date

  ```yaml
    version: $VERSION-bb.0
    annotations:
    bigbang.dev/applicationVersions: |
        - Alloy: '$ALLOY_APP_VERSION'
    helm.sh/images: |
        - name: alloy
        image: registry1.dso.mil/ironbank/opensource/grafana/alloy:$ALLOY_APP_VERSION
        - name: configmap-reload
        image: registry1.dso.mil/ironbank/opensource/jimmidyson/configmap-reload:$ALLOY_APP_VERSION
    bigbang.dev/upstreamReleaseNotesMarkdown: |
        - [Find our upstream chart's CHANGELOG here](https://github.com/grafana/alloy/blob/main/CHANGELOG.md)
        - [and our upstream application release notes here](https://github.com/grafana/alloy/blob/main/docs/sources/release-notes.md?plain=1)
    dependencies:
    - name: crds
        version: "0.0.0"
        condition: crds.create
    - name: gluon
        version: "$GLUON_VERSION"
        repository: "oci://registry.dso.mil/platform-one/big-bang/apps/library-charts/gluon"
  ```

### ```chart/values.yaml```

- Verify that Renovate updated the grafanaAlloy: section with the correct value for  `tag`. For example, if Renovate wants to update Alloy to version `1.3.0`, you should see:

  ```yaml
  addons:
     grafanaAlloy:
        image:
        # -- The Docker registry
        registry: registry1.dso.mil
        # -- Docker image repository
        repository: ironbank/opensource/grafana/alloy
        # -- Overrides the image tag whose default is the chart's appVersion
        tag: 1.3.0
  ```

## Modifications made to upstream

This is a high-level list of modifications that Big Bang has made to the upstream helm chart. You can use this as as cross-check to make sure that no modifications were lost during the upgrade process.

### ```chart/values.yaml```

- Ensure securityContext is set

  ```yaml
  alloy:
    ...
    securityContext:
      capabilities:
      drop:
        - ALL
      runAsGroup: 473
      runAsNonRoot: true
      runAsUser: 473
  ```

- Ensure configReloader/image `registry` and `repo` is set

  ```yaml
  configReloader:
    ...
    image:
      registry: registry1.dso.mil
      repository: ironbank/opensource/jimmidyson/configmap-reload
  ```

- Ensure securityContext is set for `configReloader`

  ```yaml
  configReloader:
    ...
    securityContext:
      capabilities:
      drop:
        - ALL
      runAsGroup: 473
      runAsNonRoot: true
      runAsUser: 473
  ```

- Ensure securityContext is set for `controller`

  ```yaml
  controller:
    ...
    securityContext:
      capabilities:
        drop:
          - ALL
      runAsGroup: 1001
      runAsNonRoot: true
      runAsUser: 1001
  ```

- Ensure the global/image/pullsecrets is set

  ```yaml
  image:
    pullSecrets:
      - name: private-registry
    registry: registry1.dso.mil
  podSecurityContext:
    fsGroup: 473
    runAsGroup: 473
    runAsNonRoot: true
    runAsUser: 473
    seccompProfile:
      type: RuntimeDefault
  ```

- Ensure global/image is set

  ```yaml
  global:
    image:
      pullSecrets:
        - name: private-registry
      registry: registry1.dso.mil
    podSecurityContext:
      fsGroup: 473
      runAsGroup: 473
      runAsNonRoot: true
      runAsUser: 473
      seccompProfile:
        type: RuntimeDefault
  image:
    global:
      image:
        pullSecrets:
          - name: private-registry
        registry: registry1.dso.mil
      podSecurityContext:
        fsGroup: 473
        runAsGroup: 473
        runAsNonRoot: true
        runAsUser: 473
        seccompProfile:
          type: RuntimeDefault
    image:
      digest: null
      pullPolicy: IfNotPresent
      pullSecrets:
        - name: private-registry
      registry: registry1.dso.mil
      repository: ironbank/opensource/grafana/alloy
      tag: v1.2.1
  ```

- Ensure istio defaults are set

  ```yaml
  istio:
    enabled: false
    namespace: istio-system
    hardened:
      enabled: false
  ```

## Testing new Alloy Version

> NOTE: For these testing steps it is good to do them on both a clean install and an upgrade. For clean install, point Alloy to your branch. For an upgrade do an install with Alloy pointing to the latest tag, then perform a helm upgrade with Alloy pointing to your branch.

### Deploy Alloy as a part of BigBang

You will want to install with:

- Istio package enabled

`overrides/alloy.yaml`

```yaml
domain: dev.bigbang.mil

flux:
  interval: 1m
  rollback:
    cleanupOnFail: false

istio:
  enabled: true

addons:
  grafanaAlloy:
    # git:
    #   tag: null
    #   branch: "<branch-name>"
    enabled: true
```

- Validate Alloy pod logs are showing no errors.

> When in doubt with any testing or upgrade steps, reach out to the CODEOWNERS for assistance.