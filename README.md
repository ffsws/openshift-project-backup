# OpenShift Project Backup
Simple OpenShift Cronjob that exports all available API resources in YAML format to a Persistent Volume.

## Requirements
python >= 2.7
openshift >= 0.6
PyYAML >= 3.11

## Installation
Tested on OpenShift 3.9, 3.10, 3.11

```
ansible-playbook playbook.yml \
-e openshift_project_backup_job_name="cronjob-project-backup" \
-e openshift_project_backup_schedule="0 6,18 * * * "
-e openshift_project_backup_job_service_account="project-backup"
-e openshift_project_backup_namespace="project-backup"
-e openshift_project_backup_image="registry.access.redhat.com/openshift3/jenkins-slave-base-rhel7"
-e openshift_project_backup_image_tag="v3.11"
-e openshift_project_backup_storage_size="1G"
-e openshift_project_backup_deadline="3600"
-e openshift_project_backup_cronjob_api="batch/v1beta1"

```

| Parameter  | Description | Defaults |
| ------------- | ------------- | ------------- |
| openshift_project_backup_job_name | Name of the Scheduled Job to Create | cronjob-project-backup |
| openshift_project_backup_schedule | Cron Schedule to Execute the Job | 0 6,18 * * * |
| openshift_project_backup_job_service_account | Name of the Service Account To Execute the Job As | project-backup |
| openshift_project_backup_namespace | Name of the Namespace where to deploy the Scheduled Job | project-backup |
| openshift_project_backup_image | Image to use for the container | registry.access.redhat.com/openshift3/jenkins-slave-base-rhel7 |
| openshift_project_backup_image_tag | Image Tag to use for the container. Needs to be at least 3.11  | v3.11 |
| openshift_project_backup_storage_size | Size of the Persistent Volume  | 1G |
| openshift_project_backup_deadline | Duration of the job runtime  | 3600 |
| openshift_project_backup_cronjob_api | API Version to use for cronjob | batch/v1beta1 |

## Restore
In order to restore OpenShift resources, the corresponding volume must be mounted. Subsequently the resources can be restored with the oc `apply -f` or `oc create -f` commands.
