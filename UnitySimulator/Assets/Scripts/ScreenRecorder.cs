using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Audio;

public class ScreenRecorder : MonoBehaviour
{
    public Camera frontCamera, topCamera;
    RenderTexture frontTexture, topTexture, tmpTexture;

    Texture2D screenShot;

    public int width = 640, height = 720;

    void Start()
    {
        frontCamera = GameObject.Find("FrontCamera").GetComponent<Camera>();
        topCamera = GameObject.Find("TopCamera").GetComponent<Camera>();

        /*frontTexture = new RenderTexture(width, height, 24);
        tmpTexture = new RenderTexture(width, height, 24);*/

        screenShot = new Texture2D(width, height, TextureFormat.ARGB32, false);
    }

    /*void Update()
    {
        if (Input.GetKeyDown(KeyCode.Space))
        {
            takeScreenShots(frontCamera);
            takeScreenShots(topCamera);
        }
    }*/

    public byte[] getTopCameraView()
    {
        return takeScreenShots(topCamera);
    }

    public byte[] getFrontCameraView()
    {
        return takeScreenShots(frontCamera);
    }

    private byte[] takeScreenShots(Camera cam)
    {
        /*Rect stdCoords = cam.rect;*/
        /*cam.rect = new Rect(0, 0, 1, 1);*/

        /*cam.targetTexture = tmpTexture;*/
        /*Texture2D screenShot = new Texture2D(width, height, TextureFormat.ARGB32, false);*/
        /*cam.Render();*/
        /*RenderTexture curRenderTexture = RenderTexture.active;*/
        RenderTexture.active = cam.targetTexture;
        screenShot.ReadPixels(new Rect(0, 0, width, height), 0, 0);
        /*RenderTexture.active = curRenderTexture;*/

        /*cam.targetTexture = null;*/
        /*cam.rect = stdCoords;*/

        return screenShot.EncodeToPNG();
    }
}
