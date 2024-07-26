# POC Deployment Framework for Grafana Alloy Sandbox

## Upstream Big Bang Repo

Upstream Big Bang branch for Grafana Alloy is [epic-347/grafana-alloy-sandbox](https://repo1.dso.mil/big-bang/bigbang/-/tree/epic-347/grafana-alloy-sandbox?ref_type=heads). 

**IMPORTANT:** The `epic-347/grafana-alloy-sandbox` should be treated as the Development branch where no direct commits are made against the branch other than MRs. No direct commit should be taken on the `epic-347/grafana-alloy-sandbox`. The process for MR to the branch should:

1. Create a branch.
2. Make changes to the new branch.
3. Create a MR with the Observability team as the Reviewers.
4. Approve and merge branch.

## Test values.yaml
A basic test values

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
    #   branch: "<test-branch>"
    enabled: true
    # values:
    #   istio: # Waiting on istio issues completion before enabling
    #     enabled: true
    #     hardened:
    #       enabled: true

kyverno:
  enabled: false # waiting on issue- https://repo1.dso.mil/big-bang/apps/sandbox/grafana-alloy/-/issues/24

kyvernoPolicies:
  enabled: false  # waiting on issue- https://repo1.dso.mil/big-bang/apps/sandbox/grafana-alloy/-/issues/24
#   values:
#     exclude:
#       any:
#       # Allows k3d load balancer to bypass policies.
#       - resources:
#           namespaces:
#           - istio-system
#           names:
#           - svclb-*
#     policies:
#       restrict-host-path-mount-pv:
#         parameters:
#           allow:
#           - /var/lib/rancher/k3s/storage/pvc-*
```
