# Changelog

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---
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
- ironbank/opensource/jimmidyson/configmap-reload updated from v0.12.0 to v0.13.1

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
