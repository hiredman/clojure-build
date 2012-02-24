#!/bin/sh

CLOJURE_SHA="e27a27d9a6dc3fd0d15f26a5076e2876007e0ae6"

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
