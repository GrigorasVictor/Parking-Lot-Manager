import socket


def start_tcp_server(host, port):
    # Create a socket object
    server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

    # Bind the socket to the address and port
    server_socket.bind((host, port))

    # Listen for incoming connections (max 5 queued connections)
    server_socket.listen(5)

    print(f"Server started and listening on {host}:{port}")

    while True:
        # Accept a new connection
        client_socket, client_address = server_socket.accept()
        print(f"Connection established with {client_address}")

        # Handle the connection
        handle_client(client_socket)


def handle_client(client_socket):
    with client_socket:
        while True:
            # Receive data from the client
            data = client_socket.recv(1024)
            if not data:
                break
            print(f"Received data: {data.decode()}")

            # Send data back to the client (echo)
            client_socket.sendall(data)


if __name__ == "__main__":
    host_IP = '127.0.0.1'
    port = 13337
    start_tcp_server(host_IP, port)
