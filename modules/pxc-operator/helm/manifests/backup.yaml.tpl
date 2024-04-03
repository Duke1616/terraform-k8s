backup:
  enabled: ${backup_enabled}
  pitr:
    enabled: ${backup_pitr_enabled}
    storageName: s3-binlogs
    timeBetweenUploads: 60
  storages:
    s3-backup:
      type: s3
      verifyTLS: false
      s3:
        bucket: mysql-backups
        credentialsSecret: ${backup_minio_secret_name}
        region: us-west-2
        endpointUrl: http://${backup_minio_api_access}
    s3-binlogs:
      type: s3
      verifyTLS: false
      s3:
        bucket: mysql-binlogs
        credentialsSecret: ${backup_minio_secret_name}
        region: us-west-2
        endpointUrl: http://${backup_minio_api_access}
  schedule:
    - name: "daily-backup"
      schedule: "00 00 * * *"
      keep: 5
      storageName: s3-backup
