Export all Cluster API Ressources to a PVC

Example for using it on OpenShift 3.9 (using oc 3.11 to get all available API Objects):
```
oc process -f template-backup-cronjob.yaml \
-p SCHEDULE="* * * * *"  \
-p JOB_NAME="cronjob-project-backup" \
-p JOB_SERVICE_ACCOUNT="project-backup" \
-p NAMESPACE="project-backup" \
-p IMAGE="registry.access.redhat.com/openshift3/jenkins-slave-base-rhel7" \
-p IMAGE_TAG="v3.11" \
| oc apply -f -
```

TODO:
- Add PVC Template
- Handle retention time
