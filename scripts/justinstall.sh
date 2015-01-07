#!/bin/sh -ex
ALTISCALE_RELEASE=${ALTISCALE_RELEASE:-0.1.0}
export RPM_NAME=`echo vcc-tez-${ARTIFACT_VERSION}`
echo "Packaging tez rpm with name ${RPM_NAME} with version ${ALTISCALE_VERSION}-${DATE_STRING}"

export RPM_BUILD_DIR=${INSTALL_DIR}/opt/tez-${TEZ_VERSION}
mkdir --mode=0755 -p ${RPM_BUILD_DIR}
mkdir --mode=0755 -p ${INSTALL_DIR}/etc/tez
cd ${RPM_BUILD_DIR}
export DIST_DIR=${WORKSPACE}/tez/tez-dist/target
mkdir --mode=0755 lib
cp -a ${DIST_DIR}/tez-${TEZ_VERSION}/ lib
cp ${DIST_DIR}/tez-${TEZ_VERSION}.tar.gz .
cp ${DIST_DIR}/tez-${TEZ_VERSION}-minimal.tar.gz .
rm -rf ${INSTALL_DIR}/opt/tez
ln -s $RPM_BUILD_DIR ${INSTALL_DIR}/opt/tez

cd ${RPM_DIR}
fpm --verbose \
--maintainer ops@verticloud.com \
--vendor VertiCloud \
--provides ${RPM_NAME} \
--description "${DESCRIPTION}" \
--replaces vcc-tez-${ARTIFACT_VERSION} \
-s dir \
-t rpm \
-n ${RPM_NAME} \
-v ${ALTISCALE_RELEASE} \
--iteration ${DATE_STRING} \
--rpm-user root \
--rpm-group root \
-C ${INSTALL_DIR} \
opt etc
