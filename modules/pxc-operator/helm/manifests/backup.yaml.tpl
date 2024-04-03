%{ for _, minio in jsondecode(backup_minio_bucket_json) }
backup:
  enabled: ${backup_enabled}
  pitr:
    enabled: ${backup_pitr_enabled}
    storageName: ${minio.pitr.storageName}
    timeBetweenUploads: 60
  storages:
    ${minio.backup.storageName}:
      type: s3
      verifyTLS: false
      s3:
        bucket: ${minio.backup.bucket}
        credentialsSecret: ${backup_minio_secret_name}
        region: us-east-1
        endpointUrl: http://${backup_minio_api_access}
    ${minio.pitr.storageName}:
      type: s3
      verifyTLS: false
      s3:
        bucket: ${minio.pitr.bucket}
        credentialsSecret: ${backup_minio_secret_name}
        region: us-east-1
        endpointUrl: http://${backup_minio_api_access}
  schedule:
    - name: "daily-backup"
      schedule: "00 00 * * *"
      keep: 5
      storageName: ${minio.backup.storageName}
%{ endfor }
