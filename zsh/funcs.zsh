ccd () {
  if [ ! $CODE_HOME ]
  then
    CODE_HOME="$HOME"
  fi

  project=$(ls $CODE_HOME | fzf)
  if [ $project ]
  then
    cd "$CODE_HOME/$project"
  fi
}
