using JetBrains.Annotations;
using System.Collections;
using System.Collections.Generic;
using System.Net.Http;
using System.Net.Sockets;
using System.Text;
using UnityEngine;

public class TCPClient : MonoBehaviour
{
    string curString = "", curKey = "";

    NetworkStream networkStream;

    byte[] imageBytes;
    ScreenRecorder screenRecorder;

    int responseMaxLength = 1024;
    byte[] responseBytes = new byte[1024];

    void Start()
    {
        screenRecorder = GameObject.Find("ScreenRecorder").GetComponent<ScreenRecorder>();

        TcpClient tcpClient = new TcpClient();
        string hostAddress = TCPServer.GetLocalIpV4Address();

        tcpClient.Connect(hostAddress, 9001);

        networkStream = tcpClient.GetStream();
    }

    void Update()
    {
        if (Input.GetKeyDown(KeyCode.Space))
        {
            curString += "Hello World!\n";

            imageBytes = screenRecorder.getFrontCameraView();
            networkStream.Write(imageBytes, 0, imageBytes.Length);

            imageBytes = screenRecorder.getTopCameraView();
            networkStream.Write(imageBytes, 0, imageBytes.Length);

            int responseLength = networkStream.Read(responseBytes, 0, responseMaxLength);

            /*for(int i = 0; i < responseLength; i++)
                Debug.Log(responseBytes[i]);*/

            string responseString = Encoding.UTF8.GetString(responseBytes);
            Debug.Log(responseString);
        }

        /*if (curString != "")
        {
            Debug.Log(curString);
            byte[] bytes = Encoding.UTF8.GetBytes(curString);
            
            networkStream.Write(bytes, 0, bytes.Length);
        }*/
    }
}
