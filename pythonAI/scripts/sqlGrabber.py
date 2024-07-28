import psycopg2
from psycopg2 import sql

def connect_and_select():
    # Database connection parameters
    conn_params = {
        'dbname': 'postgres',
        'user': 'postgres',
        'password': '',
        'host': 'localhost',  # e.g., 'localhost'
        'port': '5432'   # e.g., '5432'
    }
    connection = None
    # SQL query to execute
    query = sql.SQL("SELECT * FROM parking_management.users;")
    try:
        # Connect to the PostgreSQL database
        connection = psycopg2.connect(**conn_params)
        cursor = connection.cursor()

        # Execute the query
        cursor.execute(query)
        results = cursor.fetchall()
        for row in results:
            print(row)

    except (Exception, psycopg2.DatabaseError) as error:
        print(f"Error: {error}")

    finally:
        if connection:
            cursor.close()
            connection.close()
            print("Connection closed.")

# Run the function
if __name__ == "__main__":
    connect_and_select()
