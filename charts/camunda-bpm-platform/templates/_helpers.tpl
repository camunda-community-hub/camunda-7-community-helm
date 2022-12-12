{{/*
Expand the name of the chart.
*/}}
{{- define "camunda-bpm-platform.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
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
{{- define "camunda-bpm-platform.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "camunda-bpm-platform.labels" -}}
{{- if .Values.global.labels -}}
{{ toYaml .Values.global.labels }}
{{- end }}
helm.sh/chart: {{ include "camunda-bpm-platform.chart" . }}
{{ include "camunda-bpm-platform.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Common match labels, which are extended by sub-charts and should be used in matchLabels selectors.
*/}}
{{- define "camunda-bpm-platform.matchLabels" -}}
{{/*
{{- if .Values.global.labels -}}
{{ toYaml .Values.global.labels }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/part-of: camunda-platform
*/}}
app.kubernetes.io/name: {{ template "camunda-bpm-platform.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "camunda-bpm-platform.selectorLabels" -}}
app.kubernetes.io/name: {{ include "camunda-bpm-platform.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Set imagePullSecrets according the values of global, subchart, or empty.
*/}}
{{- define "camunda-bpm-platform.imagePullSecrets" -}}
{{- if (.Values.image.pullSecrets) -}}
{{ .Values.image.pullSecrets | toYaml }}
{{- else if (.Values.global.image.pullSecrets) -}}
{{ .Values.global.image.pullSecrets | toYaml }}
{{- else -}}
[]
{{- end -}}
{{- end -}}

{{/*
Keycloak service name should be a max of 20 char since the Keycloak Bitnami Chart is using Wildfly, the node identifier in WildFly is limited to 23 characters.
Furthermore, this allows changing the referenced Keycloak name inside the sub-charts.
Subcharts can't access values from other sub-charts or the parent, global only. This is the reason why we have a global value to specify the Keycloak full name.
*/}}

{{- define "camunda-bpm-platform.issuerBackendUrl" -}}
    {{- $keycloakRealmPath := "/auth/realms/camunda-platform" -}}
    {{- if .Values.global.identity.keycloak.url -}}
        {{- include "identity.keycloak.url" . -}}{{- $keycloakRealmPath -}}
    {{- else -}}
        http://{{ include "common.names.dependency.fullname" (dict "chartName" "keycloak" "chartValues" . "context" $) | trunc 20 | trimSuffix "-" }}:80{{ $keycloakRealmPath }}
    {{- end -}}
{{- end -}}

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
Check if H2 database is used
Note that Helm template always retruns string, so this is not really a bool.
*/}}
{{- define "camunda-bpm-platform.h2DatabaseIsUsed" -}}
{{- if (hasPrefix "jdbc:h2" .Values.database.url) -}}
true
{{- else -}}
false
{{- end }}
{{- end }}

{{/*
Check if the deployment will have volumes
Note that Helm template always retruns string, so this is not really a bool.
*/}}
{{- define "camunda-bpm-platform.withVolumes" -}}
{{ if or (eq (include "camunda-bpm-platform.h2DatabaseIsUsed" .) "true") (not (empty .Values.extraVolumeMounts)) (not (empty .Values.extraVolumes)) -}}
true
{{- else -}}
false
{{- end }}
{{- end }}

{{/*
Return the appropriate apiVersion for ingress according to Kubernetes version.
*/}}
{{- define "camunda-bpm-platform.ingress.apiVersion" -}}
{{- if .Values.ingress.enabled -}}
{{- if semverCompare "<1.14-0" .Capabilities.KubeVersion.Version -}}
{{- print "extensions/v1beta1" -}}
{{- else if semverCompare "<1.19-0" .Capabilities.KubeVersion.Version -}}
{{- print "networking.k8s.io/v1beta1" -}}
{{- else -}}
{{- print "networking.k8s.io/v1" -}}
{{- end }}
{{- end }}
{{- end }}
