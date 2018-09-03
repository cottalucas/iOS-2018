#!/bin/sh
 
git filter-branch -f --env-filter '
 
an="$GIT_AUTHOR_NAME"
am="$GIT_AUTHOR_EMAIL"
cn="$GIT_COMMITTER_NAME"
cm="$GIT_COMMITTER_EMAIL"
 
if [ "$GIT_COMMITTER_EMAIL" = "lucas.cotta@onedot.com" ]
then
cn="Lucas Cotta"
cm="lucas.oliveira.cotta@gmail.com"
fi
if [ "$GIT_AUTHOR_EMAIL" = "lucas.cotta@onedot.com" ]
then
an="Lucas Cotta"
am="lucas.oliveira.cotta@gmail.com"
fi
 
export GIT_AUTHOR_NAME=$an
export GIT_AUTHOR_EMAIL=$am
export GIT_COMMITTER_NAME=$cn
export GIT_COMMITTER_EMAIL=$cm
'

# after this, push the repository
# git push origin master --force
