Shader "Unlit/GradientMapShader"
{
	Properties {
		[NoScaleOffset] _MainTex("Texture", 2D) = "white" {}
		[NoScaleOffset] _GradientTexture("Texture", 2D) = "white" {}
	}
	SubShader {
		Pass {

			CGPROGRAM

			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"

			uniform sampler2D _MainTex;
			uniform sampler2D _GradientTexture;
			uniform float4 _Color;

			struct vertexInput {
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct vertexOutput {
				float4 vertex : SV_POSITION;
				float2 uv : TEXCOORD0;
			};

			vertexOutput vert(vertexInput i) {

				vertexOutput o;

				o.vertex = mul(UNITY_MATRIX_MVP, i.vertex);
				o.uv = i.uv;

				return o;

			}

			fixed4 frag (vertexOutput i) : SV_Target {

				fixed4 texPoint = tex2D(_MainTex, i.uv);
				fixed3 grayScale = dot(texPoint.xyz, fixed3(0.299, 0.587, 0.114));

				fixed4 gradientTexPoint = tex2D(_GradientTexture, float2(grayScale.x, 0.5));

				return gradientTexPoint;
			}

			ENDCG

		}
	}
}
