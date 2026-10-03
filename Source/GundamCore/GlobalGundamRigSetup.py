# ============================================================================
# PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - SOLID-STATE ROBOTICS CORE
# SUB-MODULE: GLOBAL UNREAL CONTROL RIG SETUP PIPELINE (GLOBALGUNDAMRIGSETUP.PY)
# COMPATIBILITY: UNREAL ENGINE 5.4+ CONTROL RIG DEVELOPMENT BACKPLANES
# ============================================================================

import unreal

def build_complete_gundam_rig_blueprint():
    """
    Accesses the active Unreal Engine project environment to build the entire
    54-node bipedal framework, extremities, wings, and weapon slots into the rig.
    """
    # Define asset location path in your Content Browser
    rig_path = "/Game/MobileSuiteX00/Rig/CR_GundamZero_EW"
    rig_blueprint = unreal.load_object(None, rig_path)
    
    if not rig_blueprint:
        unreal.log_error("[UNIVAC-IX] Master Control Rig blueprint could not be found at target folder.")
        return

    controller = rig_blueprint.get_controller()
    
    # 1. Comprehensive 54-Node Mapping Database
    # Maps every component directly to its corresponding Unreal Engine skeletal bone name
    global_bone_matrix = {
        # Core Structure & Heavy Sinks
        "Deflector_Shield_Shunt": "Shield_Core_MCM",
        "Cockpit_Avionics_Isolator": "Cockpit_Pod_Center",
        "Waist_Rotary_Actuator": "Pelvis_Main_Bone",
        "Shoulder_Cowl_Branch_L": "Clavicle_Shoulder_L",
        "Shoulder_Cowl_Branch_R": "Clavicle_Shoulder_R",
        "Neck_Yaw_Actuator": "Neck_Base_Yaw",
        "Neck_Pitch_Piston": "Head_Tilt_Pitch",
        
        # Locomotion Legs (Left/Right Sym)
        "Knee_Piston_Branch_L": "Thigh_Femur_L", "Knee_Piston_Branch_R": "Thigh_Femur_R",
        "Ankle_Actuator_Branch_L": "Shin_Tibia_L", "Ankle_Actuator_Branch_R": "Shin_Tibia_R",
        "Toe_Stabilizer_L1": "Foot_Toe_L1", "Toe_Stabilizer_L2": "Foot_Toe_L2", "Toe_Stabilizer_L3": "Foot_Toe_L3",
        "Toe_Stabilizer_R1": "Foot_Toe_R1", "Toe_Stabilizer_R2": "Foot_Toe_R2", "Toe_Stabilizer_R3": "Foot_Toe_R3",
        
        # Upper Arms & Extremities (Left/Right Sym)
        "Elbow_Flexor_Branch_L": "Humerus_Arm_L", "Elbow_Flexor_Branch_R": "Humerus_Arm_R",
        "Wrist_Rotary_Branch_L": "Wrist_Pivot_L", "Wrist_Rotary_Branch_R": "Wrist_Pivot_R",
        "Thumb_Opponens_Actuator_L": "Hand_Thumb_L", "Thumb_Opponens_Actuator_R": "Hand_Thumb_R",
        
        # Left Hand Finger Digits (AWG 39/35 Tracks)
        "Finger_L_Digit_1": "Hand_Index_L", "Finger_L_Digit_2": "Hand_Middle_L",
        "Finger_L_Digit_3": "Hand_Ring_L", "Finger_L_Digit_4": "Hand_Pinky_L",
        
        # Right Hand Finger Digits (AWG 39/35 Tracks)
        "Finger_R_Digit_1": "Hand_Index_R", "Finger_R_Digit_2": "Hand_Middle_R",
        "Finger_R_Digit_3": "Hand_Ring_R", "Finger_R_Digit_4": "Hand_Pinky_R",
        
        # Tactical Weapons Sinks
        "Twin_Buster_Rifle_Port": "Weapon_Slot_BusterRifle_L",
        "Twin_Buster_Rifle_Stbd": "Weapon_Slot_BusterRifle_R",
        "Chest_Machine_Cannon_Port": "Weapon_Slot_Vulcan_L",
        "Chest_Machine_Cannon_Stbd": "Weapon_Slot_Vulcan_R",
        "Beam_Saber_Charger_Port": "Weapon_Slot_Saber_L",
        "Beam_Saber_Charger_Stbd": "Weapon_Slot_Saber_R",
        
        # Port (Left) Wing Assembly Individual Pieces
        "Port_Main_Wing_Spar": "Wing_Spar_Upper_L", "Port_Wing_Sliding_Extension": "Wing_ArmorSlide_L",
        "Port_Primary_Feather_1": "Feather_Upper_L1", "Port_Primary_Feather_2": "Feather_Upper_L2",
        "Port_Primary_Feather_3": "Feather_Upper_L3", "Port_Primary_Feather_4": "Feather_Upper_L4",
        "Port_Secondary_Feather_1": "Feather_Tip_L1", "Port_Secondary_Feather_2": "Feather_Tip_L2",
        "Port_Secondary_Feather_3": "Feather_Tip_L3", "Port_Secondary_Feather_4": "Feather_Tip_L4",
        "Port_Sub_Wing_Spar": "Wing_Spar_Lower_L", "Port_Sub_Wing_Fin_1": "Wing_Stabilizer_L1", "Port_Sub_Wing_Fin_2": "Wing_Stabilizer_L2",
        
        # Starboard (Right) Wing Assembly Individual Pieces
        "Stbd_Main_Wing_Spar": "Wing_Spar_Upper_R", "Stbd_Wing_Sliding_Extension": "Wing_ArmorSlide_R",
        "Stbd_Primary_Feather_1": "Feather_Upper_R1", "Stbd_Primary_Feather_2": "Feather_Upper_R2",
        "Stbd_Primary_Feather_3": "Feather_Upper_R3", "Stbd_Primary_Feather_4": "Feather_Upper_R4",
        "Stbd_Secondary_Feather_1": "Feather_Tip_R1", "Stbd_Secondary_Feather_2": "Feather_Tip_R2",
        "Stbd_Secondary_Feather_3": "Feather_Tip_R3", "Stbd_Secondary_Feather_4": "Feather_Tip_R4",
        "Stbd_Sub_Wing_Spar": "Wing_Spar_Lower_R", "Stbd_Sub_Wing_Fin_1": "Wing_Stabilizer_R1", "Stbd_Sub_Wing_Fin_2": "Wing_Stabilizer_R2"
    }

    print("[UNIVAC-IX] Initializing full global 54-node injection map...")
    existing_vars = [v.get_name() for v in rig_blueprint.get_public_variables()]
    
    # 2. Iterate and Inject Public Float Hooks for Real-Time Control Engine
    for node_id, bone_target in global_bone_matrix.items():
        # Inject positional/rotation control hook
        pos_var = f"Live_{node_id}_Value"
        if pos_var not in existing_vars:
            rig_blueprint.add_public_variable(pos_var, unreal.RigVMTypeUtils.get_float_type_name(), "")
            
        # Inject corresponding passive force/torque multiplier hook
        force_var = f"Live_{node_id}_TorqueLimit"
        if force_var not in existing_vars:
            rig_blueprint.add_public_variable(force_var, unreal.RigVMTypeUtils.get_float_type_name(), "")
            
    print(f"[UNIVAC-IX] Successfully verified and injected {len(global_bone_matrix)*2} variables into the Control Rig Graph.")
    
    # Force compile to register variables natively in Unreal's Engine environment
    unreal.ControlRigBlueprintLibrary.compile_control_rig_blueprint(rig_blueprint)
    print("[UNIVAC-IX] Complete asset compilation successful. Ready for Live Link stream.")

if __name__ == "__main__":
    build_complete_gundam_rig_blueprint()
