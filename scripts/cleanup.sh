#!/bin/sh
# Script to delete all ESGF Kubernetes objects

kubectl delete deployment,svc,statefulset -l stack=esgf
kubectl delete secrets esgf-auth-secrets esgf-cog-secrets esgf-hostcert esgf-postgres-secrets esgf-slcs-ca esgf-tds-secrets esgf-slcs-secrets
kubectl delete configmap esgf-config esgf-trust-bundle