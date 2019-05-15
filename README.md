Export all Cluster API Ressources to a PVC

Example for using it on OpenShift 3.9 (using oc 3.11 to get all available API Objects):
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
