#!/bin/bash

VER=$(sed 's/.*"\(.*\)".*/\1/' version.sbt)

set -e

sbt scalastyle
sbt "test:scalastyle"
sbt "it:scalastyle"
sbt test
sbt package
sbt make-pom

mvn -e -s settings.xml deploy:deploy-file \
    -DrepositoryId=utility-internal \
    -Durl=http://touchtype.artifactoryonline.com/touchtype/utility-internal \
    -Dfile=target/scala-2.11/spark-redshift_2.11-$VER.jar \
    -DpomFile=target/scala-2.11/spark-redshift_2.11-$VER.pom \
