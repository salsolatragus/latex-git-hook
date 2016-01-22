#!/bin/sh
#
# Git commit hook to ensure latex document has been compiled.
#

ls *.pdf | sed 's/\(.*\)\..*/\1/' | while read pdf; do
  if [ -f $pdf.tex ]; then
    echo $pdf.tex
    latexmk -e '$pdflatex = $latex = '"'"'internal die_latex %S'"'"'; sub die_latex { die "$_[0] is out of date" }' -pdf >/dev/null 2>/dev/null 
    rc=$?
    if [ $rc != 0 ]; then
      >&2 echo latex out of date!
      exit $rc
    fi
  fi
done

