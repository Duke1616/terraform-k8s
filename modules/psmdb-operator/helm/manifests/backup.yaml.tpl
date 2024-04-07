%{ for _, minio in jsondecode(backup_minio_bucket_json) }
backup:
  enabled: ${backup_enabled}
  image:
    repository: percona/percona-backup-mongodb
    tag: 2.3.0
  serviceAccountName: percona-server-mongodb-operator
  resources:
    limits:
      cpu: "300m"
      memory: "0.5G"
    requests:
      cpu: "300m"
      memory: "0.5G"
  storages:
    ${minio.backup.storageName}:
      type: s3
      s3:
        bucket: ${minio.backup.bucket}
        region: us-east-1
        credentialsSecret: ${backup_minio_secret_name}
        endpointUrl: http://${backup_minio_api_access}
  pitr:
    enabled: ${backup_pitr_enabled}
    oplogOnly: false
    oplogSpanMin: 10
    compressionType: gzip
    compressionLevel: 6
  tasks:
    - name: daily-s3-us-west
      enabled: true
      schedule: "*/10 * * * *"
      keep: 3
      storageName: ${minio.backup.storageName}
%{ endfor }
