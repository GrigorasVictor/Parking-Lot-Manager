from scripts.tcpServer import start_tcp_server as startServer
import threading

host = '192.168.0.100'
port = 9001

#Running Server on a Thread
thread = threading.Thread(target=startServer(host, port))
thread.start()
