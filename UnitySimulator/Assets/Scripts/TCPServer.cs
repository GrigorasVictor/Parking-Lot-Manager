using System;
using System.Collections;
using System.Collections.Generic;
<<<<<<< HEAD
=======
using System.IO;
>>>>>>> 5e14767430f1a625b8b7ed1a0518536b894e28a6
using System.Net;
using System.Net.Sockets;
using System.Text;
using System.Threading;
using UnityEngine;

public class TCPServer : MonoBehaviour
{
<<<<<<< HEAD
    #region private members 	
    /// <summary> 	
    /// TCPListener to listen for incomming TCP connection 	
    /// requests. 	
    /// </summary> 	
    private TcpListener tcpListener;
    /// <summary> 
    /// Background thread for TcpServer workload. 	
    /// </summary> 	
    private Thread tcpListenerThread;
    /// <summary> 	
    /// Create handle to connected tcp client. 	
    /// </summary> 	
    private TcpClient connectedTcpClient;
    #endregion
=======
    private Thread tcpListenerThread;

    public int main()
    {
        Console.WriteLine("Inceput");

        Start();

        return 0;
    }
>>>>>>> 5e14767430f1a625b8b7ed1a0518536b894e28a6

    // Use this for initialization
    void Start()
    {
        // Start TcpServer background thread 		
        tcpListenerThread = new Thread(new ThreadStart(ListenForIncommingRequests));
<<<<<<< HEAD
        tcpListenerThread.IsBackground = true;
        tcpListenerThread.Start();
    }

    // Update is called once per frame
    void Update()
    {
        if (Input.GetKeyDown(KeyCode.Space))
        {
            SendMessage();
        }
    }

    /// <summary> 	
    /// Runs in background TcpServerThread; Handles incomming TcpClient requests 	
    /// </summary> 	
    private void ListenForIncommingRequests()
    {
        try
        {
            // Create listener on localhost port 8052. 			
            tcpListener = new TcpListener(IPAddress.Any, 8052);
            tcpListener.Start();
            Debug.Log("Server is listening");
            Byte[] bytes = new Byte[1024];
            while (true)
            {
                using (connectedTcpClient = tcpListener.AcceptTcpClient())
                {
                    // Get a stream object for reading 					
                    using (NetworkStream stream = connectedTcpClient.GetStream())
                    {
                        Debug.Log("Primim stream");
                        int length;
                        // Read incomming stream into byte arrary. 						
                        while ((length = stream.Read(bytes, 0, bytes.Length)) != 0)
                        {
                            var incommingData = new byte[length];
                            Array.Copy(bytes, 0, incommingData, 0, length);
                            // Convert byte array to string message. 							
                            string clientMessage = Encoding.ASCII.GetString(incommingData);
                            Debug.Log("client message received as: " + clientMessage);
                        }
                    }
                }
            }
        }
        catch (SocketException socketException)
        {
            Debug.Log("SocketException " + socketException.ToString());
        }
    }
    /// <summary> 	
    /// Send message to client using socket connection. 	
    /// </summary> 	
    private void SendMessage()
    {
        if (connectedTcpClient == null)
        {
            return;
        }

        try
        {
            // Get a stream object for writing. 			
            NetworkStream stream = connectedTcpClient.GetStream();
            if (stream.CanWrite)
            {
                string serverMessage = "This is a message from your server.";
                // Convert string message to byte array.                 
                byte[] serverMessageAsByteArray = Encoding.ASCII.GetBytes(serverMessage);
                // Write byte array to socketConnection stream.               
                stream.Write(serverMessageAsByteArray, 0, serverMessageAsByteArray.Length);
                Debug.Log("Server sent his message - should be received by client");
            }
        }
        catch (SocketException socketException)
        {
            Debug.Log("Socket exception: " + socketException);
=======
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
            IPAddress localAddr = IPAddress.Parse("192.168.1.130");

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
>>>>>>> 5e14767430f1a625b8b7ed1a0518536b894e28a6
        }
    }
}