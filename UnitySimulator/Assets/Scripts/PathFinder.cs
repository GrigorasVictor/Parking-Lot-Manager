using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PathFinder : MonoBehaviour
{
    public int id = 1, futurePosition;
    public float currentTime=0, maxTime=2;
    public Transform[] positions;
    public Vector3 start, final;
    public float rotationSpeed = 25f, rotationAngle=90f;
    bool isRotated = false;

    public int isAllowedToEnter = 1; // 0 - nu; 1 - inca nu se stie; 2 - da
    public int state = 0; // 0 - entering; 1 - stationed; 2 - exiting
    public CarGenerator carGenerator;

    void Start()
    {
        positions = new Transform[10];

        for (int i=0; i<positions.Length; i++)
        {
            positions[i] = GameObject.Find("Position (" + (i+1) + ")").transform;    
        }
        id--;
        futurePosition = id % 3;
        start = this.transform.position;
        final = positions[futurePosition].position;
    }

    void Update()
    {
        switch(state)
        {
            case 0:
                enter();
                break;
            case 1:
                stay();
                break;
            case 2:
                exit();
                break;
        }
    }

    private void enter()
    {
        switch(isAllowedToEnter)
        {
            case 0:
                Destroy(this.gameObject);
                break;
            case 2:
                move();
                break;
            default:
                break;
        }
    }

    private void stay()
    {
        if (Input.GetKeyDown(("" + (id + 1))))
        {
            state = 2;
            start = this.transform.position;
            final = positions[futurePosition % 3].position;
            currentTime = 0;
        }
    }

    private void exit()
    {
        move();
    }

    private void move()
    {
        this.transform.position = Vector3.Lerp(start, final, currentTime / maxTime);

        if (currentTime < maxTime) currentTime += Time.deltaTime;
        else takeTurn();
    }

    private void takeTurn()
    {
        if (state == 0)
        {
            if (!isRotated)
            {
                updateFuturePosition();
                start = this.transform.position;
                final = positions[futurePosition].position;
                currentTime = 0;
            }
            else state = 1;
        }
        if (state == 2)
        {
            if (isRotated)
            {
                updateFuturePosition();
                start = this.transform.position;
                final = positions[futurePosition].position;
                currentTime = 0;
            }
            else
            {
                carGenerator.parked[id] = false;
                Destroy(this.gameObject);
            }
        }
    }

    private void updateFuturePosition()
    {
        if (state == 0)
        {
            if (futurePosition < 3)
            {
                futurePosition += 3 * (id / 3 + 1);
            }

            if (!isRotated)
            {
                this.transform.eulerAngles += new Vector3(0, id <= 2 ? -90 : +90, 0);
                isRotated = true;
            }
        }

        if(state == 2)
        {
            futurePosition = 9;

            if (isRotated)
            {
                this.transform.eulerAngles = new Vector3(0, -90, 0);
                isRotated = false;
            }
        }
    }
}
