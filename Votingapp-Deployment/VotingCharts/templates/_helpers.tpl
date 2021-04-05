{{/*
Expand the name of the chart.
*/}}
{{- define "VotingCharts.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "VotingCharts.fullname" -}}
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
{{- define "VotingCharts.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "VotingCharts.labels" -}}
helm.sh/chart: {{ include "VotingCharts.chart" . }}
{{ include "VotingCharts.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app: {{ .Values.applicationName }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "VotingCharts.selectorLabels" -}}
app.kubernetes.io/name: {{ include "VotingCharts.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "VotingCharts.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "VotingCharts.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}


{{- define "VotingCharts.voteapplicationname" -}}
{{- default .Values.applications.voteapp.name | trunc 63 | trimSuffix "-" }}
{{- end}}

{{- define "VotingCharts.resultapplicationname" -}}
{{- default .Values.applications.resultapp.name | trunc 63 | trimSuffix "-" }}
{{- end}}

{{- define "VotingCharts.workerapplicationname" -}}
{{- default .Values.applications.workerapp.name | trunc 63 | trimSuffix "-" }}
{{- end}}

{{- define "VotingCharts.redisapplicationname" -}}
{{- default .Values.applications.redisapp.name | trunc 63 | trimSuffix "-" }}
{{- end}}

{{- define "VotingCharts.postgressapplicationname" -}}
{{- default .Values.applications.postgressapp.name | trunc 63 | trimSuffix "-" }}
{{- end}}