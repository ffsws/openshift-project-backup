Export all Cluster API Ressources to a PVC

```
oc process -f template-backup-cronjob.yaml -p SCHEDULE="* * * * *" | oc apply -f -
```
