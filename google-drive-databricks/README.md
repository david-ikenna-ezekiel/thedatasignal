# Google Drive Integration with Databricks

This repository contains a Databricks notebook that demonstrates how to use Google Drive as cloud storage via PyDrive2 and OAuth authentication.

You can download files from Google Drive — including Google Sheets, Google Docs, CSVs, and more — directly into your Databricks environment.

## Features

Authenticate with Google Drive using OAuth 2.0

Save and reuse OAuth tokens (no repeated login)

Download:

✔️ Regular files (CSV, XLSX, ZIP, images)

✔️ Google Sheets → automatically exported to CSV

✔️ Google Docs → exported to PDF

✔️ Google Slides → exported to PDF

Load downloaded files into Spark or Pandas

Simple reusable function for all Google Drive access

📁 Repository Structure
google-drive-databricks/
│
├── notebooks/
│   └── Databricks-Googledrive-integration.ipynb   # Main notebook
│
├── .gitignore
│
└── README.md

## Requirements

-- Google Cloud Project (free)

-- OAuth 2.0 Client ID (Desktop App)

-- Databricks workspace

PyDrive2

🪜 Setup Instructions
1) Enable Google Drive API

Go to:
APIs & Services → Library → Google Drive API → Enable

2) Create OAuth Credentials

Navigate to:
APIs & Services → Credentials → Create Credentials → OAuth Client ID

Application type: Desktop App

Download the JSON file

Do NOT upload your real client_secret JSON to GitHub

3) Upload Credentials to Databricks

Upload the JSON file to:

/dbfs/FileStore/googledrive/client_secret_XXXX.json

4) Import the Notebook

In Databricks:

Workspace → Import → Upload


Select the file:

notebooks/Databricks-Googledrive-integration.ipynb

6) Run the Notebook

The notebook will:

Install PyDrive2

Authenticate with Google

Save a reusable token

Download any Google Drive file

Load it into Spark or Pandas



## Tutorial Video

Watch the full walkthrough on YouTube:
👉 [https://youtu.be/5cu2XnUFrkk]

## Contributions

Feel free to open issues if you need help or want to extend this notebook.
