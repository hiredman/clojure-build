#!/bin/sh

CLOJURE_SHA="b62df08fc3567d17cca68acfaa96adba2880126d"

[ ! -e clojure ] && git clone http://github.com/clojure/clojure

cd clojure

git fetch origin

git reset --hard $CLOJURE_SHA

for i in `git status --porcelain|cut -d \  -f 2`; do rm -rf $i; done

git reset --hard $CLOJURE_SHA

for i in `ls ../patches`; do
    echo "applying" $i
    patch --strip 1 < ../patches/$i > /dev/null
    [ ! 0 -eq $? ] && echo "$i failed to apply"
done

MAVEN_OPTS="-Djava.awt.headless=true"

mvn package > ../build.log

if [ ! 0 -eq $? ]; then
    echo "build failed, see build.log"
else
    TAG=`date +%Y-%m-%d'T'%H%M%z`
    cd ..
    echo $TAG
    git tag -am $TAG $TAG
fi
