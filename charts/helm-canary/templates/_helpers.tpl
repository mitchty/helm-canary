{{/*
Expand the name of the chart.
*/}}
{{- define "canary.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "canary.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "canary.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "canary.labels" -}}
helm.sh/chart: {{ include "canary.chart" . }}
{{ include "canary.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "canary.selectorLabels" -}}
app.kubernetes.io/name: {{ include "canary.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "canary.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "canary.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the model list
*/}}
{{- define "canary.modelList" -}}
{{- $modelList := default list}}
{{- if .Values.canary.models}}
{{- $modelList = concat $modelList .Values.canary.models }}
{{- end}}
{{- if .Values.canary.defaultModel}}
{{- $modelList = append $modelList .Values.canary.defaultModel }}
{{- end}}
{{- $modelList = $modelList | uniq}}
{{- default (join " " $modelList) -}}
{{- end -}}