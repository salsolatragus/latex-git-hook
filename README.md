# latex-git-hook

Git commit hook to ensure latex documents are up-to-date. Checks documents on all levels of the repository, given that both '<document>.pdf' and '<document>.tex' exist.

# Setup

Either copy this script to '<repo>/.git/hooks/pre-commit' or link it there. Make sure it's executable.

# Credits

- Make latexmk check if document is up-to-date: http://tex.stackexchange.com/a/65257
- Make latexmk work with documents in subdirectories: http://tex.stackexchange.com/a/11726
