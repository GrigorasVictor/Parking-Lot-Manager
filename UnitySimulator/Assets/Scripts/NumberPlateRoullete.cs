using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TMPro;

public class NumberPlateRoullete : MonoBehaviour
{
    public TMP_Text frontPlate, backPlate;
    static string[] numberPlates = { "AB 10 FFV", "AG 49 XRF", "AR 05 DAN", "BC 10 VIC", "BH 19 ERP", "BN 23 GOA", "BR 50 ETT", "BT 41 XYZ", 
                                     "BV 91 ABC", "CJ 69 CLJ", "CL 33 DFE", "CS 73 SAD","AG 42 BXF", "MH 27 RQK", "CS 58 WZN"};
    private string numberPlate = string.Empty;
    //public static bool[] isTaken = new bool[numberPlates.Length];
    public static int index; 
    // Start is called before the first frame update
    void Start()
    {
        index = UnityEngine.Random.Range(0, numberPlates.Length);        
        numberPlate = numberPlates[index];         
        frontPlate.text = numberPlate;
        backPlate.text = numberPlate;
    }


}
