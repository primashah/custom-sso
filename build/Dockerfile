FROM registry.access.redhat.com/redhat-sso-7/sso72-openshift:1.2

 USER root

 RUN mkdir -p /providers

#COPY dependencies/sms-authenticator.jar /providers
RUN mkdir -p /opt/eap/providers
COPY dependencies/sms-authenticator.jar  /opt/eap/providers


RUN mkdir -p /opt/eap/themes/openstandia
COPY dependencies/themes/openstandia /opt/eap/themes/openstandia

# COPY dependencies/module.xml /opt/eap/modules/system/layers/openshift/com/oracle/main

# COPY dependencies/ojdbc8.jar /opt/eap/modules/system/layers/openshift/com/oracle/main

# COPY dependencies/custom-theme.jar /opt/eap/standalone/deployments

# COPY dependencies/jdbc-storage-spi-jar-with-dependencies.jar /opt/eap/standalone/deployments

# RUN cp /opt/eap/standalone/configuration/standalone-openshift.xml /opt/eap/standalone/configuration/standalone-openshift.original

# COPY dependencies/standalone-openshift-base-oracle.xml /opt/eap/standalone/configuration/standalone-openshift.xml

# RUN cp /opt/eap/bin/launch/openshift-common.sh /opt/eap/bin/launch/openshift-common.original

# COPY dependencies/openshift-common.sh /opt/eap/bin/launch/openshift-common.sh

 RUN chmod 755 /opt/eap/bin/launch/openshift-common.sh

 USER 1001