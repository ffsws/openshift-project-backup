# Export all Cluster API Ressources to a PV

## Installation
Example for using it on OpenShift 3.9:
```
oc process -f template-backup-cronjob.yaml \
-p JOB_NAME="cronjob-project-backup" \
-p SCHEDULE="0 6,18 * * *"  \
-p JOB_SERVICE_ACCOUNT="project-backup" \
-p NAMESPACE="project-backup" \
-p IMAGE="registry.access.redhat.com/openshift3/jenkins-slave-base-rhel7" \
-p IMAGE_TAG="v3.11" \
-p STORAGE_SIZE="1G" \
-p DEADLINE=3600 \
-p CRONJOB_API="batch/v1beta1" \
| oc apply -f -
```

| Parameter  | Description | Defaults | 
| ------------- | ------------- | ------------- |
| JOB_NAME  | Name of the Scheduled Job to Create | cronjob-project-backup |
| SCHEDULE  | Cron Schedule to Execute the Job | 0 6,18 * * * |
| JOB_SERVICE_ACCOUNT  | Name of the Service Account To Exeucte the Job As | project-backup |
| NAMESPACE  | Name of the Namespace where to deploy the Scheduled Job | project-backup |
| IMAGE  | Image to use for the container | registry.access.redhat.com/openshift3/jenkins-slave-base-rhel7 |
| IMAGE_TAG  | Image Tag to use for the container. Needs to be at least 3.11  | v3.11 |
| STORAGE_SIZE  | Size of the Persistent Volume  | 1G |
| DEADLINE  | Duration of the job runtime  | 3600 | 
| CRONJOB_API  | API Version to use for cronjob | batch/v1beta1 |

## Restore

## Known Issues
- Backup can be slow and takes up to 20s per project
