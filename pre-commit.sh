#!/bin/sh
#
# Git commit hook to ensure latex documents are up-to-date. Checks documents on
# all levels of the repository, given that both '<document>.pdf' and
# '<document>.tex' exist.
#
# Author: salsolatragus
#
# Setup: Either copy this script to '<repo>/.git/hooks/pre-commit' or link it
# there. Make sure it's executable.
#
# Credits:
# - Make latexmk check if document is up-to-date: http://tex.stackexchange.com/a/65257
# - Make latexmk work with documents in subdirectories: http://tex.stackexchange.com/a/11726
#

find . -name '*.pdf' | sed 's/\(.*\)\..*/\1/' | while read doc; do
  if [ -f $doc.tex ]; then
    printf "Checking LaTeX document '$doc.pdf'... "
    latexmk -e '$pdflatex = $latex = '"'"'internal die_latex %S'"'"'; sub die_latex { die "$_[0] outdated" }' -pdf -jobname=$doc $doc >/dev/null 2>/dev/null
    rc=$?
    if [ $rc != 0 ]; then
      >&2 echo outdated. Please rebuild before commit or skip check with -n!
      exit $rc
    else
      echo up-to-date.
    fi
  fi
done

