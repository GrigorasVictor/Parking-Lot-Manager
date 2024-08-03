using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class UISizer : MonoBehaviour
{
    RectTransform rectTransform;
    RectTransform textRectTransform;
    Camera topCam, frontCam;
    public float percentOfScreenSizeHeight, percentOfScreenSizeWidth;

    void Start()
    {
        frontCam = GameObject.Find("FrontCamera").GetComponent<Camera>();
        topCam = GameObject.Find("TopCamera").GetComponent<Camera>();

        rectTransform = GetComponent<RectTransform>();
        textRectTransform = GetComponentInChildren<RectTransform>();
        float trueSizeX = (topCam.pixelWidth + frontCam.pixelWidth) * percentOfScreenSizeWidth;
        float trueSizeY = (topCam.pixelHeight) * percentOfScreenSizeHeight;

        rectTransform.sizeDelta = new Vector2(trueSizeX, trueSizeY);
        rectTransform.anchoredPosition = new Vector3(trueSizeX/2, trueSizeY/2, 0);
        rectTransform.localScale = new Vector3(1, 1, 1);

        textRectTransform.sizeDelta = new Vector2(trueSizeX, trueSizeY);
        textRectTransform.anchoredPosition = new Vector3(trueSizeX / 2, trueSizeY / 2, 0);
        textRectTransform.localScale = new Vector3(1, 1, 1);
    }
}
