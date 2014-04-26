function git-purge-branches {
  CURRENT_BRANCH=`git rev-parse --abbrev-ref HEAD`

  if ! [ "$CURRENT_BRANCH" = 'master' ]; then
    echo 'Please stash your work and checkout master'
    return
  fi

  git fetch -p
  ggpull

  BRANCHES=`git branch --merged master | grep --invert-match -E "master"`

  if [ $BRANCHES ]; then
    echo 'The following local branches will be removed: '
    echo $BRANCHES
    read "REPLY?Continue (y/n)? "
    if [ "$REPLY" = "y" ]; then
      echo $BRANCHES | xargs git branch -d
    fi
  fi

  BRANCHES=`git branch -r --merged master | grep --invert-match -E "master" | grep "origin" | sed -e "s#origin/##"`

  if [ $BRANCHES ]; then
    echo 'The following remote branches will be removed: '
    echo $BRANCHES
    read "REPLY?Continue (y/n)? "
    if [ "$REPLY" = "y" ]; then
      echo $BRANCHES | sed -e 's/^ */ :/' | tr -d '\n' | xargs git push origin
    fi
  fi
}

function git-rename-develop {
  git branch -m "$1" && git branch develop origin/develop
}

function add-cache-buster {
  for FILE in $*; do
    if [ -f "$FILE" ]; then
      MOVED=$(_remove-cache-buster $FILE)
      if [ "$FILE" != "$MOVED" ]; then
        echo "$FILE -> $MOVED"
      fi
      FILE=$MOVED
      EXT="${FILE##*.}"
      NAME="${FILE%.*}"
      HASH=$(md5 -q "$FILE")
      mv -v "$FILE" "$NAME-$HASH.$EXT"
    fi
  done
}

function _remove-cache-buster {
  NAME=$(echo "$FILE" | sed -E 's/(.*)-[a-f0-9]+\.([a-z]+)/\1.\2/g')
  mv "$FILE" "$NAME"
  echo $NAME
}

function remove-cache-buster {
  for FILE in $*; do
    if [ -f "$FILE" ]; then
      MOVED=$(_remove-cache-buster "$FILE")
      if [ "$FILE" != "$MOVED" ]; then
        echo "$FILE -> $MOVED"
      fi
    fi
  done
}

function copy_and_echo {
  echo -n $1 | pbcopy
  echo $1
}

function stop-daemon {
  sudo launchctl unload /Library/LaunchDaemons/*$1*
}

function start-daemon {
  sudo launchctl load /Library/LaunchDaemons/*$1*
}

function reload-daemon {
  stop-daemon $1
  start-daemon $1
}
