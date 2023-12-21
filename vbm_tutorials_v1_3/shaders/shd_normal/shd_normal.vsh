//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;                  // (x,y,z)
attribute vec3 in_Normal;                  // (x,y,z)
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec3 v_vNormal;	// Normal vector to pass to fragment shader
varying vec3 v_vLightDir;	// Light vector to pass to fragment shader
varying vec3 v_vEyeDir;	// Eye vector to pass to fragment shader

// Uniforms - Passed in in draw call
uniform vec3 u_lightpos;	// Passed in in draw call
uniform vec3 u_eyepos;	// Passed in in draw call

void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    vec4 object_space_nor = vec4( in_Normal.x, in_Normal.y, in_Normal.z, 1.0);
	
	object_space_pos.y *= -1.0;	// Flip Y coordinate to match Blender's coordinate system
	object_space_nor.y *= -1.0;
	
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
	// Varyings ------------------------------------------------------------
    v_vColour = in_Colour;
    v_vTexcoord = in_TextureCoord;
	v_vNormal = (gm_Matrices[MATRIX_WORLD] * object_space_nor).xyz;	// Matrix MUST be first operand
	
	v_vLightDir = (u_lightpos*vec3(1.0,-1.0,1.0) - object_space_pos.xyz);
	v_vEyeDir = (u_eyepos*vec3(1.0,1.0,1.0) - object_space_pos.xyz);
}
