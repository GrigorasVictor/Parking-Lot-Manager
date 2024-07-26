using JetBrains.Annotations;
using System.Collections;
using System.Collections.Generic;
using System.Net;
using System.Net.Http;
using System.Net.Sockets;
using System.Text;
using UnityEngine;

public class TCPClient : MonoBehaviour
{
    NetworkStream networkStream;
    TcpClient tcpClient;

    byte[] imageBytes, responseBytes = new byte[1024];
    ScreenRecorder screenRecorder;

    string hostAddress;
    int port = 9001;
    int responseMaxLength = 1024;
    float currentTime = 0f;

    void Start()
    {
        screenRecorder = GameObject.Find("ScreenRecorder").GetComponent<ScreenRecorder>();
        tcpClient = new TcpClient();
        hostAddress = TCPServer.GetLocalIpV4Address();
        Connect();
    }

    void Update()
    {
        currentTime += Time.deltaTime;
        if (Mathf.FloorToInt(currentTime) !=0) // if timer == 1
        {
            currentTime = 0; //reset the timer
            try
            {
                imageBytes = screenRecorder.getFrontCameraView();
                networkStream.Write(imageBytes, 0, imageBytes.Length);

                imageBytes = screenRecorder.getTopCameraView();
                networkStream.Write(imageBytes, 0, imageBytes.Length);

                int responseLength = networkStream.Read(responseBytes, 0, responseMaxLength);
                string responseString = Encoding.UTF8.GetString(responseBytes);
                Debug.Log(responseString);
            }
            catch(System.Exception e)
            {
                Connect();
            }
        }

    }
    
    void Connect()
    {
        Debug.Log("Attempting to connect at: " + hostAddress + ":" + port);
        if (tcpClient != null)
        {
            tcpClient.Close();
            tcpClient = new TcpClient();
        }
        tcpClient.Connect(hostAddress, port);
        networkStream = tcpClient.GetStream();
    }
}
