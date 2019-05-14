#!/bin/bash
BACKUP_DIR="/backup"
BACKUP_DIR_WITH_DATE=${BACKUP_DIR}_$(date +%Y%m%d%H%M)

### Setup
mkdir -p $BACKUP_DIR_WITH_DATE

# Backup all resources of every project
for project in $(oc get projects --no-headers | awk '{print $1}')
do
    echo -n "Backing up project $project... "
    mkdir -p ${BACKUP_DIR_WITH_DATE}/projects/${project}
    oc export all -o json -n ${project} > ${BACKUP_DIR_WITH_DATE}/projects/${project}/project.json 2>/dev/null
    oc export rolebindings -o json -n ${project} > ${BACKUP_DIR_WITH_DATE}/projects/${project}/rolebindings.json 2>/dev/null
    oc get serviceaccount -o json --export=true -n ${project} > ${BACKUP_DIR_WITH_DATE}/projects/${project}/serviceaccount.json 2>/dev/null
    oc get configmap -o json --export=true -n ${project} > ${BACKUP_DIR_WITH_DATE}/projects/${project}/configmap.json 2>/dev/null
    oc get daemonset -o json --export=true -n ${project} > ${BACKUP_DIR_WITH_DATE}/projects/${project}/daemonset.json 2>/dev/null
    oc get secret -o json --export=true -n ${project} > ${BACKUP_DIR_WITH_DATE}/projects/${project}/secret.json 2>/dev/null
    oc get pvc -o json --export=true -n ${project} > pvc.json 2>/dev/null
    echo "done."
done
