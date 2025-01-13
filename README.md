<!-- Warning: Do not manually edit this file. See notes on gluon + helm-docs at the end of this file for more information. -->
# k8s-monitoring

![Version: 1.6.18-bb.0](https://img.shields.io/badge/Version-1.6.18--bb.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 2.0.1](https://img.shields.io/badge/AppVersion-2.0.1-informational?style=flat-square) ![Maintenance Track: bb_integrated](https://img.shields.io/badge/Maintenance_Track-bb_integrated-green?style=flat-square)

A Helm chart for gathering, scraping, and forwarding Kubernetes telemetry data to a Grafana Stack.

## Upstream References

* <https://github.com/grafana/k8s-monitoring-helm/tree/main/charts/k8s-monitoring-v1>

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
| k8s-monitoring | object | Our overrides are defined in charts/values.yaml file. | See https://github.com/grafana/k8s-monitoring-helm/blob/main/charts/k8s-monitoring-v1/values.yaml for available values. |
| networkPolicies.enabled | bool | `false` | Toggle networkPolicies |
| networkPolicies.controlPlaneCidr | string | `"0.0.0.0/0"` | Control Plane CIDR, defaults to 0.0.0.0/0, use `kubectl get endpoints -n default kubernetes` to get the CIDR range needed for your cluster Must be an IP CIDR range (x.x.x.x/x - ideally with /32 for the specific IP of a single endpoint, broader range for multiple masters/endpoints) Used by package NetworkPolicies to allow Kube API access |
| networkPolicies.additionalPolicies | list | `[]` |  |
| networkPolicies.egress | object | `{}` | NetworkPolicy selectors and ports for egress to downstream telemetry ingestion services. These should be uncommented and overridden if any of these values deviate from the Big Bang defaults. |
| istio.enabled | bool | `false` | Toggle istio configuration |
| istio.hardened | object | `{"customServiceEntries":[],"enabled":false,"outboundTrafficPolicyMode":"REGISTRY_ONLY"}` | Default peer authentication values |
| istio.mtls.mode | string | `"STRICT"` | STRICT = Allow only mutual TLS traffic, PERMISSIVE = Allow both plain text and mutual TLS traffic |

## Contributing

Please see the [contributing guide](./CONTRIBUTING.md) if you are interested in contributing.

---

_This file is programatically generated using `helm-docs` and some BigBang-specific templates. The `gluon` repository has [instructions for regenerating package READMEs](https://repo1.dso.mil/big-bang/product/packages/gluon/-/blob/master/docs/bb-package-readme.md)._

