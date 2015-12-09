#!/bin/sh -ex
ALTISCALE_RELEASE=${ALTISCALE_RELEASE:-0.1.0}
export RPM_NAME=`echo alti-tez-${ARTIFACT_VERSION}`
export RPM_DESCRIPTION="Apache Tez ${ARTIFACT_VERSION}\n\n${DESCRIPTION}"
echo "Packaging tez rpm with name ${RPM_NAME} with version ${ALTISCALE_VERSION}-${DATE_STRING}"

export RPM_BUILD_DIR=${INSTALL_DIR}/opt/tez-${TEZ_VERSION}
mkdir --mode=0755 -p ${RPM_BUILD_DIR}
mkdir --mode=0755 -p ${INSTALL_DIR}/etc/tez
cd ${RPM_BUILD_DIR}
export DIST_DIR=${WORKSPACE}/tez/tez-dist/target
mkdir --mode=0755 lib
cp ${DIST_DIR}/tez-${TEZ_VERSION}.tar.gz .
cp ${DIST_DIR}/tez-${TEZ_VERSION}-minimal.tar.gz .
tar xvf tez-${TEZ_VERSION}-minimal.tar.gz

rm -rf ${INSTALL_DIR}/opt/tez

cd ${RPM_DIR}
fpm --verbose \
--maintainer support@altiscale.com \
--vendor Altiscale \
--provides ${RPM_NAME} \
--description "${RPM_DESCRIPTION}" \
--replaces alti-tez-${ARTIFACT_VERSION} \
--url "${GITREPO}" \
--license "Apache License v2" \
-s dir \
-t rpm \
-n ${RPM_NAME} \
-v ${ALTISCALE_RELEASE} \
--iteration ${DATE_STRING} \
--rpm-user root \
--rpm-group root \
-C ${INSTALL_DIR} \
opt etc
