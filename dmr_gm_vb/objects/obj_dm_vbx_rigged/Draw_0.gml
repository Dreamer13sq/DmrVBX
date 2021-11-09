/// @desc

gpu_push_state();

// GPU State
gpu_set_cullmode(demo.cullmode);	// Don't draw tris facing away from camera
gpu_set_ztestenable(true);	// Enable depth checking per pixel
gpu_set_zwriteenable(true);	// Enable depth writing per pixel

shader_set(shd_rigged);

// Set Uniforms
drawmatrix = FetchDrawMatrix();

shader_set_uniform_f_array(u_shd_rigged_drawmatrix, drawmatrix);
shader_set_uniform_f_array(u_shd_rigged_light, obj_modeltest.lightdata);

// Pose
shader_set_uniform_matrix_array(u_shd_rigged_matpose, matpose);

matrix_set(matrix_world, matrix_build(
	obj_modeltest.modelposition[0], 
	obj_modeltest.modelposition[1],
	obj_modeltest.modelposition[2], 
	0, 0, -obj_modeltest.modelzrot, 1, 1, 1));

// Draw Meshes
var n = vbx.vbcount;
var _primitivetype = demo.wireframe? pr_linelist: pr_trianglelist;
for (var i = 0; i < n; i++)
{
	if meshvisible[i]
	{
		if demo.usetextures {vertex_submit(vbx.vb[i], _primitivetype, meshtexture[i]);}
		else {vertex_submit(vbx.vb[i], _primitivetype, -1);}
	}
}

// Restore State
shader_reset();
gpu_pop_state();
