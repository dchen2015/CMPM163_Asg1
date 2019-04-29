using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MousePosition : MonoBehaviour
{
    Renderer render;

    // Start is called before the first frame update
    void Start()
    {
        render = GetComponent<Renderer>();

        //render.material.shader = Shader.Find("Custom/Edge");
    }

    // Update is called once per frame
    void Update()
    {
        render.material.SetFloat("_Mix", Input.mousePosition.x / 500f);
        render.material.SetFloat("_LookUpDistance", Input.mousePosition.y / 10f);


        //Debug.Log(Input.mousePosition);
    }
}
