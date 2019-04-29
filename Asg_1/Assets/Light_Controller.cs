using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Light_Controller : MonoBehaviour
{
    public GameObject light1;
    public GameObject light2;
    public GameObject light3;
    // Start is called before the first frame update
    void Start()
    {
    }

    // Update is called once per frame
    void Update()
    {
        transform.Rotate(new Vector3(15, 30, 45) * Time.deltaTime);
        light1.transform.LookAt(transform);
        light2.transform.LookAt(transform);
        light3.transform.LookAt(transform);
    }
}
