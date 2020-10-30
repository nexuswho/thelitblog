#!/bin/sh

eval "$(ssh-agent -s)" #start the ssh agent
chmod 600 .id_rsa.pem # this key should have push access
ssh-add identity.pem
git remote add deploy git@github.com:thelitblog/thelitblog.github.io.git
git rm -r --cached ./
git checkout main
git add _site/
git push deploy main




# setup_git() {
#   git config --global user.email "travis@travis-ci.org"
#   git config --global user.name "Travis CI"
# }

# commit_website_files() {
#   git checkout main
#   git add ./_site/ -f
#   git commit -m "Travis build: $TRAVIS_BUILD_NUMBER" -a
# }

# upload_files() {
#   git remote rm origin
#   "git remote add origin https://${GITHUB_TOKEN_LIT}@github.com/thelitblog/thelitblog.github.io.git > /dev/null 2>&1"
#   git push --quiet --set-upstream origin main 
# }

# setup_git
# commit_website_files
# upload_files