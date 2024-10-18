from scripts.tcpServer import start_tcp_server as startServer
from scripts.ipv4Grabber import getIpv4

local_ip = getIpv4()
port = 9001

startServer(local_ip, port)