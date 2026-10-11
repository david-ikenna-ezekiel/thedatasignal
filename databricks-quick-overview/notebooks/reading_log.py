# Databricks notebook source
# Reading log: Databricks Quick Overview — The Data Signal.
# This version replaces the demo completed_reading output whenever it runs.
# The upload step must first create reading_sessions in this catalog's reading_tour schema.
# Use a fresh project schema if reading_tour already contains unrelated work.
catalog = "workspace"
schema = "reading_tour"
source_table = f"{catalog}.{schema}.reading_sessions"
output_table = f"{catalog}.{schema}.completed_reading"

sessions = spark.table(source_table)
display(sessions.orderBy("session_id"))

# COMMAND ----------

# Keep completed sessions; source table remains unchanged.
from pyspark.sql import functions as F

completed = sessions.filter(F.col("status") == "Completed")
print(f"Source rows: {sessions.count()}; completed rows: {completed.count()}")
display(completed.orderBy("session_id"))

# COMMAND ----------

# Add hours for inspecting individual sessions.
with_hours = completed.withColumn("hours", F.round(F.col("minutes") / 60.0, 2))
display(with_hours.orderBy("session_id"))

# COMMAND ----------

# Replace this project’s output table so the demo can run again as a job.
# Only use this output name for the demo table you intend to replace.
# The reading_sessions source table is not changed.
with_hours.write.format("delta").mode("overwrite").saveAsTable(output_table)

# COMMAND ----------

# MAGIC %sql
# MAGIC -- Match the catalog/schema to the Python configuration above.
# MAGIC SELECT COUNT(*) AS completed_sessions,
# MAGIC        SUM(minutes) AS total_minutes,
# MAGIC        ROUND(SUM(minutes) / 60.0, 2) AS total_hours
# MAGIC FROM workspace.reading_tour.completed_reading;
