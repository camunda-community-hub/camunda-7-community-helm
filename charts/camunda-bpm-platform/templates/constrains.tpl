{{/*
A template to handel constrains.
*/}}

{{/*
Fail in case H2 database is used and replicaCount is more than "1".
*/}}
{{- if eq (include "camunda-bpm-platform.h2DatabaseIsUsed" .) "true" }}
{{- if gt (.Values.general.replicaCount | int) 1 }}
    {{ fail "Deployment replicaCount cannot be more than 1 in case H2 database is used."}}
{{- end }}
{{- end }}
