/// @desc Layout

// Inherit the parent event
event_inherited();

layout.Label("Complete VB");

// Mesh
var b = layout.Box("Meshes");
var l = b.List()
	.Operator(OP_MeshSelect)
	.DefineControl(self, "meshselect");
for (var i = 0; i < vbx.vbcount; i++)
{
	l.DefineListItem(i, vbx.vbnames[i], vbx.vbnames[i]);
}
b.Bool("Visible").SetIDName("meshvisible")
	.DefineControl(self, "meshvisible", meshselect);

layout.Real("Skin SSS").DefineControl(self, "skinsss").SetBounds(0, 1).operator_on_change = true;

// Playback
layout.Bool("Play Animation").DefineControl(self, "isplaying").Operator(OP_TogglePlayback);
layout.Real("Pos")
	.Operator(OP_ChangeTrackPos)
	.DefineControl(self, "trackpos")
	.SetBounds(0, 1, 0.02)
	.Description("Toggle animation playback")
	.operator_on_change = true;
layout.Button("Bind Pose").Operator(OP_BindPose);

// Pose
var l = layout.Dropdown("Poses").List().Operator(OP_PoseMarkerJump);
for (var i = 0; i < trackdata_poses.markercount; i++)
{
	l.DefineListItem(i, trackdata_poses.markernames[i]);
}

var e = layout.Enum("Interpolation")
	.Operator(OP_SetInterpolation)
	.DefineControl(self, "interpolationtype")
	.DefineListItems([
		[AniTrack_Intrpl.constant, "Constant", "Floors keyframe position when evaluating pose"],
		[AniTrack_Intrpl.linear, "Linear", "Linearly keyframe position when evaluating pose"],
		[AniTrack_Intrpl.smooth, "Square", "Uses square of position difference when evaluating pose"]
		])
	.Description("Method of blending together transforms when evaluating animation.");

CommonLayout(true, true, false);
