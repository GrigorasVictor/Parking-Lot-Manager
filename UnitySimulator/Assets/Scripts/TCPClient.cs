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

    void Start()
    {
        TcpClient tcpClient = new TcpClient();
        string hostname = "localhost";

        tcpClient.Connect(hostname, 9001);

        networkStream = tcpClient.GetStream();
    }

    void Update()
    {
        curString = "";

        /*for(char i = 'a'; i <= 'z'; i++)
        {
            curKey = "" + i; 
            if(Input.GetKeyDown(curKey)) curString += i;
        }*/

        if (Input.GetKeyDown(KeyCode.Space)) curString += "Hello World!\n"; 

        if(curString != "")
        {
            Debug.Log(curString);
            byte[] bytes = Encoding.UTF8.GetBytes(curString);
            
            networkStream.Write(bytes, 0, bytes.Length);
        }
    }
}
