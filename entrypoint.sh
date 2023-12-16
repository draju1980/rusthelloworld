#!/bin/sh -l

results=$(echo "$@" | xargs myapp)
echo "results=$results" >> $GITHUB_OUTPUT