git filter-branch -f --env-filter '
  if [ ! -f /tmp/commit_count ]; then echo 0 > /tmp/commit_count; fi
  count=$(cat /tmp/commit_count)
  count=$((count + 1))
  echo $count > /tmp/commit_count
  
  start_time=$(date -d "14 days ago" +%s)
  offset=$((count * 28800))
  new_time=$((start_time + offset))
  
  formatted_date=$(date -d @$new_time +"%Y-%m-%dT%H:%M:%S")
  export GIT_AUTHOR_DATE=$formatted_date
  export GIT_COMMITTER_DATE=$formatted_date
' -- --all
rm -f /tmp/commit_count
