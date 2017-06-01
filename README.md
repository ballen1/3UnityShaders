# 3 Unity Shaders
This project demonstrates three individual shader effects which are implemented in Unity's Cg (HLSL)

### 1. Gradient Mapping

This shader effect allows someone to define a gradient and apply it to a texture within Unity. The customizing panel for the shader looks as follows:

![Alt text](gradient_shader_1.PNG?raw=true "Gradient Mapping Editor")

The two photos below demonstrate how the gradient mapping shader looks when applied to various textures:

![Alt text](gradient_shader_2.PNG?raw=true "Gradient Mapping Editor")
![Alt text](gradient_shader_3.PNG?raw=true "Gradient Mapping Editor")

### 2. Cel Shader

This shader is the commonly found cel shader effect. It reduces the spectrum of colors to discrete intervals. The customizing panel for the shader allows the user to define the number of discrete lighting divisions as well as how "wide" each lighting division is:

![Alt text](cel_shader1.PNG?raw=true "Gradient Mapping Editor")

The two photos below demonstrate how the cel shader looks when applied to various textures:

![Alt text](cel_shader2.PNG?raw=true "Gradient Mapping Editor")
![Alt text](cel_shader3.PNG?raw=true "Gradient Mapping Editor")

### 3. Full Screen Effect

This shader demonstrates a configurable full screen effect. The customization panel in Unity allows the developer to customize the shakiness, blurriness, and color of the full game screen. An "insanity" effect can be applied which makes the screen maximally shake and alters the colors of the screen over time.

![Alt text](full_screen1.PNG?raw=true "Gradient Mapping Editor")

This still screenshot demonstrates the blurriness and color effect:

![Alt text](full_screen2.PNG?raw=true "Gradient Mapping Editor")
