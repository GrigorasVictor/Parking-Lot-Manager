import socket

def start_tcp_client(host, port, message):
    # Connect to the server
    client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    client_socket.connect((host, port))
    print(f"Connected to server at {host}:{port}")

    try:
        client_socket.sendall(message.encode())
        response = client_socket.recv(1024)
        print(f"Received response from server: {response.decode()}")
    except Exception:
        print(f"Connection failed to server: {host}:{port}")
    finally:
        client_socket.close()

if __name__ == "__main__":
    host = '192.168.0.100'
    port = 9001
    message = "Hello, Server!"  # Message to send
    start_tcp_client(host, port, message)
