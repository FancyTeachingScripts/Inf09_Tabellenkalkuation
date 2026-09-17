#!/bin/bash
# One-time setup for this course repo. Run once after cloning (including a
# fresh clone of a repo created from the GitHub template). Safe to re-run.
#
# Lives here at the course repo's root, not inside template/tools/ --
# unlike the submodule, this script is already present the moment you
# clone, so there's no bootstrapping problem: nothing here needs template/
# to exist yet.
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")"

git submodule update --init --recursive

# The submodule's recommended git config (push order, submodule recursion,
# status summary) lives in template/tools/course-repo.gitconfig so it stays
# up to date automatically via `git submodule update --remote` -- this just
# wires it in locally, once. Guarded so re-running doesn't add a duplicate
# include (include.path is a multi-value key).
if ! git config --local --get-all include.path | grep -qxF '../template/tools/course-repo.gitconfig'; then
  git config --local --add include.path ../template/tools/course-repo.gitconfig
fi

echo "Done: template/ checked out, course-repo.gitconfig included."
