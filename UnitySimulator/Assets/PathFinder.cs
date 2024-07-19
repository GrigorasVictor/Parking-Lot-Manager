using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PathFinder : MonoBehaviour
{
    public int id = 1, futurePosition;
    public float currentTime=0, maxTime=2;
    public Transform[] positions = new Transform[9];
    public Vector3 start, final;
    public float rotationSpeed = 25f, rotationAngle=90f;
    public bool firstTime = true;
    void Start()
    {
        for(int i=0; i<positions.Length; i++)
        {
            positions[i] = GameObject.Find("Position (" + (i+1) +")").transform;    
        }
        id--;
        futurePosition = id % 3;
        start = this.transform.position;
        final = positions[futurePosition].position;
    }

    // Update is called once per frame
    void Update()
    {
        //aici un if de confirmare 
        move();
        Debug.Log(futurePosition + " " + id);
    }

    private void move()
    {
        this.transform.position = Vector3.Lerp(start, final, currentTime / maxTime);
        if (currentTime < maxTime)
        {
            currentTime += Time.deltaTime;
        }
        else
        {
            updateFuturePosition();
            start = this.transform.position;
            final = positions[futurePosition].position;
            currentTime = 0;
        }
    }

    private void updateFuturePosition()
    {
        if(futurePosition < 3)
        {
            futurePosition += 3 * (id / 3 + 1);
        } 
        if (firstTime)
        {
            Vector3 rotationAxis = (id == 0 || id == 1 || id == 2) ? Vector3.down : Vector3.up;
            this.transform.Rotate(rotationAxis * rotationAngle); firstTime = false;
            firstTime = false;
        }
    }
}
