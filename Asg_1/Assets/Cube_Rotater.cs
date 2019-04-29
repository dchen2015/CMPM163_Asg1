using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Cube_Rotater : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        transform.Rotate(new Vector3(34, 27, 78) * Time.deltaTime * 0.2f);
    }
}
