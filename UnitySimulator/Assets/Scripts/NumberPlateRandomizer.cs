using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TMPro;

public class NumberPlateRandomizer : MonoBehaviour
{
    public TMP_Text frontPlate, backPlate;
    static string[] judete = { "AB", "AG", "AR", "BC", "BH", "BN", "BR", "BT", "BV", "BZ", "CJ", "CL", "CS", 
                            "CT", "CV", "DB", "DJ", "GJ", "GL", "GR", "HD", "HR", "IF", "IL", "IS", "MH", 
                            "MM", "MS", "NT", "OT", "PH", "SB", "SJ", "SM", "SV", "TL", "TM", "TR", "VL", "VN", "VS"};

    private string numarInmatriculare = string.Empty;

    // Start is called before the first frame update
    void Start()
    {
        numarInmatriculare += judete[UnityEngine.Random.Range(1, judete.Length)] + " " + // Judet
                            UnityEngine.Random.Range(0, 9) + UnityEngine.Random.Range(0, 9) + " " + //Numar
                            (char)UnityEngine.Random.Range('A', 'Z') + (char)UnityEngine.Random.Range('A', 'Z') + (char)UnityEngine.Random.Range('A', 'Z'); //Litere

        frontPlate.text = numarInmatriculare;
        backPlate.text = numarInmatriculare;
        Debug.Log(numarInmatriculare);

    }


}
