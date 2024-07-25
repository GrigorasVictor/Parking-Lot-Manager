import socket

def getIpv4():
    skt = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    try:
        skt.connect(("8.8.8.8", 80))
        local_ip = skt.getsockname()[0]
    except Exception as e:
        print(f"An error occurred: {e}")
        local_ip = '127.0.0.1'  # Default to localhost if an error occurs
    finally:
        skt.close()
        print("Socket closed")
    return local_ip

if __name__ == '__main__':
    print(getIpv4())