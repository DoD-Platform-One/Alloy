# Changelog

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [3.2.1-bb.0] (2025-07-31)
### Changed
- k8s-monitoring updated from 3.0.2 to 3.2.1
- gluon updated from 0.6.2 to 0.7.0
- registry1.dso.mil/ironbank/opensource/grafana/alloy updated from v1.8.3 to v1.10.0
- registry1.dso.mil/ironbank/opensource/prometheus-operator/prometheus-config-reloader updated from v0.82.2 to v0.84.0

## [3.0.2-bb.0] (2025-06-23)
### Changed
- k8s-monitoring updated from 2.0.27 to 3.0.2
- gluon updated from 0.5.18 to 0.6.2
- prometheus-config-reloader updated from v0.82.1 to v0.82.2

## [2.0.27-bb.3] (2025-06-10)
### Fixed
- Update upgrade helper template logic for scenarios where helmRelease status.history is not yet populated and is nil

## [2.0.27-bb.2] (2025-05-12)
### Fixed
- Fixed flaky cypress tests by enabling alloy-logs at Big Bang level

## [2.0.27-bb.1] (2025-05-12)
### Added
- Cypress testing for prometheus service monitors

## [2.0.27-bb.0] (2025-05-12)
### Changed
- k8s-monitoring updated from 2.0.26 to 2.0.27
- gluon updated from 0.5.15 to 0.5.18
- alloy updated from v1.8.1 to v1.8.3
- prometheus-config-reloader updated from v0.81.0 to v0.82.1

### Removed
- Removed destinations from the values.yaml, as the values are now set by the Big Bang umbrella chart.

## [2.0.26-bb.1] (2025-05-12)
### Added
- Added seLinuxOptions securityContext type "spc_t" for alloy-logs to support SELinux enabled systems

## [2.0.26-bb.0] (2025-04-22)
### Changed
- k8s-monitoring updated from 2.0.23 to 2.0.26
- Changed jimmidyson/configmap-reload:v0.15.0 to opensource/prometheus-operator/prometheus-config-reloader:v0.81.0

## [2.0.23-bb.0] (2025-04-10)
### Added
- Added network policy allowing Prometheus to scrape istio sidecars
- Added network policy allowing Prometheus to scrape alloy pods

### Changed
- k8s-monitoring updated from 2.0.16 to 2.0.23
- gluon updated from 0.5.14 to 0.5.15
- alloy updated from v1.7.1 to v1.7.5
- configmap-reloader updated from v0.14.0 to v0.15.0

## [2.0.16-bb.4] (2025-04-08)
### Changed
- Moved the k8s-monitoring.integrations logic out of the default chart values so that alloy-metrics can be optionally disabled
- Disabled alloy-metrics by default

## [2.0.16-bb.3] (2025-04-01)
### Added
- Added dynamic NetworkPolicy support for Istio operatorless

## [2.0.16-bb.2] (2025-03-21)
### Added
- Added `alloy-logs` and `podLogs` configurations to send logs to Loki

### Changed
- Disabled alloyReceiver and applicationObservability features by default.

## [2.0.16-bb.1] (2025-03-18)
### Added
- Upgrade job that removes any lingering resources in the monitoring namespace after migrating to its own namespace
- Modified netpol/authpol labels from `app.kubernetes.io/name: alloy-metrics` to `app.kubernetes.io/instance: alloy`

## [2.0.16-bb.0] (2025-03-07)
### Changed
- k8s-monitoring updated from 2.0.4 to 2.0.16
- Alloy updated from 1.5.1 to 1.7.1
- configmap-reload updated from v0.12.0 to v0.14.0

## [2.0.4-bb.1] - 2025-02-20
### Changed
- add default value of enableReporting to false to disable reaching out to internet

## [2.0.4-bb.0] - 2025-02-06
### Changed
- k8s-monitoring updated from 1.6.18 to 2.0.4
- Added Network Policy to allow Alloy ingress to Alloy Deployment
- Migrated the values.yaml from 1.x.x to 2.0.4

## [1.16.18-bb.0] - 2025-01-10
### Changed
- k8s-monitoring updated from 1.6.16 to 1.6.18

## [1.6.16-bb.0] - 2024-12-24
### Changed
- k8s-monitoring updated from 1.6.15 to 1.6.16

## [1.6.15-bb.0] - 2024-12-19
### Changed

- k8s-monitoring updated from 1.6.13-bb.0 to 1.6.15
## [1.6.13-bb.0] - 2024-12-06
### Changed
- ironbank/opensource/grafana/alloy updated from v1.4.2 to v1.5.1

## [1.6.12-bb.0] - 2024-12-02
### Changed
- k8s-monitoring updated from 1.6.4 to 1.6.12

## [1.6.4-bb.1] - 2024-11-18
### Changed
- Updates to renovate to fix dependency versions (script is in renovate-runner)

## [1.6.4-bb.2] - 2024-11-22
### Changed
- Fixed the maintenance track annotation

## [1.6.4-bb.1] - 2024-11-21
### Changed
- Added maintenance track badge and annotation

## [1.6.4-bb.0] - 2024-11-02
### Changed
- k8s-monitoring updated from 1.6.0 to 1.6.4

## [1.6.0-bb.0] - 2024-10-22
### Changed
- k8s-monitoring updated from 1.5.4 to 1.6.0
- gluon updated from 0.5.4 to 0.5.8
- ironbank/opensource/grafana/alloy updated from v1.3.1 to v1.4.2

## [1.5.4-bb.1] - 2024-10-21

### Changed
- Fixed quotation in chart.yaml

## [1.5.4-bb.0] - 2024-10-07

### Changed
- gluon updated from 0.5.3 to 0.5.4
- k8s-monitoring updated from 1.5.0 to 1.5.4

## [1.5.0-bb.7] - 2024-10-01

### Added

- Fix renovate json to remove upgradeCommands from helm datasource and fix regex to find alloy annotations version

## [1.5.0-bb.6] - 2024-09-30

### Added

- Added helm templating tests for Alloy StatefulSet

## [1.5.0-bb.5] - 2024-09-24

### Changes

- Disabled configAnalysis and test job to confirm with securityContext Kyverno Policy

## [1.5.0-bb.4] - 2024-09-19

### Changes

- Updated links and documenataion to reference dependency chart values

## [1.5.0-bb.3] - 2024-09-16

### Added

- Added a new `NetworkPolicy` for OTLP ingress into alloy from any source

### Changes

- Updated bundled `values.yaml` to set prometheus write path to `/api/v1/write`

## [1.5.0-bb.2] - 2024-09-12

### Changes

- fix image version

## [1.5.0-bb.1] - 2024-09-12

### Changes

- Configure Security Context for pods to comply with kyverno-policies

## [1.5.0-bb.0] - 2024-09-09

### Changes

- migrated alloy install from forked alloy chart for k8s-monitoring wrapper chart

## [0.6.1-bb.1] - 2024-08-30

### Added

- Add istio sidecar for egress whitelist

## [0.6.1-bb.0] - 2024-08-29

### Enhancements

- Add the ability to set --cluster.name in the Helm chart with alloy.clustering.name.

## [0.6.0-bb.2] - 2024-08-27

### Changed

- ironbank/opensource/grafana/alloy updated from v1.3.0 to v1.3.1

## [0.6.0-bb.1] - 2024-08-22

### Added

- Add istio mTLS PeerAuthentication

## [0.6.0-bb.0] - 2024-08-14

### Changed

- gluon updated from 0.5.0 to 0.5.3
- ironbank/opensource/grafana/alloy updated from v1.2.1 to v1.3.0

## [0.5.1-bb.5] - 2024-08-13

### Added

- Add DEVELOPMENT_MAINTENANCE document

## [0.5.1-bb.4] - 2024-08-12

### Added

- Add barebones istio authorization policy

## [0.5.1-bb.3] - 2024-08-12

### Added

- Add support for Renovate

## [0.5.1-bb.2] - 2024-08-08

### Added

- Big Bang labels for Kiali

## [0.5.1-bb.1] - 2024-08-07

### Added

- Set the Container Security Context `runAsNonRoot: true`, `runAsGroup/User: 473`, and `capabilities: drop: [ALL]`
- Add README.md

## [0.5.1-bb.3] - 2024-08-12

### Added

- Add support for Renovate

## [0.5.1-bb.2] - 2024-08-08

### Added

- Big Bang labels for Kiali

## [0.5.1-bb.1] - 2024-08-07

### Added

- Set the Container Security Context `runAsNonRoot: true`, `runAsGroup/User: 473`, and `capabilities: drop: [ALL]`
- Add README.md

## [0.5.1-bb.0] - 2024-07-23

### Initial

- Pull latest chart with kpt
- Point Grafana Alloy repo/image reference to ironbank
