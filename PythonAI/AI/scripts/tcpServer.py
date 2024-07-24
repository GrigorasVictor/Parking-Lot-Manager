import socket
from PIL import Image
import io
import matplotlib.pyplot as plt
from ultralytics import YOLO

def start_tcp_server(host, port):
    # Create a socket object
    server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

    # Bind the socket to the address and port
    server_socket.bind((host, port))

    server_socket.listen(5)

    print(f"Server started and listening on {host}:{port}")

    while True:
        # Accept a new connection
        client_socket, client_address = server_socket.accept()
        print(f"Connection established with {client_address}")

        # Handle the connection
        handle_client(client_socket)


def handle_client(client_socket):
    model = YOLO("yolov8x.pt")  # pretrained YOLOv8x model


    with client_socket:
        # Receive data from the client
        data = client_socket.recv(2000000)
        while True:
            image = Image.open(io.BytesIO(data))
            result = model.predict(image, conf=0.7, classes = 2)[0]
            result.show()

            # image = Image.open(io.BytesIO(data))
            # plt.imshow(image)
            # plt.axis('off')
            # plt.show()

            # Send data back to the client (echo)
            responseBytes = ("VALID plate number!").encode('ASCII')
            client_socket.sendall(responseBytes)

            data = client_socket.recv(2000000)