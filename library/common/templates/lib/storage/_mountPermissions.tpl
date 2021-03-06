{{/*
This template serves as the blueprint for the mountPermissions job that is run
before chart installation.
*/}}
{{- define "common.storage.permissions" -}}
{{- if and .Values.appVolumeMounts .Values.fixMountPermissions }}
{{- range $name, $avm := .Values.appVolumeMounts -}}
{{- if and $avm.enabled $avm.setPermissions}}
{{- print "---" | nindent 0 -}}

{{- $VMValues := $avm -}}
{{- if not $VMValues.nameSuffix -}}
  {{- $_ := set $VMValues "nameSuffix" $name -}}
{{ end -}}
{{- $_ := set $ "ObjectValues" (dict "appVolumeMounts" $VMValues) -}}

{{ include "common.storage.permissions.job" $  | nindent 0 }}
{{- end }}
{{- end }}
{{- end }}
{{- end }}
