
# Show time elapsed for last open pomodoro (timestamp 2 equal to -1)
pomodoro_time() {
  local database="$HOME/.bash/pomodoro.db"
  local task
  local timestamp1
  local timestamp2
  local differenceInSeconds
  local ret=""
  if [ -f "$database" ];then
    timestamp1=$(tail -1 ~/.bash/pomodoro.db | cut -f 3)
    timestamp2=$(tail -1 ~/.bash/pomodoro.db | cut -f 4)
    task=$(tail -1 ~/.bash/pomodoro.db | cut -f 5)
    if [ "$timestamp2" = "-1" ]; then
      timestamp2=$(date +%s)
      differenceInSeconds=$((timestamp2-timestamp1))

      if [ $differenceInSeconds -gt $(( 25*60 )) ]; then
        notify-send -u critical "Time to rest!"
      fi

      ret=$(date "+ 🍅%M:%S $task" --utc --date "@$differenceInSeconds")
    fi
  fi
  echo -n "$ret"
}

pomodoro_start() {
  local database="$HOME/.bash/pomodoro.db"
  local task=${1:-Urgent}
  local timestamp1="-1"
  local timestamp2="-1"
  local elapsedMinutes="-1"
  local n
  n=$(wc -l < "$database")
  timestamp1=$(date +%s)
  echo -e "${n}\t${elapsedMinutes}\t${timestamp1}\t${timestamp2}\t${task}" >> "$database" 
}

pomodoro_finish() {
  local database="$HOME/.bash/pomodoro.db"
  local timestamp1
  local timestamp2
  local minutes
  timestamp1=$(tail -1 ~/.bash/pomodoro.db | cut -f 3)
  timestamp2=$(date +%s)
  minutes=$(( (timestamp2-timestamp1)/60 ))
  sed -i "$ s/\(.*\)\t\(.*\)\t\(.*\)\t\(.*\)\t\(.*\)/\1\t${minutes}\t\3\t${timestamp2}\t\5/" "$database"
}

# vim: ft=bash
