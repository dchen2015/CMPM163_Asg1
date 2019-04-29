Shader "Custom/Procedural"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Color ("Color", Color) = (0, 0, 0, 0)
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            #pragma multi_compile_fog

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            float4 _Color;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                float s = i.uv.x;
                float t = i.uv.y;

                float sum = floor(abs(sin(s)) * 25) + floor(abs(sin(t)) * 25);
                int result = (sum % 5);
                
                float col = (1, 1, 1, 0);
                if (result == 0) {
                    col = (1, 0, 0, 0);
                } else if (result == 1) {
                    col = (0, 1, 0, 0);
                } else if (result == 2) {
                    col = (0, 0, 1, 0);
                } else if (result == 3) {
                    col = (1, 1, 0, 1);
                } else if (result == 4) {
                    col = (0, 1, 1, 1);
                }
                

                return col;
            }
            ENDCG
        }
    }
}
