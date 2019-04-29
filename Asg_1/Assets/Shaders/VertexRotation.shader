//Rotation matrices taken from Wikipedia page (https://en.wikipedia.org/wiki/Rotation_matrix)
Shader "Custom/VertexRotation"
{
    Properties
    {
        _Color ("Color", Color) = (0, 0, 0, 0)
        _MainTex ("Texture", 2D) = "white" {}
        _Speed ("Speed", Float) = 1.0
        _HiClass ("Hello", Float) = 1.0
        _Twistiness ("Twistiness", Float) = 1.0
    }
    SubShader
    {
      

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"
            
            
            uniform float _Speed;
            uniform float _Twistiness;
           
            
            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal: NORMAL;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;  
                float3 normal : NORMAL;
                float2 uv : TEXCOORD0;
                float timeVal : Float;
            };
            
            
            float3x3 getRotationMatrixX (float theta) {
                
                float s = -sin(theta);
                float c = cos(theta);
                return float3x3(1, 0, 0, 0, c, -s, 0, s, c);
            }
            
            float3x3 getRotationMatrixY (float theta) {
                
                float s = -sin(theta);
                float c = cos(theta);
                return float3x3(c, 0, s, 0, 1, 0, -s, 0, c) ;
            }
            
            float3x3 getRotationMatrixZ (float theta) {
                
                float s = -sin(theta);
                float c = cos(theta);
                return float3x3(c, -s, 0, s, c, 0, 0, 0, 1);
            }
            
            float4 _Color;
            sampler2D _MainTex;
            float4 _MainTex_ST;
            
            v2f vert (appdata v)
            {
                v2f o;
                
                const float PI = 3.14159;
                
                float rad = sin(_Time.y * _Speed) * PI; //Rotate back and forth for one loop

                float3x3 rotationMatrix = getRotationMatrixX(rad);
                
                float3 rotatedVertex = mul(rotationMatrix, v.vertex.xyz);
                
                float rad1 = sin(_Time.y * _Speed);
                
                float useTwist = 10.0;
                
                if (_Twistiness >= 10.0) {
                    useTwist = 0.01;
                } else if (_Twistiness <= 0.0) {
                    useTwist = 10;    
                } else {
                    useTwist = 10 - _Twistiness;
                }
                
                float ct = cos(v.vertex.y/useTwist);
                float st = sin(v.vertex.y/useTwist);
               
                float newx = v.vertex.x + (v.vertex.x * ct * rad1 - v.vertex.z * st * rad1 ); 
                float newz = v.vertex.z + (v.vertex.x * st * rad1 + v.vertex.z * ct * rad1); 
                float newy = v.vertex.y ;
                
                float4 xyz = float4( rotatedVertex + (newx, newy, newz), 1.0 );
                
                o.vertex = UnityObjectToClipPos(xyz);
                o.normal = v.normal;
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
               
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 col = tex2D(_MainTex, i.uv);
                return (col);
            }
            ENDCG
        }
    }
}
