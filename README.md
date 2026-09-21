# sql2
SELECT
  pid,
  state
FROM pg_stat_activity; => check how many active connections, each connection => each process

SELECT
  pid,
  state,
  wait_event_type,
  wait_event,
  query
FROM pg_stat_activity
WHERE wait_event IS NOT NULL;
