using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MaterialRandomizer : MonoBehaviour
{
    private string folderPath = "CarMaterials";
    private int lightMaterialPos;
    public Renderer carRenderer;

    void Start()
    {
        Material[] materials = Resources.LoadAll<Material>(folderPath);
        if (materials.Length > 0)
        {
            lightMaterialPos = materials.Length - 1;
            carRenderer.materials = new Material[] { materials[Random.Range(0, materials.Length - 2)], materials[lightMaterialPos]};
        }
        else
        {
            Debug.LogError("No materials found in the specified folder: " + folderPath);
        }
    }
}
