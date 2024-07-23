using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TMPro;

public class NumberPlateRoullete : MonoBehaviour
{
    public TMP_Text frontPlate, backPlate;
    static string[] numberPlates = { "AB 10 FFV", "AG 49 XRF", "AR 05 DAN", "BC 10 VIC", "BH 19 ERP", "BN 23 GOA", "BR 50 ETT", "BT 41 XYZ", 
                                     "BV 91 ABC", "CJ 69 CLJ", "CL 33 DFE", "CS 73 SAD"};
    private string numberPlate = string.Empty;

    // Start is called before the first frame update
    void Start()
    {
        numberPlate = numberPlates[UnityEngine.Random.Range(1, numberPlates.Length)]; // Judet          
        frontPlate.text = numberPlate;
        backPlate.text = numberPlate;
        Debug.Log(numberPlate);

    }


}
