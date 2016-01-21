##
# borrowed liberally from chilcano/wso2am
##

FROM klousiaj/oracle-java:7.79
MAINTAINER J.P. Klousia <klousiaj>

# create a WSO2 user to run the app as.
RUN useradd -ms /bin/bash wso2

ENV WSO2_BUNDLE_NAME wso2das-3.0.0
ENV WSO2_FOLDER_NAME wso2das

# expose the necessary ports to run the API Manager and connect to the H2 DB.
EXPOSE 9163 7714 7614 21004 9446 9766

# unzip the file and move it into place.
RUN wget -q --no-check-certificate -P /opt https://dl.dropboxusercontent.com/s/zo5nqysez4imvoe/${WSO2_BUNDLE_NAME}.zip; \
unzip /opt/${WSO2_BUNDLE_NAME}.zip -d /opt/ > /opt/${WSO2_FOLDER_NAME}.listfiles; \
mv /opt/${WSO2_BUNDLE_NAME} /opt/${WSO2_FOLDER_NAME}; \
rm /opt/${WSO2_BUNDLE_NAME}.zip; \
rm /opt/${WSO2_FOLDER_NAME}.listfiles; \
chown -R wso2:wso2 /opt/${WSO2_FOLDER_NAME};

# remove curl/unzip/wget since we don't need them.
RUN apt-get -y remove curl wget unzip

USER wso2

# copy the local assets into place
COPY assets/repository/conf/datasources/master-datasources.xml /opt/${WSO2_FOLDER_NAME}/repository/conf/datasources/master-datasources.xml
COPY assets/repository/deployment/server/carbonapps/API_Manager_Analytics.car /opt/${WSO2_FOLDER_NAME}/repository/deployment/server/carbonapps/API_Manager_Analytics.car
COPY assets/repository/components/lib/mysql-connector-java-5.1.38-bin.jar /opt/${WSO2_FOLDER_NAME}/repository/components/lib/mysql-connector-java-5.1.38-bin.jar

ENV JAVA_HOME /usr/java/default

# Working Directory in Container
WORKDIR /opt/${WSO2_FOLDER_NAME}/bin/

# Start WSO2-DAS
CMD sh ./wso2server.sh -DportOffset=3