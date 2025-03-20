<!-- Warning: Do not manually edit this file. See notes on gluon + helm-docs at the end of this file for more information. -->
# k8s-monitoring

![Version: 2.0.16-bb.1](https://img.shields.io/badge/Version-2.0.16--bb.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 2.0.16](https://img.shields.io/badge/AppVersion-2.0.16-informational?style=flat-square) ![Maintenance Track: bb_integrated](https://img.shields.io/badge/Maintenance_Track-bb_integrated-green?style=flat-square)

A Helm chart for gathering, scraping, and forwarding Kubernetes telemetry data to a Grafana Stack.

## Upstream References

- <https://github.com/grafana/k8s-monitoring-helm/tree/main/charts/k8s-monitoring>

## Upstream Release Notes

- [Find k8s-monitoring CHANGELOG here](https://github.com/grafana/k8s-monitoring-helm/releases/)
- [and Grafana Alloy's release notes here](https://grafana.com/docs/alloy/latest/release-notes/)

## Learn More

- [Application Overview](docs/overview.md)
- [Other Documentation](docs/)

## Pre-Requisites

- Kubernetes Cluster deployed
- Kubernetes config installed in `~/.kube/config`
- Helm installed

Install Helm

https://helm.sh/docs/intro/install/

## Deployment

- Clone down the repository
- cd into directory

```bash
helm install k8s-monitoring chart/
```

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.image.registry | string | `"registry1.dso.mil"` |  |
| global.image.pullSecrets[0].name | string | `"private-registry"` |  |
| global.imageRegistry | string | `"registry1.dso.mil"` | Overrides the Docker registry globally for all images |
| global.imagePullSecrets[0].name | string | `"private-registry"` |  |
| k8s-monitoring.cluster.name | string | `"bigbang"` |  |
| k8s-monitoring.destinations[0].name | string | `"metricsService"` |  |
| k8s-monitoring.destinations[0].type | string | `"prometheus"` |  |
| k8s-monitoring.destinations[0].url | string | `"http://monitoring-monitoring-kube-prometheus.monitoring.svc.cluster.local:9090/api/v1/write"` |  |
| k8s-monitoring.destinations[1].name | string | `"logsService"` |  |
| k8s-monitoring.destinations[1].type | string | `"loki"` |  |
| k8s-monitoring.destinations[1].url | string | `"logging-loki.logging.svc.cluster.local:3100/loki/api/v1/push"` |  |
| k8s-monitoring.destinations[2].name | string | `"tracesService"` |  |
| k8s-monitoring.destinations[2].type | string | `"otlp"` |  |
| k8s-monitoring.destinations[2].metrics.enabled | bool | `false` |  |
| k8s-monitoring.destinations[2].logs.enabled | bool | `false` |  |
| k8s-monitoring.destinations[2].traces.enabled | bool | `true` |  |
| k8s-monitoring.destinations[2].url | string | `"tempo-tempo.tempo.svc.cluster.local:4317"` |  |
| k8s-monitoring.destinations[2].tls | object | `{}` |  |
| k8s-monitoring.alloy-metrics.image.registry | string | `"registry1.dso.mil"` |  |
| k8s-monitoring.alloy-metrics.image.repository | string | `"ironbank/opensource/grafana/alloy"` |  |
| k8s-monitoring.alloy-metrics.image.tag | string | `"v1.7.1"` |  |
| k8s-monitoring.alloy-metrics.configReloader.image.registry | string | `"registry1.dso.mil"` |  |
| k8s-monitoring.alloy-metrics.configReloader.image.repository | string | `"ironbank/opensource/jimmidyson/configmap-reload"` |  |
| k8s-monitoring.alloy-metrics.configReloader.image.tag | string | `"v0.14.0"` |  |
| k8s-monitoring.alloy-metrics.configReloader.securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| k8s-monitoring.alloy-metrics.alloy.enableReporting | bool | `false` |  |
| k8s-monitoring.alloy-metrics.alloy.securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| k8s-monitoring.alloy-metrics.controller.securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| k8s-monitoring.alloy-metrics.enabled | bool | `true` |  |
| k8s-monitoring.applicationObservability.enabled | bool | `true` |  |
| k8s-monitoring.applicationObservability.receivers.otlp.grpc.enabled | bool | `true` |  |
| k8s-monitoring.alloy-receiver.image.registry | string | `"registry1.dso.mil"` |  |
| k8s-monitoring.alloy-receiver.image.repository | string | `"ironbank/opensource/grafana/alloy"` |  |
| k8s-monitoring.alloy-receiver.image.tag | string | `"v1.7.1"` |  |
| k8s-monitoring.alloy-receiver.configReloader.image.registry | string | `"registry1.dso.mil"` |  |
| k8s-monitoring.alloy-receiver.configReloader.image.repository | string | `"ironbank/opensource/jimmidyson/configmap-reload"` |  |
| k8s-monitoring.alloy-receiver.configReloader.image.tag | string | `"v0.14.0"` |  |
| k8s-monitoring.alloy-receiver.configReloader.securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| k8s-monitoring.alloy-receiver.alloy.enableReporting | bool | `false` |  |
| k8s-monitoring.alloy-receiver.alloy.extraPorts[0].name | string | `"otlp-grpc"` |  |
| k8s-monitoring.alloy-receiver.alloy.extraPorts[0].port | int | `4317` |  |
| k8s-monitoring.alloy-receiver.alloy.extraPorts[0].targetPort | int | `4317` |  |
| k8s-monitoring.alloy-receiver.alloy.extraPorts[0].protocol | string | `"TCP"` |  |
| k8s-monitoring.alloy-receiver.alloy.securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| k8s-monitoring.alloy-receiver.alloy.securityContext.seccompProfile.type | string | `"RuntimeDefault"` |  |
| k8s-monitoring.alloy-receiver.controller.securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| k8s-monitoring.alloy-receiver.enabled | bool | `true` |  |
| k8s-monitoring.integrations.alloy.enableReporting | bool | `false` |  |
| k8s-monitoring.integrations.alloy.image.registry | string | `"registry1.dso.mil"` |  |
| k8s-monitoring.integrations.alloy.image.repository | string | `"ironbank/opensource/grafana/alloy"` |  |
| k8s-monitoring.integrations.alloy.image.tag | string | `"v1.7.1"` |  |
| k8s-monitoring.integrations.alloy.instances[0].name | string | `"alloy"` |  |
| k8s-monitoring.integrations.alloy.instances[0].labelSelectors."app.kubernetes.io/name"[0] | string | `"alloy-receiver"` |  |
| k8s-monitoring.integrations.alloy.instances[0].labelSelectors."app.kubernetes.io/name"[1] | string | `"alloy-metrics"` |  |
| networkPolicies.enabled | bool | `false` | Toggle networkPolicies |
| networkPolicies.controlPlaneCidr | string | `"0.0.0.0/0"` | Control Plane CIDR, defaults to 0.0.0.0/0, use `kubectl get endpoints -n default kubernetes` to get the CIDR range needed for your cluster Must be an IP CIDR range (x.x.x.x/x - ideally with /32 for the specific IP of a single endpoint, broader range for multiple masters/endpoints) Used by package NetworkPolicies to allow Kube API access |
| networkPolicies.additionalPolicies | list | `[]` |  |
| networkPolicies.egress | object | `{}` | NetworkPolicy selectors and ports for egress to downstream telemetry ingestion services. These should be uncommented and overridden if any of these values deviate from the Big Bang defaults. |
| autoRollingUpgrade.enabled | bool | `true` |  |
| autoRollingUpgrade.image.repository | string | `"registry1.dso.mil/ironbank/big-bang/base"` |  |
| autoRollingUpgrade.image.tag | string | `"2.1.0"` |  |
| istio.enabled | bool | `false` | Toggle istio configuration |
| istio.hardened | object | `{"customServiceEntries":[],"enabled":false,"outboundTrafficPolicyMode":"REGISTRY_ONLY"}` | Default peer authentication values |
| istio.mtls.mode | string | `"STRICT"` | STRICT = Allow only mutual TLS traffic, PERMISSIVE = Allow both plain text and mutual TLS traffic |

## Contributing

Please see the [contributing guide](./CONTRIBUTING.md) if you are interested in contributing.

---

_This file is programatically generated using `helm-docs` and some BigBang-specific templates. The `gluon` repository has [instructions for regenerating package READMEs](https://repo1.dso.mil/big-bang/product/packages/gluon/-/blob/master/docs/bb-package-readme.md)._

