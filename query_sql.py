import pyodbc

# Anslut till databasen
connection = pyodbc.connect(
    'DRIVER={ODBC Driver 17 for SQL Server};'
    'SERVER=localhost;'
    'DATABASE=UppgiftDB;'
    'Trusted_Connection=yes;'  # Använd Windows Authentication
)
cursor = connection.cursor()

# Query som använder det sammansatta indexet
query = """
SELECT * 
FROM persons
WHERE first_name = ? AND age = ?;
"""
params = ('Emma', 28)

cursor.execute(query, params)
results = cursor.fetchall()

# Visa resultaten
for row in results:
    print(row)

cursor.close()
connection.close()