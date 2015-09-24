#!/bin/bash
set -e
VERSION=$(dpkg-parsechangelog | sed -ne 's/^Version: \([0-9.]*\).*/\1/p')
IS_SNAPSHOT=$(dpkg-parsechangelog | sed -ne 's/^Version: .*\(SNAPSHOT\).*/\1/p')
if [ "$IS_SNAPSHOT" = "SNAPSHOT" ]; then
    VERSION="$VERSION-SNAPSHOT"
fi
MAVEN_OPTS="-Xmx1024m -XX:MaxPermSize=512m" mvn -Dgrid-router.version=$VERSION -DskipTests=true clean package
debuild --no-tgz-check -S
