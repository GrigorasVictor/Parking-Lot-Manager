using System.Net.Sockets;
using System.Text;
using UnityEngine;
using TMPro;

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

    void Start()
    {
        screenRecorder = GameObject.Find("ScreenRecorder").GetComponent<ScreenRecorder>();
        tcpClient = new TcpClient();
        hostAddress = TCPServer.GetLocalIpV4Address();

        text = "Attempting to connect at: " + hostAddress + ":" + port;
        textDebugUI.text = text;
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
            }
            catch(System.Exception e)
            {
                Debug.Log(e);
                Connect();
            }
            textDebugUI.text = text;
        }

    }

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
