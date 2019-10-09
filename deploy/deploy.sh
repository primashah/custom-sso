#!/usr/bin/env bash

export IP=master.na311.openshift.opentlc.com
export APP=custom-sso
export PROJECT=$APP-build

oc login https://${IP} -u prshah-redhat.com -p Fleet1234




oc project $PROJECT

oc policy add-role-to-user view system:serviceaccount:${PROJECT}:default

oc delete secret sso-jgroup-secret sso-ssl-secret sso-app-secret
oc delete dc sso
oc delete svc sso secure-sso sso-ping
oc delete route sso secure-sso


oc create secret generic sso-jgroup-secret --from-file=jgroups.jceks

oc create secret generic sso-ssl-secret --from-file=keystore.jks
oc create secret generic sso-app-secret --from-file=keystore.jks
oc secrets link default sso-jgroup-secret sso-ssl-secret sso-app-secret

oc new-app -f ./sso73-https.json \
 -p HTTPS_SECRET="sso-ssl-secret" \
 -p HTTPS_KEYSTORE="keystore.jks" \
 -p HTTPS_NAME="sso" \
 -p HTTPS_PASSWORD="changeme" \
 -p JGROUPS_ENCRYPT_SECRET="sso-jgroup-secret" \
 -p JGROUPS_ENCRYPT_KEYSTORE="jgroups.jceks" \
 -p JGROUPS_ENCRYPT_NAME="jgroups" \
 -p JGROUPS_ENCRYPT_PASSWORD="changeme" \
 -p SSO_ADMIN_USERNAME="admin" \
 -p SSO_ADMIN_PASSWORD="admin" \
 -p SSO_REALM="demorealm" \
 -p SSO_TRUSTSTORE="datr.eu.jks" \
 -p SSO_TRUSTSTORE_PASSWORD="changeme" \
 -p SSO_TRUSTSTORE_SECRET="sso-app-secret"        