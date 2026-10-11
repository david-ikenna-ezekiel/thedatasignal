-- Update catalog/schema if you use a different demo location.
-- Paste this SELECT into both the saved query and the dashboard's SQL dataset.
SELECT
  genre,
  COUNT(*) AS completed_sessions,
  SUM(minutes) AS total_minutes
FROM workspace.reading_tour.completed_reading
GROUP BY genre
ORDER BY total_minutes DESC, genre
