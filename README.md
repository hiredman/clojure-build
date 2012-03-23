build.sh is a script that downloads the latest version of Clojure
core as of the day you run it.

It then "backs up" to a particular version that has been tested for
the process described below to complete successfully.  See early
in the file build.sh for the SHA1 hash and date of that version.

After backing up, build.sh applies patches that attempt to address
some tickets filed against Clojure.  See the file patches/patch-order.txt
for the current list.  A few patches address more than one ticket,
and a few tickets are addressed by more than one patch.  All patches
are from the Clojure Jira bug tracker at:

    http://dev.clojure.org/jira/browse/CLJ

In some cases small modifications have been made to the patches
there, so the combination of patches will apply cleanly.
