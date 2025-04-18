{{- define "alloy.shouldDeployUpgradeResources" -}}
{{/* Define upgradeVersion inside the template so it's available when the template is used */}}
{{- $upgradeVersion := "2.0.16-bb.1" -}}
{{- if and .Values.autoRollingUpgrade.enabled .Release.IsUpgrade -}}
  {{- $helmRelease := lookup "helm.toolkit.fluxcd.io/v2" "HelmRelease" "bigbang" "alloy" -}}
  {{- if $helmRelease -}}
    {{- $currentVersion := index $helmRelease.status.history 0 "chartVersion" -}}
    {{- if semverCompare (print "<" $upgradeVersion) $currentVersion -}}
      true
    {{- end -}}
{{- end -}}
{{- end -}}
{{- end -}}