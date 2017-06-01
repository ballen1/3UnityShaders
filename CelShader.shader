// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

Shader "Unlit/CelShader"
{
	Properties {
		[NoScaleOffset] _Texture("Texture", 2D) = "white" {}
		_MaxLightThres("Threshold for Maximum Light Intensity", Range(0.7, 1.0)) = 0.90
		_Divs("Number of Discrete Lighting Divisions", Int) = 3
	}
	SubShader {
		Pass {

			Tags {"LightMode" = "ForwardBase"}

			CGPROGRAM

			#pragma vertex vert
			#pragma fragment frag

			uniform sampler2D _Texture;
			uniform int _Divs;
			uniform float _MaxLightThres;

			// Built in Unity values
			uniform fixed4 _LightColor0;

			struct vertexInput {
				float4 vertex : POSITION;
				float4 normal : NORMAL;
				float2 uv : TEXCOORD0;
			};

			struct vertexOutput {

				float4 vertex : SV_POSITION;
				float4 normal : NORMAL;
				float2 uv : TEXCOORD0;

			};

			vertexOutput vert(vertexInput i) {

				vertexOutput o;

				o.vertex = mul(UNITY_MATRIX_MVP, i.vertex);
				o.normal = i.normal;
				o.uv = i.uv;

				return o;

			}

			fixed4 frag (vertexOutput i) : SV_TARGET {

				float3 lightDir = normalize(_WorldSpaceLightPos0.xyz);
				float3 normalDirection = normalize(float3(mul(float4(i.normal.xyz, 0.0), unity_WorldToObject).xyz));

				float lightIntensity = max(0.0, dot(lightDir, normalDirection));

				float divSize = _MaxLightThres/_Divs;

				float3 diffuseLight;

				if (lightIntensity > _MaxLightThres) {
					diffuseLight = float3(1.0, 1.0, 1.0);
				}
				else if (lightIntensity < divSize) {
					diffuseLight = float3(0.0, 0.0, 0.0);
				}
				else {
					for (int i = 1; i <= _Divs; ) {
						if (lightIntensity >= divSize*i && lightIntensity < (divSize*(++i))) {
					 		float val = divSize*i;
					 		diffuseLight = float3(val, val, val);
					 		break;	
						}
					}
				}


				diffuseLight *= _LightColor0.rgb;

				fixed4 lightedTex = tex2D(_Texture, i.uv) * fixed4(diffuseLight, 1.0);

				return lightedTex;
			}

			ENDCG

		}
	}
}
