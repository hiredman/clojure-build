#!/bin/sh

CLOJURE_SHA="4c0722abd84152a841cc38837a03245fd2395bf7"

[ ! -e clojure ] && git clone http://github.com/clojure/clojure

cd clojure

git fetch origin

git reset --hard $CLOJURE_SHA

for i in `ls ../patches`; do
    echo "applying" $i
    patch --strip 1 < ../patches/$i > /dev/null
    [ ! 0 -eq $? ] && echo "$i failed to apply"
done

mvn package > ../build.log

if [ ! 0 -eq $? ]; then
    echo "build failed, see build.log"
fi
