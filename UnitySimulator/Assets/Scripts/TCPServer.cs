using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Net;
using System.Net.Sockets;
using System.Text;
using System.Threading;
using UnityEngine;

public class TCPServer : MonoBehaviour
{
    private Thread tcpListenerThread;

    public int main()
    {
        Console.WriteLine("Inceput");

        Start();

        return 0;
    }

    // Use this for initialization
    void Start()
    {
        // Start TcpServer background thread 		
        tcpListenerThread = new Thread(new ThreadStart(ListenForIncommingRequests));
        tcpListenerThread.Start();
        /*ListenForIncommingRequests();*/
    }

    private void ListenForIncommingRequests()
    {
        TcpListener server = null;
        try
        {
            // Set the TcpListener on port 13000.
            Int32 port = 9001;
            IPAddress localAddr = IPAddress.Parse("192.168.0.100");

            // TcpListener server = new TcpListener(port);
            server = new TcpListener(localAddr, port);

            // Start listening for client requests.
            server.Start();

            // Buffer for reading data
            Byte[] bytes = new Byte[256];
            String data = null;

            // Enter the listening loop.
            while (true)
            {
                Debug.Log("Waiting for a connection... ");
                Console.WriteLine("Waiting for a connection... ");

                // Perform a blocking call to accept requests.
                // You could also use server.AcceptSocket() here.
                using TcpClient client = server.AcceptTcpClient();
                Debug.Log("Connected!");
                Console.WriteLine("Connected!");

                data = null;

                // Get a stream object for reading and writing
                NetworkStream stream = client.GetStream();

                // Loop to receive all the data sent by the client.
                StreamReader reader = new StreamReader(stream);

                string recievedString = reader.ReadLine();
                Debug.Log(recievedString);
                Console.WriteLine(recievedString);

            }
        }
        catch (SocketException e)
        {
            Debug.Log(e);
        }
        finally
        {
            server.Stop();
        }
    }
}