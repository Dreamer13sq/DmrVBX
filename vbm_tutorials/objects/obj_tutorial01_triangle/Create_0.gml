/// @desc Camera Setup

// Camera ----------------------------------------------
width = window_get_width();
height = window_get_height();

fieldofview = 50;
znear = 1;
zfar = 100;

matproj = matrix_build_projection_perspective_fov(
	fieldofview, window_get_width()/window_get_height(), znear, zfar);
matview = matrix_build_lookat(0, 0, 6, 0, 0, 0, 0, 1, 0);
mattran = matrix_build_identity();

// Vertex format ---------------------------------------
vertex_format_begin();
vertex_format_add_position_3d();
vertex_format_add_color();
vertex_format_add_texcoord();
vbf_simple = vertex_format_end();

// Test Triangle ---------------------------------------
vb_tri = vertex_create_buffer();
vertex_begin(vb_tri, vbf_simple);

vertex_position_3d(vb_tri, -1, 0, 0);
vertex_color(vb_tri, c_red, 1);
vertex_texcoord(vb_tri, 0, 0);

vertex_position_3d(vb_tri, 1, 0, 0);
vertex_color(vb_tri, c_green, 1);
vertex_texcoord(vb_tri, 0, 0);

vertex_position_3d(vb_tri, 0, 2, 0);
vertex_color(vb_tri, c_blue, 1);
vertex_texcoord(vb_tri, 0, 0);

vertex_end(vb_tri);

