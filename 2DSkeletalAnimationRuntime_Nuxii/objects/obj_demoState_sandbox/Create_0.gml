/// @desc sandbox
var PATH_PALIA = "Skeletons/DragonBones/Nuxii/Palia/";
// armature
var file = file_text_open_read(PATH_PALIA+"Palia_Skeleton_ske.json");
var raw = "";
do{	raw += file_text_read_string(file);
	file_text_readln(file);
}until(file_text_eof(file));
file_text_close(file);
armature = sk_armature_build_dragonbones(raw,0);
if(!sk_struct_isof(armature,sk_type_armature)){
	show_message("armature doesn't exist");
	game_end();
}
// atlas
file = file_text_open_read(PATH_PALIA+"Palia_Skeleton_tex.json");
raw = "";
do{	raw += file_text_read_string(file);
	file_text_readln(file);
}until(file_text_eof(file));
file_text_close(file);
atlas = sk_atlas_build_dragonbones(raw,1);
if(!sk_struct_isof(atlas,sk_type_atlas)){
	show_message("atlas doesn't exist");
	game_end();
}
sk_atlas_set_page(atlas,sprite_add(PATH_PALIA+"Palia_Skeleton_tex.png",0,false,false,0,0),0);

#region
var constraint = sk_constraint_create_physics("phys",sk_armature_find(armature,sk_type_bone,"b_wrist_left"));
sk_constraint_physics_set_rigid(constraint,false);
//sk_constraint_physics_set_bone_effector(constraint,sk_armature_find(armature,sk_type_bone,"b_wrist_right"));
	var b = sk_bone_create("a",noone); sk_bone_set_length(b,5); sk_constraint_physics_system_add(constraint,b); sk_armature_add(armature,b);
		b = sk_bone_create("b",noone); sk_bone_set_length(b,5); sk_constraint_physics_system_add(constraint,b); sk_armature_add(armature,b);
		b = sk_bone_create("c",noone); sk_bone_set_length(b,5); sk_constraint_physics_system_add(constraint,b); sk_armature_add(armature,b);
		b = sk_bone_create("d",noone); sk_bone_set_length(b,5); sk_constraint_physics_system_add(constraint,b); sk_armature_add(armature,b);
		b = sk_bone_create("e",noone); sk_bone_set_length(b,5); sk_constraint_physics_system_add(constraint,b); sk_armature_add(armature,b);
		b = sk_bone_create("f",noone); sk_bone_set_length(b,5); sk_constraint_physics_system_add(constraint,b); sk_armature_add(armature,b);
sk_armature_add(armature,constraint);
sk_armature_updateCache(armature);
#endregion

#region
sk_animation_apply(sk_armature_find(armature,sk_type_animation,"display_costume_top_classic"),0,0,sk_mixPose_overwrite,1,false);
sk_animation_apply(sk_armature_find(armature,sk_type_animation,"display_costume_bottom_classic"),0,0,sk_mixPose_overwrite,1,false);
#endregion

#region
animationState = sk_animationState_create("");
sk_animationState_add_animations_from_armature(animationState,armature);
sk_animationState_set_animation_mix(animationState,"anim_run","anim_skid",0.2);
sk_animationState_set_default_mix(animationState,0.05);
#endregion

v_phys = ds_map_create();
v_buff = vertex_create_buffer();
bufftex = -1;

// temp
ratio = 0;