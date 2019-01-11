__SK_OBJECT_DEBUG_ASSERT_EXISTENCE = !sk_shear_timeline_exists(argument0);
/// @desc apply the timeline between two keyframes
/// @param timeline
/// @param keyframe_previous
/// @param keyframeA
/// @param keyframeB
/// @param amount
/// @param mixPose
/// @param alpha
/// @param events
var sk_target = argument0[sk_data_shear_timeline.target];
if(sk_target==undefined) then return;
var sk_keyframePrevious_id = argument1*SK_SHEAR_KEYFRAME_ENTRIES;
var sk_keyframeA_id = argument2*SK_SHEAR_KEYFRAME_ENTRIES;
var sk_keyframeB_id = argument3*SK_SHEAR_KEYFRAME_ENTRIES;
var sk_keyframes = argument0[sk_data_shear_timeline.keyframes];
var sk_amount = argument4;
var sk_mixPose = argument5;
var sk_alpha = argument6;
var sk_events = argument7;
// interpolate
var sk_interpolation = sk_ease(sk_amount,sk_keyframes[| sk_keyframeA_id+SK_SHEAR_KEYFRAME_EASE]);
var sk_x = lerp(
	sk_keyframes[| sk_keyframeA_id+SK_SHEAR_KEYFRAME_X],
	sk_keyframes[| sk_keyframeB_id+SK_SHEAR_KEYFRAME_X],
	sk_interpolation
);
var sk_y = lerp(
	sk_keyframes[| sk_keyframeA_id+SK_SHEAR_KEYFRAME_Y],
	sk_keyframes[| sk_keyframeB_id+SK_SHEAR_KEYFRAME_Y],
	sk_interpolation
);
// apply
switch(sk_mixPose){
	case SK_MIX_BLEND:
		var sk_xshear = sk_target[sk_data_bone.appliedXShear];
		var sk_yshear = sk_target[sk_data_bone.appliedYShear];
		sk_target[@ sk_data_bone.appliedXShear] = sk_xshear-angle_difference(sk_xshear,sk_target[sk_data_bone.setupXShear]+sk_x)*sk_alpha;
		sk_target[@ sk_data_bone.appliedYShear] = sk_yshear-angle_difference(sk_yshear,sk_target[sk_data_bone.setupYShear]+sk_y)*sk_alpha;
	break;
	case SK_MIX_ADD: 
		sk_target[@ sk_data_bone.appliedXShear] = sk_target[sk_data_bone.appliedXShear]+sk_x*sk_alpha;
		sk_target[@ sk_data_bone.appliedYShear] = sk_target[sk_data_bone.appliedYShear]+sk_y*sk_alpha;
	break;
	case SK_MIX_OVERWRITE:
		sk_target[@ sk_data_bone.setupXShear] = sk_target[sk_data_bone.setupXShear]+sk_x*sk_alpha;
		sk_target[@ sk_data_bone.setupYShear] = sk_target[sk_data_bone.setupYShear]+sk_y*sk_alpha;
	break;
}