# OpenShift Project Backup
Simple OpenShift Cronjob that exports all available API resources in YAML format to a Persistent Volume.

## Installation
Tested on OpenShift 3.9, 3.10, 3.11

```
oc process -f template-backup-cronjob.yaml \
-p SCHEDULE="0 2,12 * * *"  \
-p NAMESPACE="project-backup" \
-p STORAGE_SIZE="1G" \
-p DEADLINE=3600 \
| oc apply -f -
```

| Parameter  | Description | Defaults |
| ------------- | ------------- | ------------- |
| JOB_NAME  | Name of the Scheduled Job to Create | cronjob-project-backup |
| SCHEDULE  | Cron Schedule to Execute the Job | 0 6,18 * * * |
| JOB_SERVICE_ACCOUNT  | Name of the Service Account To Execute the Job As | project-backup |
| NAMESPACE  | Name of the Namespace where to deploy the Scheduled Job | project-backup |
| IMAGE  | Image to use for the container | registry.access.redhat.com/openshift3/jenkins-slave-base-rhel7 |
| IMAGE_TAG  | Image Tag to use for the container. Needs to be at least 3.11  | v3.11 |
| STORAGE_SIZE  | Size of the Persistent Volume  | 1G |
| DEADLINE  | Duration of the job runtime  | 3600 |
| CRONJOB_API  | API Version to use for cronjob | batch/v1beta1 |

## Restore
In order to restore OpenShift resources, the corresponding volume must be mounted. Subsequently the resources can be restored with the oc `apply -f` or `oc create -f` commands.

## Known Issues
- Running at least OpenShift 3.11 oc client inside container to fetch a list of available API Ressources
- Backup can be slow and takes up to 20s per project
