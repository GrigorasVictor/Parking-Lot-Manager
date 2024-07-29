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
    public float commsPeriod;
    public CarGenerator carGenerator;
    NetworkStream networkStream;
    TcpClient tcpClient;

    byte[] imageBytes, responseBytes = new byte[32];
    ScreenRecorder screenRecorder;

    string hostAddress;
    int port = 9001;
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
        if (currentTime >= commsPeriod)
        {
            currentTime = 0; //reset the timer
            try
            {
                imageBytes = screenRecorder.getFrontCameraView();
                networkStream.Write(imageBytes, 0, imageBytes.Length);

                imageBytes = screenRecorder.getTopCameraView();
                networkStream.Write(imageBytes, 0, imageBytes.Length);

                for (int i = 0; i < responseBytes.Length; i++)
                    responseBytes[i] = 0;
                int responseLength = networkStream.Read(responseBytes, 0, responseBytes.Length);
                string responseString = Encoding.UTF8.GetString(responseBytes);

                /*if (responseBytes[0] == 'v')*/
                if (areEqual("valid", responseBytes))
                {
                    Debug.Log("Car accepted");
                    carGenerator.acceptCar();
                }
                if (areEqual("invalid", responseBytes))
                {
                    carGenerator.declineCar();
                    Debug.Log("Car declined");
                }

                /*Debug.Log(responseString);*/
            }
            catch(System.Exception e)
            {
                Connect();
            }
        }

    }

    bool areEqual(string str, byte[] byteArr)
    {
        for (int i = 0; i < str.Length; i++) if (byteArr[i] != str[i]) return false;

        return true;
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
