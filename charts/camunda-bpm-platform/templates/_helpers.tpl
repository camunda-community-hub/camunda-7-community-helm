{{/*
Expand the name of the chart.
*/}}
{{- define "camunda-bpm-platform.name" -}}
{{- default .Chart.Name .Values.general.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "camunda-bpm-platform.fullname" -}}
{{- if .Values.general.fullnameOverride }}
{{- .Values.general.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.general.nameOverride }}
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
{{- define "camunda-bpm-platform.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "camunda-bpm-platform.labels" -}}
helm.sh/chart: {{ include "camunda-bpm-platform.chart" . }}
{{ include "camunda-bpm-platform.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "camunda-bpm-platform.selectorLabels" -}}
app.kubernetes.io/name: {{ include "camunda-bpm-platform.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "camunda-bpm-platform.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "camunda-bpm-platform.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}



{{/*
The name for secret to create in which the authentication data for DB connection is stored
*/}}
{{- define "camunda-bpm-platform.database.external.credentialsSecretName" -}}

{{- default .Values.database.external.credentialsSecretName (include "camunda-bpm-platform.name" . )}}-external-credentials
{{- end }}



{{/*
Connection string for external database if used managed DB
*/}}
{{- define "camunda-bpm-platform.database.external.url" -}}

    {{- if .Values.database.external.enabled -}}

        
        {{- if index .Values.tags "managed-postgresql" -}}

            {{- printf "jdbc:postgresql://%s-postgresql:%d/%s" .Release.Name  (.Values.postgresql.postgresqlPort | int )  .Values.postgresql.postgresqlDatabase  -}}
            
        {{- else if index .Values.tags "managed-mysql" -}}

            {{- printf "jdbc:mysql://%s-mysql:%d/%s" .Release.Name  (.Values.mysql.port | int )  .Values.mysql.auth.database  -}}
        
        {{- end -}}

    {{- end -}}
{{- end -}}

{{/* Driver to connect to external DB */}}
{{- define "camunda-bpm-platform.database.external.driver" -}}

    {{- if .Values.database.external.enabled -}}
        
        {{- if index .Values.tags "managed-postgresql" -}}
            {{- printf "org.postgresql.Driver"  -}}
        {{- else if index .Values.tags "managed-mysql" -}}
            {{- printf "com.mysql.cj.jdbc.Driver"  -}}
        {{- end -}}

    {{- end -}}
{{- end -}}