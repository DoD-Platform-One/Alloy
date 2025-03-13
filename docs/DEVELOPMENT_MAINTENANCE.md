# Alloy Development and Maintenance Guide

## To upgrade the Alloy Package

[!IMPORTANT]
Please note that Alloy renovate updates will be unique compared to other BigBang renovate updates because Alloy is a wrapper package

> Renovate doesn't fully automate this yet for Alloy, please validate all tags for the new chart version.

1. Navigate to the upstream [chart repo and folder](https://github.com/grafana/k8s-monitoring-helm/tree/main/charts/k8s-monitoring) and find the appropriate tags that corresponds with the new chart version for this update.

    - Check the [upstream changelog](https://github.com/grafana/k8s-monitoring-helm/releases) for upgrade notices.

2. Checkout the `renovate/ironbank` branch

3. Make sure the `Chart.yaml` is displaying the correct chart version from upstream and has `-bb.0`  apended.

4. Find the correct matching sub-dependency versions for the correct alloy subchart version (ex: 2.0.16) and validate that the renovate is using the correct ones. Usually in these locations:
- k8s-monitoring [2.0.16 chart](https://github.com/grafana/k8s-monitoring-helm/tree/v2.0.16/charts/k8s-monitoring)
- check appVersion in chart and make sure it is updated
- alloy helm chart tag from dependency [0.12.1 chart values](hhttps://github.com/grafana/alloy/blob/helm-chart/0.12.1/operations/helm/charts/alloy/values.yaml)
  - If upgrading the Iron Bank images ensure that the Big Bang package values.yaml has the most recent minor/patch version for the Iron Bank images.

4. Make sure the `annotations`, `bigbang.dev/applicationVersions: |` alloy version is consistent with what is in `helm.sh/images: |`.

5. If necessary, update the `./chart/values.yaml` file `alloy.image.tag` and `alloy.configReloader.image.tag` values to match their respective tags in `helm.sh/images:` in `./chart/Chart.yaml`

6. If necessary, Update dependencies and binaries using `helm dependency update ./chart`. This step may be automated and not needed.

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
      helm dependency update ./chart
      ```

      Then log out.

      ```shell
      helm registry logout https://registry1.dso.mil
      ```

7. Update `CHANGELOG.md` adding an entry for the new version and noting all changes in a list (at minimum should include `- Updated <chart or dependency> to x.x.x`). Also, make sure the configloader versions are accurate if updated.

8. Generate the `README.md` updates by following the [guide in gluon](https://repo1.dso.mil/big-bang/product/packages/gluon/-/blob/master/docs/bb-package-readme.md).

At the moment, this still needs to be done!

9. Push up your changes, add upgrade notices if applicable, validate that CI passes.

    - If there are any failures, follow the information in the pipeline to make the necessary updates.

    - Add the `debug` label to the MR for more detailed information.

    - Reach out to the CODEOWNERS if needed.

10. As part of your MR that modifies bigbang packages, you should modify the bigbang  [bigbang/tests/test-values.yaml](https://repo1.dso.mil/big-bang/bigbang/-/blob/master/tests/test-values.yaml?ref_type=heads) against your branch for the CI/CD MR testing by enabling your packages. 

    - To do this, at a minimum, you will need to follow the instructions at [bigbang/docs/developer/test-package-against-bb.md](https://repo1.dso.mil/big-bang/bigbang/-/blob/master/docs/developer/test-package-against-bb.md?ref_type=heads) with changes for Alloy enabled (the below is a reference, actual changes could be more depending on what changes where made to Alloy in the package MR).

### [test-values.yaml](https://repo1.dso.mil/big-bang/bigbang/-/blob/master/tests/test-values.yaml?ref_type=heads)

```yaml
  alloy:
    enabled: true
    git:
      tag: null
      branch: <my-package-branch-that-needs-testing>
    values:
      istio:
        hardened:
          enabled: true
    ### Additional compononents of Alloy should be changed to reflect testing changes introduced in the package MR
```

11. Follow the `Testing new Alloy Version` section of this document for manual testing.

## Update main chart

### ```chart/Chart.yaml```

- update k8s-monitoring `version` and `appVersion`
- Ensure Big Bang version suffix is appended to chart version
- Ensure gluon dependencies are present and up to date

  ```yaml
    apiVersion: v2
    name: k8s-monitoring
    description: A Helm chart for gathering, scraping, and forwarding Kubernetes telemetry data to a Grafana Stack.
    type: application
    version: $VERSION-bb.0
    appVersion: $K8S_MONITORING_APPVERSION
    icon: https://raw.githubusercontent.com/grafana/grafana/main/public/img/grafana_icon.svg
    sources:
      - https://github.com/grafana/k8s-monitoring-helm/tree/main/charts/k8s-monitoring
    annotations:
      bigbang.dev/applicationVersions: |
        - Alloy: '$ALLOY_APP_VERSION'
        - k8s-monitoring: '$K8S_MONITORING_VERSION'
      helm.sh/images: |
        - name: alloy
          image: registry1.dso.mil/ironbank/opensource/grafana/alloy:$ALLOY_APP_VERSION
        - name: configmap-reload
          image: registry1.dso.mil/ironbank/opensource/jimmidyson/configmap-reload:$CONFIGMAP_RELOAD_APP_VERSION
      bigbang.dev/upstreamReleaseNotesMarkdown: |
        - [Find our upstream chart's CHANGELOG here](https://github.com/grafana/k8s-monitoring-helm/releases/)
        - [and our upstream application release notes here](https://github.com/grafana/alloy/blob/main/docs/sources/release-notes.md?plain=1)
    dependencies:
      - name: k8s-monitoring
        version: "1.5.0"
        repository: https://grafana.github.io/helm-charts
      - name: gluon
        version: "$GLUON_VERSION"
        repository: oci://registry1.dso.mil/bigbang
  ```

## Modifications made to upstream

This is a high-level list of modifications that Big Bang has made to the upstream helm chart. You can use this as as cross-check to make sure that no modifications were lost during the upgrade process.

### ```chart/values.yaml```

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
  alloy:
    # git:
    #   tag: null
    #   branch: "<branch-name>"
    enabled: true
```

- Validate Alloy pod logs are showing no errors.

> When in doubt with any testing or upgrade steps, reach out to the CODEOWNERS for assistance.