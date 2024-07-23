using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Audio;

public class ScreenRecorder : MonoBehaviour
{
    public Camera frontCamera, topCamera;
    RenderTexture frontTexture, topTexture, tmpTexture;

    public int width = 640, height = 720;

    void Start()
    {
        frontCamera = GameObject.Find("FrontCamera").GetComponent<Camera>();
        topCamera = GameObject.Find("TopCamera").GetComponent<Camera>();

        frontTexture = new RenderTexture(width, height, 24);
        tmpTexture = new RenderTexture(width, height, 24);
    }

    void Update()
    {
        if (Input.GetKeyDown(KeyCode.Space)) 
        {
            takeScreenShots(frontCamera);
            takeScreenShots(topCamera);
        }
    }

    private void takeScreenShots(Camera cam)
    {
        Rect stdCoords = cam.rect;
        cam.rect = new Rect(0, 0, 1, 1);

        cam.targetTexture = tmpTexture;
        Texture2D screenShot = new Texture2D(width, height, TextureFormat.ARGB32, false);
        cam.Render();
        RenderTexture.active = cam.targetTexture;
        screenShot.ReadPixels(new Rect(0, 0, width, height), 0, 0);

        cam.targetTexture = null;
        cam.rect = stdCoords;

        byte[] buffer = screenShot.EncodeToPNG();
        System.IO.File.WriteAllBytes("C:\\Users\\Public\\Pictures\\ss_" + cam.gameObject.name + ".png", buffer);
    }
}
