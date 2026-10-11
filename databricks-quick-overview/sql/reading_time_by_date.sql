-- Optional exercise: completed reading time by date.
SELECT
  session_date,
  COUNT(*) AS completed_sessions,
  SUM(minutes) AS total_minutes
FROM workspace.reading_tour.completed_reading
GROUP BY session_date
ORDER BY session_date;
