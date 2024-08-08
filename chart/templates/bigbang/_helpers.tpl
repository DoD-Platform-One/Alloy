{{/*
Bigbang labels
*/}}
{{- define "bigbang.labels" -}}
app: {{ include "alloy.name" . }}
{{- if .Chart.AppVersion }}
version: {{ .Chart.AppVersion | quote }}
{{- end }}
{{- end }}
