#!/usr/bin/bash

branches=$(git branch -r --merged origin/master |
  grep '^ *origin/' |
  grep -v '>' |
  grep -v -E '^ *origin/(master|main|develop|staging)$' |
  sed 's|^ *origin/||')

if [ -z "$branches" ]; then
  echo "No merged branches to delete."
  exit 0
fi

echo "The following remote branches will be deleted:"
echo "$branches" | sed 's/^/  /'
echo ""
read -p "Proceed? (y/N) " confirm

if [[ "$confirm" =~ ^[Yy]$ ]]; then
  echo "$branches" | xargs git push origin --delete
else
  echo "Aborted."
fi
