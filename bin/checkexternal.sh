#!/usr/bin/env bash

# Checks external links.
# This is not done in citest.sh so that CI test results are reproducible. It'd also be annoying if a temporary external
# site outage prevented deploying this site.

# Exit immediately if there is an error
set -e

# cause a pipeline (for example, curl -s http://sipb.mit.edu/ | grep foo) to produce a failure return code if any command errors not just the last command of the pipeline.
set -o pipefail

#Use a temp _site directory
readonly SITE="${TMPDIR}/_checkexternal_site"

# Build the site
bundle exec jekyll build --destination ${SITE}

# Run html proofer including external links
bundle exec htmlproofer ${SITE}  \
  --allow-hash-href \
  --url-ignore "/(mailto:.*)/" \
  --empty-alt-ignore \
  --http-status-ignore "301,302"

