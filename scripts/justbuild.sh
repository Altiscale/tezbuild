#!/bin/sh -ex
# package tez using maven, maven
mvn package -Dtar -Dhadoop.version=${HADOOP_VERSION} -DskipTests -Dmaven.javadoc.skip=true
