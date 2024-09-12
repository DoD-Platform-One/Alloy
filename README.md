<!-- Warning: Do not manually edit this file. See notes on gluon + helm-docs at the end of this file for more information. -->
# k8s-monitoring

![Version: 1.5.0-bb.1](https://img.shields.io/badge/Version-1.5.0--bb.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 2.8.1](https://img.shields.io/badge/AppVersion-2.8.1-informational?style=flat-square)

A Helm chart for gathering, scraping, and forwarding Kubernetes telemetry data to a Grafana Stack.

## Upstream References

* <https://github.com/grafana/k8s-monitoring-helm/tree/main/charts/k8s-monitoring>

### Upstream Release Notes

- [Find our upstream chart's CHANGELOG here](https://github.com/grafana/k8s-monitoring-helm/releases/)
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
helm install k8s-monitoring chart/
```

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| k8s-monitoring.cluster.name | string | `"bigbang"` |  |
| k8s-monitoring.global.image.registry | string | `"registry1.dso.mil"` |  |
| k8s-monitoring.global.image.pullSecrets[0].name | string | `"private-registry"` |  |
| k8s-monitoring.global.podSecurityContext.runAsUser | int | `473` |  |
| k8s-monitoring.global.podSecurityContext.runAsGroup | int | `473` |  |
| k8s-monitoring.global.podSecurityContext.fsGroup | int | `473` |  |
| k8s-monitoring.global.podSecurityContext.runAsNonRoot | bool | `true` |  |
| k8s-monitoring.global.podSecurityContext.seccompProfile.type | string | `"RuntimeDefault"` |  |
| k8s-monitoring.externalServices.prometheus.host | string | `"monitoring-monitoring-kube-prometheus.monitoring.svc.cluster.local:9090"` |  |
| k8s-monitoring.externalServices.prometheus.authMode | string | `"none"` |  |
| k8s-monitoring.externalServices.loki.host | string | `"logging-loki.logging.svc.cluster.local:3100"` |  |
| k8s-monitoring.externalServices.loki.authMode | string | `"none"` |  |
| k8s-monitoring.externalServices.tempo.host | string | `"tempo-tempo.tempo.svc.cluster.local:4317"` |  |
| k8s-monitoring.externalServices.tempo.authMode | string | `"none"` |  |
| k8s-monitoring.externalServices.tempo.tls.insecure | bool | `true` |  |
| k8s-monitoring.alloy.image.repository | string | `"ironbank/opensource/grafana/alloy"` |  |
| k8s-monitoring.alloy.configReloader.image.repository | string | `"ironbank/opensource/jimmidyson/configmap-reload"` |  |
| k8s-monitoring.alloy.configReloader.securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| k8s-monitoring.alloy.alloy.securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| k8s-monitoring.alloy.controller.securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| k8s-monitoring.alloy-logs.image.repository | string | `"ironbank/opensource/grafana/alloy"` |  |
| k8s-monitoring.alloy-logs.configReloader.image.repository | string | `"ironbank/opensource/jimmidyson/configmap-reload"` |  |
| k8s-monitoring.alloy-logs.configReloader.securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| k8s-monitoring.alloy-logs.alloy.securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| k8s-monitoring.alloy-logs.controller.securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| k8s-monitoring.alloy-events.image.repository | string | `"ironbank/opensource/grafana/alloy"` |  |
| k8s-monitoring.alloy-events.configReloader.image.repository | string | `"ironbank/opensource/jimmidyson/configmap-reload"` |  |
| k8s-monitoring.alloy-events.configReloader.securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| k8s-monitoring.alloy-events.alloy.securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| k8s-monitoring.alloy-events.controller.securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| k8s-monitoring.traces.enabled | bool | `true` |  |
| k8s-monitoring.logs.cluster_events.enabled | bool | `false` |  |
| k8s-monitoring.logs.pod_logs.enabled | bool | `false` |  |
| k8s-monitoring.metrics.enabled | bool | `true` |  |
| k8s-monitoring.metrics.serviceMonitors.enabled | bool | `false` |  |
| k8s-monitoring.prometheus-operator-crds.enabled | bool | `false` |  |
| k8s-monitoring.kube-state-metrics.enabled | bool | `false` |  |
| k8s-monitoring.prometheus-node-exporter.enabled | bool | `false` |  |
| k8s-monitoring.opencost.enabled | bool | `false` |  |
| configValidator.enabled | bool | `false` |  |
| networkPolicies.enabled | bool | `false` | Toggle networkPolicies |
| networkPolicies.controlPlaneCidr | string | `"0.0.0.0/0"` | Control Plane CIDR, defaults to 0.0.0.0/0, use `kubectl get endpoints -n default kubernetes` to get the CIDR range needed for your cluster Must be an IP CIDR range (x.x.x.x/x - ideally with /32 for the specific IP of a single endpoint, broader range for multiple masters/endpoints) Used by package NetworkPolicies to allow Kube API access |
| networkPolicies.egress | object | `{}` | NetworkPolicy selectors and ports for egress to downstream telemetry ingestion services. These should be uncommented and overridden if any of these values deviate from the Big Bang defaults. |
| networkPolicies.additionalPolicies | list | `[]` |  |
| istio.enabled | bool | `false` |  |
| istio.hardened | object | `{"customServiceEntries":[],"enabled":false,"outboundTrafficPolicyMode":"REGISTRY_ONLY"}` | Default peer authentication values |
| istio.mtls.mode | string | `"STRICT"` | STRICT = Allow only mutual TLS traffic, PERMISSIVE = Allow both plain text and mutual TLS traffic |

## Contributing

Please see the [contributing guide](./CONTRIBUTING.md) if you are interested in contributing.

---

_This file is programatically generated using `helm-docs` and some BigBang-specific templates. The `gluon` repository has [instructions for regenerating package READMEs](https://repo1.dso.mil/big-bang/product/packages/gluon/-/blob/master/docs/bb-package-readme.md)._

