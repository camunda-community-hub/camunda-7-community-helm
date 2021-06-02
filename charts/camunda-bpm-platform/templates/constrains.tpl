{{/*
A template to handel constrains.
*/}}

{{/*
Fail in case both internal and external database sources set to "true".
*/}}
{{- if and .Values.database.internal.enabled .Values.database.external.enabled }}
    {{ fail "It is not possible to enable both internal and external database source."}}
{{- end }}

{{/*
Fail in case both internal and external database sources set to "false".
*/}}
{{- if not .Values.database.internal.enabled }}
{{- if not .Values.database.external.enabled }}
    {{ fail "A database source should be enabled, either internal or external."}}
{{- end }}
{{- end }}

{{/*
Fail in case internal database is enabled and replicaCount is more than "1".
*/}}
{{- if .Values.database.internal.enabled }}
{{- if gt (.Values.general.replicaCount | int) 1 }}
    {{ fail "Deployment replicaCount cannot be more than 1 in case internal database is used."}}
{{- end }}
{{- end }}

{{/*
Should use either PostgreSQL or MySQL connection driver
*/}}
{{- if not (or (eq .Values.database.external.driver "org.postgresql.Driver")  (eq .Values.database.external.driver "com.mysql.jdbc.Driver") ) -}}
{{ fail "Unrecognized connection driver, use either 'org.postgresql.Driver' or `com.mysql.jdbc.Driver`."}}
{{- end }}

{{/* 
Only one managed database can be used
*/}}

{{- if and (index .Values.tags "managed-postgresql") (index .Values.tags "managed-mysql") -}}

{{ fail "Please choose only one managed database: either Postgres or MySQL, not both" }}
{{- end -}}