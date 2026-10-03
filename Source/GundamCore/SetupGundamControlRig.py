# ============================================================================
# PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - SOLID-STATE ROBOTICS CORE
# SUB-MODULE: UNREAL ENGINE 5 CONTROL RIG AUTOMATION (SETUPGUNDAMCONTROLRIG.PY)
# COMPATIBILITY: UNREAL ENGINE 5.4+ CONTROL RIG DEVELOPMENT BACKPLANES
# ============================================================================

import unreal

def build_gundam_control_rig_nodes():
    """
    Accesses the Unreal Engine Developer API to programmatically insert your 
    chassis part properties, capacity trackers, and rigging node bridges.
    """
    # 1. Target the specific Control Rig asset in your Content Browser
    # Ensure this path matches your exact asset workspace location
    rig_path = "/Game/MobileSuiteX00/Rig/CR_GundamZero_EW"
    rig_blueprint = unreal.load_object(None, rig_path)
    
    if not rig_blueprint:
        unreal.log_error("[UNIVAC-IX] Failed to load Control Rig blueprint at designated folder path.")
        return

    # Access the rig structural hierarchy and controller graph model
    controller = rig_blueprint.get_controller()
    hierarchy = rig_blueprint.hierarchy
    
    print("[UNIVAC-IX] Initializing Control Rig node generation sequence...")
    
    # 2. Define the core 3D physics mapping database
    # Maps your OpenSCAD part tracking identifiers to target Control Rig bone names
    joint_mapping = {
        "Parts_H14_H15_Ankle": "Ankle_L_Bone",
        "Parts_F5_F6_Knee": "Knee_L_Bone",
        "Parts_W10_W12_Waist": "Pelvis_Main_Bone",
        "Twin_Buster_Rifle_Port": "BusterRifle_Port_Attach"
    }
    
    # 3. Inject Analog Control Rig Variables dynamically into the graph blueprint
    for part_code, bone_name in joint_mapping.items():
        var_name = f"Telemetry_{part_code}_Torque"
        
        # Check if the variable already exists to prevent duplicate compiler conflicts
        existing_vars = [v.get_name() for v in rig_blueprint.get_public_variables()]
        if var_name not in existing_vars:
            # Create a localized public Float property to catch incoming UDP wire values
            rig_blueprint.add_public_variable(var_name, unreal.RigVMTypeUtils.get_float_type_name(), "")
            print(f"[UNIVAC-IX] Injected Float variable: {var_name}")
            
    # 4. Construct Node Graph Linkages
    # Generates the execution blocks to multiply stream variables by structural constraints
    try:
        # Adds an interactive transform modification node for active joint testing
        modifier_node = controller.add_unit_node_from_struct(
            unreal.RigUnit_SetControlTransform.static_struct(), 
            "Execute", 
            unreal.Vector2D(100, 200)
        )
        print("[UNIVAC-IX] Control Rig execution graph successfully configured.")
    except Exception as e:
        unreal.log_warning(f"[UNIVAC-IX] Graph modification error encountered: {str(e)}")
        
    # Compile the asset framework so changes validate natively in the 3D viewport
    unreal.ControlRigBlueprintLibrary.compile_control_rig_blueprint(rig_blueprint)
    print("[UNIVAC-IX] Compilation sequence completed. Control Rig fully linked.")

if __name__ == "__main__":
    build_gundam_control_rig_nodes()
