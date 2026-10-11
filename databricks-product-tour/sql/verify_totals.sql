-- Notebook SQL cell or SQL Editor: use the same catalog/schema as the Python cells.
SELECT
  COUNT(*) AS completed_sessions,
  SUM(minutes) AS total_minutes,
  ROUND(SUM(minutes) / 60.0, 2) AS total_hours
FROM workspace.reading_tour.completed_reading;
