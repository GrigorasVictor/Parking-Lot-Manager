import psycopg2

def check_registration_number_exists(registration_number):
    # Database connection parameters
    conn_params = {
        'dbname': 'postgres',
        'user': 'postgres',
        'password': 'changeme',
        'host': 'localhost',  # e.g., 'localhost'
        'port': '5432'   # e.g., '5432'
    }

    connection = None
    try:
        # Connect to the PostgreSQL database
        connection = psycopg2.connect(**conn_params)
        cursor = connection.cursor()

        query = """SELECT user_id
            FROM parking_management.vehicle_registration
            WHERE registration_number = %s;"""

        cursor.execute(query, (registration_number,))
        result = cursor.fetchone()

        # Check if the registration number exists
        return str(result[0]) if result else None

    except (Exception, psycopg2.DatabaseError) as error:
        print(f"Error: {error}")

    finally:
        if connection is not None:
            cursor.close()
            connection.close()
            print("Connection closed.")


if __name__ == "__main__":
    test_registration_number = 'AB10FFV'
    print(check_registration_number_exists(test_registration_number))