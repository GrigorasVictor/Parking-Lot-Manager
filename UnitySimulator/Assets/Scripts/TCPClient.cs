using System.Net.Sockets;
using System.Text;
using UnityEngine;
using TMPro;
using System.Collections;
using System.Threading;
using System.Threading.Tasks;
using System.Collections.Generic;
using System;

public class TCPClient : MonoBehaviour
{
    public float commsPeriod;
    public CarGenerator carGenerator;
    public TMP_Text textDebugUI;

    private NetworkStream networkStream;
    private TcpClient tcpClient;
    private string text;

    private byte[] imageBytes, responseBytes = new byte[32];
    private ScreenRecorder screenRecorder;

    string hostAddress;
    int port = 9001;
    float currentTime = 0f;

    bool isFrontImgTaken = false;

    void Start()
    {
        screenRecorder = GameObject.Find("ScreenRecorder").GetComponent<ScreenRecorder>();
        tcpClient = new TcpClient();
        hostAddress = TCPServer.GetLocalIpV4Address();
        hostAddress = "localhost";

        text = "Attempting to connect at: " + hostAddress + ":" + port;
        textDebugUI.text = text;
        Connect();

        imageBytes = screenRecorder.getFrontCameraView();
    }

    void Update()
    {
        currentTime += Time.deltaTime;

        if(currentTime >= commsPeriod && !isFrontImgTaken) 
        {
            imageBytes = screenRecorder.getFrontCameraView();
            isFrontImgTaken = true;
        }

        if (currentTime >= commsPeriod * 2)
        {
            isFrontImgTaken = false;
            currentTime = 0; //reset the timer
            try
            {
                imageBytes = screenRecorder.getTopCameraView();
                StartCoroutine(TcpIo());

                /*if (areEqual("valid", responseBytes))
                {
                    Debug.Log("Car accepted");
                    *//*text = "Car accepted";*//*
                    carGenerator.acceptCar();
                }
                if (areEqual("invalid", responseBytes))
                {
                    Debug.Log("Car declined");
                    *//*text = "Car declined";*//*
                    carGenerator.declineCar();
                }*/
            }
            catch(System.Exception e)
            {
                Debug.Log(e);
                Connect();
            }
            textDebugUI.text = text;
        }
    }

    IEnumerator TcpIo()
    {
        new Thread(() => {
            /*imageBytes = screenRecorder.getFrontCameraView();*/
            networkStream.Write(imageBytes, 0, imageBytes.Length);
        
            /*imageBytes = screenRecorder.getTopCameraView();*/
            networkStream.Write(imageBytes, 0, imageBytes.Length);
        }).Start();


        for (int i = 0; i < 7; i++) responseBytes[i] = 0;

        /*int responseLength = networkStream.Read(responseBytes, 0, responseBytes.Length);*/
        /*await Task.Run(ReadResp);*/

        /*new Thread(() => {*/
            networkStream.Read(responseBytes, 0, responseBytes.Length);
        /*}).Start();*/

        if (areEqual("valid", responseBytes))
        {
            Debug.Log("Car accepted");
            text = "Car accepted";
            carGenerator.acceptCar();
        }
        if (areEqual("invalid", responseBytes))
        {
            Debug.Log("Car declined");
            text = "Car declined";
            carGenerator.declineCar();
        }

        yield break;
    }

    /*async Task<byte[]> ReadResp()
    {
        networkStream.Read(responseBytes, 0, responseBytes.Length);
        return responseBytes;
    }*/

    bool areEqual(string str, byte[] byteArr)
    {
        for (int i = 0; i < str.Length; i++) 
            if (byteArr[i] != str[i]) 
                return false;

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
