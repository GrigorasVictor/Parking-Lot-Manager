using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CarGenerator : MonoBehaviour
{
    public GameObject carPrefab;
    public bool[] parked = new bool[6];
    private GameObject[] cars = new GameObject[6];

    void Start()
    {
        for (int i = 0; i < parked.Length; i++)
            parked[i] = false;
    }

    void Update()
    {
        for (char i = '1'; i <= '6'; i++)
        {
            string input = "" + i;
            int index = i - '1'; 

            if (Input.GetKeyDown(input) && !parked[index])
            {
                cars[index] = Instantiate(carPrefab);

                PathFinder curCarPathFinder = cars[index].GetComponent<PathFinder>();
                curCarPathFinder.id = index + 1;
                curCarPathFinder.carGenerator = this;

                parked[index] = true;
            }
        }
    }
}
