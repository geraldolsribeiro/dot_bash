
pomodoro_database() {
  echo "$HOME/.bash/pomodoro.$HOSTNAME.db"
}

# Show time elapsed for last open pomodoro (second timestamp is equal to -1)
pomodoro_time() {
  local task
  local timestamp1
  local timestamp2
  local differenceInSeconds

  if [ ! -f "$(pomodoro_database)" ]; then
    return
  fi

  timestamp1=$(tail -1 "$(pomodoro_database)" | cut -f 3)
  timestamp2=$(tail -1 "$(pomodoro_database)" | cut -f 4)
  task=$(tail -1 "$(pomodoro_database)" | cut -f 5)

  # ignore if it is finished
  if [ "$timestamp2" != "-1" ]; then
    return
  fi

  timestamp2=$(date +%s)
  differenceInSeconds=$((timestamp2-timestamp1))

  # Notify +25m
  if [ $differenceInSeconds -gt $(( 25*60 )) ]; then
    notify-send -u critical "Time to rest!"
  fi

  # Print the elapsed time and the task name
  date "+ 🍅%M:%S $task" --utc --date "@$differenceInSeconds"
}

pomodoro_start() {
  local task=${1:-Urgent}
  local timestamp1="-1"
  local timestamp2="-1"
  local elapsedMinutes="-1"
  local n="0"

  if [ -f "$(pomodoro_database)" ]; then
    n=$(wc -l < "$(pomodoro_database)")
  fi

  if [ "$n" != "0" ]; then
    pomodoro_finish
  fi

  timestamp1=$(date +%s)
  echo -e "${n}\t${elapsedMinutes}\t${timestamp1}\t${timestamp2}\t${task}" >> "$(pomodoro_database)" 
}

pomodoro_finish() {
  local timestamp1
  local timestamp2
  local minutes

  if [ ! -f "$(pomodoro_database)" ]; then
    return
  fi

  timestamp1=$(tail -1 "$(pomodoro_database)" | cut -f 3)
  timestamp2=$(tail -1 "$(pomodoro_database)" | cut -f 4)

  # ignore if it is finished
  if [ "$timestamp2" != "-1" ]; then
    return
  fi

  timestamp2=$(date +%s)
  minutes=$(( (timestamp2-timestamp1)/60 ))
  # Edit the last line
  sed -i "$ s/\(.*\)\t\(.*\)\t\(.*\)\t\(.*\)\t\(.*\)/\1\t${minutes}\t\3\t${timestamp2}\t\5/" "$(pomodoro_database)"
}

pomodoro_edit() {
  $EDITOR "$(pomodoro_database)"
}

# vim: ft=bash
