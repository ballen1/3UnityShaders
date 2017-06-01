Shader "Unlit/FullScreenEffectShader"
{
	Properties {
		_MadnessColor("Madness Color", Color) = (1.0, 1.0, 1.0, 1.0)
		[NoScaleOffset] _MainTex("Texture", 2D) = "white" {}
		_ShakeAmount("Shakiness", Range(0.0, 0.01)) = 0.1
		_Blurriness("Blurriness", Int) = 1
		_TextureWidth("Texture Width", Float) = 1000.0
		_TextureHeight("Texture Height", Float) = 1000.0
		[Toggle] _Insanity("Insanity", Float) = 0
	}
	SubShader {
		Pass {

			CGPROGRAM

			#pragma vertex vert
			#pragma fragment frag

			uniform sampler2D _MainTex;
			uniform float4 _MadnessColor;
			uniform float _ShakeAmount;
			uniform int _Blurriness;
			uniform float _TextureWidth;
			uniform float _TextureHeight;
			uniform int _Insanity;

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

				i.uv.x += sin(_Time.w*10) * _ShakeAmount;
				i.uv.y += cos(_Time.w*35) * _ShakeAmount;
				o.uv = i.uv;

				o.vertex = mul(UNITY_MATRIX_MVP, i.vertex);

				return o;

			}

			fixed4 frag (vertexOutput i) : SV_Target {

				// Blur effect
				fixed4 sum = float4(0.0, 0.0, 0.0, 0.0);

				float kernel = _Blurriness;

				float xStep = 1.0 / _TextureWidth;
				float yStep = 1.0 / _TextureHeight;

				int kernelDimension = 2*kernel+1;

				float weight = 1.0/(kernelDimension*kernelDimension);

				for (int x = -kernel; x <= kernel; x++) {
					for (int y = -kernel; y <= kernel; y++) {
						sum += tex2D(_MainTex, fixed2(i.uv.x + (x * xStep), i.uv.y + (y * yStep))) * weight;
					}
				}

				// Add madness color tint
				fixed4 texPoint = sum * _MadnessColor;

				// Vary the blue value with time
				texPoint = texPoint * fixed4(1.0, 1.0, sin(_Time.z), 1.0);

				if (_Insanity == 1) {

					float vary = sin(_Time.w*10);

					if (vary > 0 && fmod(floor(i.uv.y*100), 2) == 0) {
						texPoint = fixed4(0.0, 0.0, 0.0, 1.0);
					}

					if (vary < 0 && fmod(floor(i.uv.x*20*cos(_Time.y)), 3) == 0) {
						texPoint = fixed4(abs(sin(_Time.x))-0.5, 0.0, 0.0, 1.0);
					}

				}

				return texPoint;
			}

			ENDCG

		}
	}
}
