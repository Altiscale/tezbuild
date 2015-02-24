#!/bin/sh -ex
# compile and package the Tez
mvn package -Dtar -Dhadoop.version=${HADOOP_VERSION} -DskipTests -Dmaven.javadoc.skip=true
