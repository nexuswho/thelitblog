#!/bin/sh
# Credit: https://gist.github.com/willprice/e07efd73fb7f13f917ea

setup_git() {
  git config --global user.email "travis@travis-ci.org"
  git config --global user.name "Travis CI"
}

repo(){
git clone https://github.com/thelitblog/thelitblog.github.io.git 
cd thelitblog.github.io.git
yes y | rm -rf *
cp -r ../_site/ .
}


commit() {
  git checkout inverse
  # Current month and year, e.g: Apr 2018
  dateAndMonth=`date "+%b %Y"`
  # Stage the modified files in dist/output
  git reset
  cd _site && pwd && git add -f .
  pwd
  # Create a new commit with a custom build message
  # with "[skip ci]" to avoid a build loop
  # and Travis build number for reference
  git commit -m "Travis update: $dateAndMonth (Build $TRAVIS_BUILD_NUMBER)" -m "[skip ci]"
}

upload_files() {
  # Remove existing "origin"
  git remote rm origin
  # Add new "origin" with access token in the git URL for authentication
  git remote add origin https://dopewind:${GITHUB_TOKEN}@github.com/thelitblog/ > /dev/null 2>&1
  git push origin inverse --quiet
}

setup_git

commit

# Attempt to commit to git only if "git commit" succeeded
if [ $? -eq 0 ]; then
  echo "Uploading to GitHub"
  upload_files
else
  echo "Nothing to do"
fi
