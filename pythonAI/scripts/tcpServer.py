import socket
from .yoloAnalyzer import parseData
def start_tcp_server(host, port):
    # Create a socket object
    server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

    # Bind the socket to the address and port
    server_socket.bind((host, port))
    server_socket.listen(5)
    print(f"Server started and listening on {host}:{port}")

    while True:
        try:
            # Accept a new connection
            client_socket, client_address = server_socket.accept()
            print(f"Connection established with {client_address}")

            # Handle the connection
            handle_client(client_socket)
        except Exception as e:
            print(f"Error accepting client connection: {e}")


def handle_client(client_socket):
    with client_socket:
        while True:
            # Receive data from the client
            data = client_socket.recv(2000000)
            if not data:
                break
            print(f"Received some data!")

            # Converting binaries into array and then into an image
            parseData(data)

            responseBytes = ("VALID plate number!").encode('ASCII')
            client_socket.sendall(responseBytes)