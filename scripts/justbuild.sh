#!/bin/sh -ex
# compile and package the Tez
#mvn package -Dtar -Dhadoop.version=${HADOOP_VERSION} -DskipTests -Dmaven.javadoc.skip=true
#
env
MVN_SKIPTESTS_BOOL=${SKIPTESTS_BOOL:-false}
if [ "${MVN_SKIPTESTS_BOOL}" != "true" ] ; then
    MVN_SKIPTESTS_BOOL=false
fi

MVN_IGNORE_TESTFAILURES_BOOL=${IGNORE_TESTFAILURES_BOOL:-false}
if [ "${MVN_IGNORE_TESTFAILURES_BOOL}" != "true" ] ; then
    MVN_IGNORE_TESTFAILURES_BOOL=false
fi

mvn clean -PcleanUICache package -Dtar \
-Dmaven.test.skip=${MVN_SKIPTESTS_BOOL} -DskipTests=${MVN_SKIPTESTS_BOOL} \
-Dmaven.test.failure.ignore=${MVN_IGNORE_TESTFAILURES_BOOL} -DtestFailureIgnore=${MVN_IGNORE_TESTFAILURES_BOOL} \
-Dmaven.javadoc.skip=true \
${JUSTBUILD_EXTRA_OPTS}
