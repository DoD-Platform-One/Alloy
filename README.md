<!-- Warning: Do not manually edit this file. See notes on gluon + helm-docs at the end of this file for more information. -->
# alloy

![Version: 0.6.1-bb.0](https://img.shields.io/badge/Version-0.6.1--bb.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v1.3.1](https://img.shields.io/badge/AppVersion-v1.3.1-informational?style=flat-square)

Grafana Alloy

### Upstream Release Notes

- [Find our upstream chart's CHANGELOG here](https://github.com/grafana/alloy/blob/main/CHANGELOG.md)
- [and our upstream application release notes here](https://github.com/grafana/alloy/blob/main/docs/sources/release-notes.md?plain=1)

## Learn More
* [Application Overview](docs/overview.md)
* [Other Documentation](docs/)

## Pre-Requisites

* Kubernetes Cluster deployed
* Kubernetes config installed in `~/.kube/config`
* Helm installed

Install Helm

https://helm.sh/docs/intro/install/

## Deployment

* Clone down the repository
* cd into directory
```bash
helm install alloy chart/
```

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| nameOverride | string | `nil` | Overrides the chart's name. Used to change the infix in the resource names. |
| fullnameOverride | string | `nil` | Overrides the chart's computed fullname. Used to change the full prefix of resource names. |
| global.image.registry | string | `"registry1.dso.mil"` | Global image registry to use if it needs to be overriden for some specific use cases (e.g local registries, custom images, ...) |
| global.image.pullSecrets | list | `[{"name":"private-registry"}]` | Optional set of global image pull secrets. |
| global.podSecurityContext | object | `{"fsGroup":473,"runAsGroup":473,"runAsNonRoot":true,"runAsUser":473,"seccompProfile":{"type":"RuntimeDefault"}}` | Security context to apply to the Grafana Alloy pod. |
| crds.create | bool | `true` | Whether to install CRDs for monitoring. |
| alloy.configMap.create | bool | `true` | Create a new ConfigMap for the config file. |
| alloy.configMap.content | string | `"otelcol.receiver.otlp \"otlp_receiver\" {\n    // We don't technically need this, but it shows how to change listen address and incoming port.\n    // In this case, the Alloy is listening on all available bindable addresses on port 4317 (which is the\n    // default OTLP gRPC port) for the OTLP protocol.\n    grpc {\n        endpoint = \"0.0.0.0:4317\"\n    }\n\n    // We define where to send the output of all ingested traces. In this case, to the OpenTelemetry batch processor\n    // named 'default'.\n    output {\n        traces = [\n            // Uncomment the next line to generate service graph metrics from the Alloy. By default this is generated\n            // by the Tempo component, so be sure to remove the relevant configuration in the `tempo/tempo.yaml` file.\n            //otelcol.connector.servicegraph.tracemetrics.input,\n            // Uncomment the next line to generate span metrics from the Alloy. By default this is generated\n            // by the Tempo component, so be sure to remove the relevant configuration in the `tempo/tempo.yaml` file.\n            //otelcol.connector.spanmetrics.tracemetrics.input,\n            // The following would be used for tail sampling only traces containing errors.\n            // Uncomment the following line, then comment out the line below it (the batch processor) to use\n            // tail sampling.\n            //otelcol.processor.tail_sampling.errors.input,\n            otelcol.processor.batch.default.input,\n        ]\n    }\n}\n\n// The OpenTelemetry batch processor collects trace spans until a batch size or timeout is met, before sending those\n// spans onto another target. This processor is labeled 'default'.\notelcol.processor.batch \"default\" {\n    // Wait until we've received 16K of data.\n    send_batch_size = 16384\n    send_batch_max_size = 16384\n    // Or until 2 seconds have elapsed.\n    timeout = \"2s\"\n    // When the Alloy has enough batched data, send it to the OpenTelemetry exporter named 'tempo'.\n    output {\n        traces = [otelcol.exporter.otlp.tempo.input]\n    }\n}\n\n// The OpenTelemetry exporter exports processed trace spans to another target that is listening for OTLP format traces.\n// A unique label, 'tempo', is added to uniquely identify this exporter.\notelcol.exporter.otlp \"tempo\" {\n    // Define the client for exporting.\n    client {\n        // Send to the locally running Tempo instance, on port 4317 (OTLP gRPC).\n        endpoint = \"http://tempo-tempo:4317\"\n\n        // Configure TLS settings for communicating with the endpoint.\n        tls {\n            // The connection is insecure.\n            insecure = true\n            // Do not verify TLS certificates when connecting.\n            insecure_skip_verify = true\n        }\n    }\n}\n"` | Content to assign to the new ConfigMap.  This is passed into `tpl` allowing for templating from values. |
| alloy.configMap.name | string | `nil` | Name of existing ConfigMap to use. Used when create is false. |
| alloy.configMap.key | string | `nil` | Key in ConfigMap to get config from. |
| alloy.clustering.enabled | bool | `false` | Deploy Alloy in a cluster to allow for load distribution. |
| alloy.clustering.name | string | `""` | Name for the Alloy cluster. Used for differentiating between clusters. |
| alloy.clustering.portName | string | `"http"` | Name for the port used for clustering, useful if running inside an Istio Mesh |
| alloy.stabilityLevel | string | `"generally-available"` | Minimum stability level of components and behavior to enable. Must be one of "experimental", "public-preview", or "generally-available". |
| alloy.storagePath | string | `"/tmp/alloy"` | Path to where Grafana Alloy stores data (for example, the Write-Ahead Log). By default, data is lost between reboots. |
| alloy.listenAddr | string | `"0.0.0.0"` | Address to listen for traffic on. 0.0.0.0 exposes the UI to other containers. |
| alloy.listenPort | int | `12345` | Port to listen for traffic on. |
| alloy.listenScheme | string | `"HTTP"` | Scheme is needed for readiness probes. If enabling tls in your configs, set to "HTTPS" |
| alloy.uiPathPrefix | string | `"/"` | Base path where the UI is exposed. |
| alloy.enableReporting | bool | `true` | Enables sending Grafana Labs anonymous usage stats to help improve Grafana Alloy. |
| alloy.extraEnv | list | `[]` | Extra environment variables to pass to the Alloy container. |
| alloy.envFrom | list | `[]` | Maps all the keys on a ConfigMap or Secret as environment variables. https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.24/#envfromsource-v1-core |
| alloy.extraArgs | list | `[]` | Extra args to pass to `alloy run`: https://grafana.com/docs/alloy/latest/reference/cli/run/ |
| alloy.extraPorts | list | `[]` | Extra ports to expose on the Alloy container. |
| alloy.mounts.varlog | bool | `false` | Mount /var/log from the host into the container for log collection. |
| alloy.mounts.dockercontainers | bool | `false` | Mount /var/lib/docker/containers from the host into the container for log collection. |
| alloy.mounts.extra | list | `[]` | Extra volume mounts to add into the Grafana Alloy container. Does not affect the watch container. |
| alloy.securityContext | object | `{"capabilities":{"drop":["ALL"]},"runAsGroup":473,"runAsNonRoot":true,"runAsUser":473}` | Security context to apply to the Grafana Alloy container. |
| alloy.resources | object | `{"limits":{"cpu":"4000m","memory":"8000Mi"},"requests":{"cpu":"2000m","memory":"4000Mi"}}` | Resource requests and limits to apply to the Grafana Alloy container. |
| image.registry | string | `"registry1.dso.mil"` | Grafana Alloy image registry (defaults to docker.io) |
| image.repository | string | `"ironbank/opensource/grafana/alloy"` | Grafana Alloy image repository. |
| image.tag | string | `"v1.3.1"` | Grafana Alloy image tag. When empty, the Chart's appVersion is used. |
| image.digest | string | `nil` | Grafana Alloy image's SHA256 digest (either in format "sha256:XYZ" or "XYZ"). When set, will override `image.tag`. |
| image.pullPolicy | string | `"IfNotPresent"` | Grafana Alloy image pull policy. |
| image.pullSecrets | list | `[{"name":"private-registry"}]` | Optional set of image pull secrets. |
| rbac.create | bool | `true` | Whether to create RBAC resources for Alloy. |
| serviceAccount.create | bool | `true` | Whether to create a service account for the Grafana Alloy deployment. |
| serviceAccount.additionalLabels | object | `{}` | Additional labels to add to the created service account. |
| serviceAccount.annotations | object | `{}` | Annotations to add to the created service account. |
| serviceAccount.name | string | `nil` | The name of the existing service account to use when serviceAccount.create is false. |
| configReloader.enabled | bool | `true` | Enables automatically reloading when the Alloy config changes. |
| configReloader.image.registry | string | `"registry1.dso.mil"` | Config reloader image registry (defaults to docker.io) |
| configReloader.image.repository | string | `"ironbank/opensource/jimmidyson/configmap-reload"` | Repository to get config reloader image from. |
| configReloader.image.tag | string | `"v0.13.1"` | Tag of image to use for config reloading. |
| configReloader.image.digest | string | `""` | SHA256 digest of image to use for config reloading (either in format "sha256:XYZ" or "XYZ"). When set, will override `configReloader.image.tag` |
| configReloader.customArgs | list | `[]` | Override the args passed to the container. |
| configReloader.resources | object | `{"requests":{"cpu":"1m","memory":"5Mi"}}` | Resource requests and limits to apply to the config reloader container. |
| configReloader.securityContext | object | `{"capabilities":{"drop":["ALL"]},"runAsGroup":473,"runAsNonRoot":true,"runAsUser":473}` | Security context to apply to the Grafana configReloader container. |
| controller.type | string | `"daemonset"` | Type of controller to use for deploying Grafana Alloy in the cluster. Must be one of 'daemonset', 'deployment', or 'statefulset'. |
| controller.replicas | int | `1` | Number of pods to deploy. Ignored when controller.type is 'daemonset'. |
| controller.extraAnnotations | object | `{}` | Annotations to add to controller. |
| controller.parallelRollout | bool | `true` | Whether to deploy pods in parallel. Only used when controller.type is 'statefulset'. |
| controller.hostNetwork | bool | `false` | Configures Pods to use the host network. When set to true, the ports that will be used must be specified. |
| controller.hostPID | bool | `false` | Configures Pods to use the host PID namespace. |
| controller.dnsPolicy | string | `"ClusterFirst"` | Configures the DNS policy for the pod. https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/#pod-s-dns-policy |
| controller.updateStrategy | object | `{}` | Update strategy for updating deployed Pods. |
| controller.nodeSelector | object | `{}` | nodeSelector to apply to Grafana Alloy pods. |
| controller.tolerations | list | `[]` | Tolerations to apply to Grafana Alloy pods. |
| controller.topologySpreadConstraints | list | `[]` | Topology Spread Constraints to apply to Grafana Alloy pods. |
| controller.priorityClassName | string | `""` | priorityClassName to apply to Grafana Alloy pods. |
| controller.podAnnotations | object | `{}` | Extra pod annotations to add. |
| controller.podLabels | object | `{}` | Extra pod labels to add. |
| controller.enableStatefulSetAutoDeletePVC | bool | `false` | Whether to enable automatic deletion of stale PVCs due to a scale down operation, when controller.type is 'statefulset'. |
| controller.autoscaling.enabled | bool | `false` | Creates a HorizontalPodAutoscaler for controller type deployment. |
| controller.autoscaling.minReplicas | int | `1` | The lower limit for the number of replicas to which the autoscaler can scale down. |
| controller.autoscaling.maxReplicas | int | `5` | The upper limit for the number of replicas to which the autoscaler can scale up. |
| controller.autoscaling.targetCPUUtilizationPercentage | int | `0` | Average CPU utilization across all relevant pods, a percentage of the requested value of the resource for the pods. Setting `targetCPUUtilizationPercentage` to 0 will disable CPU scaling. |
| controller.autoscaling.targetMemoryUtilizationPercentage | int | `80` | Average Memory utilization across all relevant pods, a percentage of the requested value of the resource for the pods. Setting `targetMemoryUtilizationPercentage` to 0 will disable Memory scaling. |
| controller.autoscaling.scaleDown.policies | list | `[]` | List of policies to determine the scale-down behavior. |
| controller.autoscaling.scaleDown.selectPolicy | string | `"Max"` | Determines which of the provided scaling-down policies to apply if multiple are specified. |
| controller.autoscaling.scaleDown.stabilizationWindowSeconds | int | `300` | The duration that the autoscaling mechanism should look back on to make decisions about scaling down. |
| controller.autoscaling.scaleUp.policies | list | `[]` | List of policies to determine the scale-up behavior. |
| controller.autoscaling.scaleUp.selectPolicy | string | `"Max"` | Determines which of the provided scaling-up policies to apply if multiple are specified. |
| controller.autoscaling.scaleUp.stabilizationWindowSeconds | int | `0` | The duration that the autoscaling mechanism should look back on to make decisions about scaling up. |
| controller.affinity | object | `{}` | Affinity configuration for pods. |
| controller.volumes.extra | list | `[]` | Extra volumes to add to the Grafana Alloy pod. |
| controller.volumeClaimTemplates | list | `[]` | volumeClaimTemplates to add when controller.type is 'statefulset'. |
| controller.initContainers | list | `[]` |  |
| controller.securityContext.runAsNonRoot | bool | `true` |  |
| controller.securityContext.runAsUser | int | `1001` |  |
| controller.securityContext.runAsGroup | int | `1001` |  |
| controller.securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| controller.extraContainers | list | `[]` | Additional containers to run alongside the Alloy container and initContainers. |
| service.enabled | bool | `true` | Creates a Service for the controller's pods. |
| service.type | string | `"ClusterIP"` | Service type |
| service.nodePort | int | `31128` | NodePort port. Only takes effect when `service.type: NodePort` |
| service.clusterIP | string | `""` | Cluster IP, can be set to None, empty "" or an IP address |
| service.internalTrafficPolicy | string | `"Cluster"` | Value for internal traffic policy. 'Cluster' or 'Local' |
| service.annotations | object | `{}` |  |
| serviceMonitor.enabled | bool | `false` |  |
| serviceMonitor.additionalLabels | object | `{}` | Additional labels for the service monitor. |
| serviceMonitor.interval | string | `""` | Scrape interval. If not set, the Prometheus default scrape interval is used. |
| serviceMonitor.metricRelabelings | list | `[]` | MetricRelabelConfigs to apply to samples after scraping, but before ingestion. ref: https://github.com/prometheus-operator/prometheus-operator/blob/main/Documentation/api.md#relabelconfig |
| serviceMonitor.tlsConfig | object | `{}` | Customize tls parameters for the service monitor |
| serviceMonitor.relabelings | list | `[]` | RelabelConfigs to apply to samples before scraping ref: https://github.com/prometheus-operator/prometheus-operator/blob/main/Documentation/api.md#relabelconfig |
| ingress.enabled | bool | `false` | Enables ingress for Alloy (Faro port) |
| ingress.annotations | object | `{}` |  |
| ingress.labels | object | `{}` |  |
| ingress.path | string | `"/"` |  |
| ingress.faroPort | int | `12347` |  |
| ingress.pathType | string | `"Prefix"` |  |
| ingress.hosts[0] | string | `"chart-example.local"` |  |
| ingress.extraPaths | list | `[]` |  |
| ingress.tls | list | `[]` |  |
| networkPolicies.enabled | bool | `false` | Toggle networkPolicies |
| networkPolicies.controlPlaneCidr | string | `"0.0.0.0/0"` | Control Plane CIDR, defaults to 0.0.0.0/0, use `kubectl get endpoints -n default kubernetes` to get the CIDR range needed for your cluster Must be an IP CIDR range (x.x.x.x/x - ideally with /32 for the specific IP of a single endpoint, broader range for multiple masters/endpoints) Used by package NetworkPolicies to allow Kube API access |
| networkPolicies.additionalPolicies | list | `[]` |  |
| istio.enabled | bool | `false` |  |
| istio.hardened | object | `{"customServiceEntries":[],"enabled":false,"outboundTrafficPolicyMode":"REGISTRY_ONLY"}` | Default peer authentication values |
| istio.mtls.mode | string | `"STRICT"` | STRICT = Allow only mutual TLS traffic, PERMISSIVE = Allow both plain text and mutual TLS traffic |

## Contributing

Please see the [contributing guide](./CONTRIBUTING.md) if you are interested in contributing.

---

_This file is programatically generated using `helm-docs` and some BigBang-specific templates. The `gluon` repository has [instructions for regenerating package READMEs](https://repo1.dso.mil/big-bang/product/packages/gluon/-/blob/master/docs/bb-package-readme.md)._

