ncd () {
  PROJECT=$(ls $NU_HOME | fzf)
  cd "$NU_HOME/$PROJECT"
}
