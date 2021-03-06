#!/bin/sh
# Script that creates site-specific data as Kubernetes config maps and secrets

echo "Using ESGF_HOSTNAME=$ESGF_HOSTNAME"

# create configmaps
kubectl create configmap esgf-trust-bundle --from-file=$ESGF_CONFIG/certificates/esg-trust-bundle.pem
kubectl create configmap esgf-config --from-literal=esgf-hostname=$ESGF_HOSTNAME --from-literal=root-admin-email=CoG@$ESGF_HOSTNAME --from-literal=root-admin-openid=https://$ESGF_HOSTNAME/esgf-idp/openid/rootAdmin --from-literal=slcs-url=https://$ESGF_HOSTNAME/esgf-slcs

# create secrets
kubectl create secret tls esgf-hostcert --cert=$ESGF_CONFIG/certificates/hostcert/hostcert.crt --key=$ESGF_CONFIG/certificates/hostcert/hostcert.key
kubectl create secret tls esgf-slcs-ca --cert=$ESGF_CONFIG/certificates/slcsca/ca.crt --key=$ESGF_CONFIG/certificates/slcsca/ca.key

kubectl create secret generic esgf-postgres-esgcet-secrets --from-file=$ESGF_CONFIG/secrets/database-password --from-file=$ESGF_CONFIG/secrets/database-publisher-password
kubectl create secret generic esgf-cog-secrets --from-file=$ESGF_CONFIG/secrets/rootadmin-password --from-file=$ESGF_CONFIG/secrets/cog-secret-key
kubectl create secret generic esgf-auth-secrets --from-file=$ESGF_CONFIG/secrets/auth-database-password --from-file=$ESGF_CONFIG/secrets/auth-secret-key --from-file=$ESGF_CONFIG/secrets/shared-cookie-secret-key
kubectl create secret generic esgf-slcs-secrets --from-file=$ESGF_CONFIG/secrets/slcs-database-password --from-file=$ESGF_CONFIG/secrets/slcs-secret-key
kubectl create secret generic esgf-tds-secrets --from-file=$ESGF_CONFIG/secrets/shared-cookie-secret-key --from-file=$ESGF_CONFIG/secrets/rootadmin-password
kubectl create secret generic esgf-publisher-secrets --from-file=$ESGF_CONFIG/secrets/database-password --from-file=$ESGF_CONFIG/secrets/rootadmin-password