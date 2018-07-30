ncd () {
  PROJECT=$(ls $NU_HOME | fzf)
  cd "$NU_HOME/$PROJECT"
}

fgb () {
  BRANCH=$(git branch | cut -c 3- | fzf)
  git checkout $BRANCH
}
