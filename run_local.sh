#!/usr/bin/env bash
set -e
set -u

cmd="jekyll s -w"
cmd=${1-$cmd}
cwd="`pwd`"
set -x
docker run -it --rm \
  -v "$cwd":/srv/jekyll \
  -p 4000:4000 \
  jekyll/jekyll \
  $cmd
