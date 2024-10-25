import psycopg2
import json

from queueMessaging.producer import publish

FILE_PATH = 'db.localconfig'

def check_registration_number_exists(registration_number):
    # Database connection parameters
    with open(FILE_PATH, 'r') as file:
        conn_params = json.load(file)

    connection = None
    try:
        # Connect to the PostgreSQL database
        connection = psycopg2.connect(**conn_params)
        cursor = connection.cursor()

        query = '''SELECT user_id
            FROM parking_management.vehicle_registration
            WHERE registration_number = %s;'''

        cursor.execute(query, (registration_number,))
        result = cursor.fetchone()

        # Check if the registration number exists

        if str(result[0]): publish()

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