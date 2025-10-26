# Kansas-City-Service-Operations
Used Alteryx to profile 487K Kansas City service requests from TSV file. Identified issues: 18% missing dates, mixed formats, duplicates. Created workflow adding File_Name, User_Name (GetEnvironmentVariable), Load_Date (DateTimeNow) columns. Staged data to Azure SQL Database table successfully.
