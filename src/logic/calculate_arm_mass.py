# ============================================================================
# PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - AIRFRAME WEIGHT METRICS VAULT
# SUB-MODULE: AUTOMATED UPPER LIMB MASS LOGISTICS (CALCULATE_ARM_MASS.PY)
# DESIGN LAUNCH PARAMETERS: REAL-TIME SOLID-STATE CORE CONDUIT WEIGHT TALLY
# COMPATIBILITY: UNIVAC-IX 3VL COMPILER QUEUE / 16.7M RESCALED CHASSIS HULL
# ============================================================================

def execute_upper_limb_mass_tally():
    """
    Computes absolute volumetric mass profiles and vertical center of gravity 
    indices across all cast runner components within the arm assemblies.
    """
    # Material Density Baselines (kg/m^3)
    density_ti_al = 4430        # High-strength Titanium-Aluminide 
    density_copper = 8960       # 4oz Heavy power bus rails
    density_diecast = 7850      # Reinforced wrist/palm insert structures
    
    # Structural and copper volumetric allocation data structures (m^3)
    components = {
        "Shoulder_Linkages_G4_G5": {"vol_m3": 0.164, "density": density_ti_al, "copper_vol": 0.008},
        "Upper_Arm_Bones_B13_B14": {"vol_m3": 0.150, "density": density_ti_al, "copper_vol": 0.006},
        "Bicep_Armor_Shells_B17_B18": {"vol_m3": 0.116, "density": density_ti_al, "copper_vol": 0.000},
        "Forearm_Rods_B3_B4": {"vol_m3": 0.122, "density": density_ti_al, "copper_vol": 0.004},
        "Forearm_Armor_C6_C7": {"vol_m3": 0.088, "density": density_ti_al, "copper_vol": 0.000},
        "Wrist_Anchors_A11_A12": {"vol_m3": 0.044, "density": density_diecast, "copper_vol": 0.002},
        "Palm_Bases_G19_G20": {"vol_m3": 0.062, "density": density_diecast, "copper_vol": 0.002},
        "Finger_Phalanges_J1_J8": {"vol_m3": 0.080, "density": density_ti_al, "copper_vol": 0.002},
        "Twin_Buster_Rifles_D1_D2": {"vol_m3": 0.330, "density": density_ti_al, "copper_vol": 0.024},
        "Rifle_Stock_Guards_D3_D4": {"vol_m3": 0.076, "density": density_ti_al, "copper_vol": 0.004}
    }
    
    # Local coordinate distances from shoulder pivot center downward along the limb (meters)
    positions = {
        "Shoulder_Linkages_G4_G5": 0.0,
        "Upper_Arm_Bones_B13_B14": -0.5,
        "Bicep_Armor_Shells_B17_B18": -0.5,
        "Forearm_Rods_B3_B4": -1.6,
        "Forearm_Armor_C6_C7": -1.6,
        "Wrist_Anchors_A11_A12": -2.2,
        "Palm_Bases_G19_G20": -2.7,
        "Finger_Phalanges_J1_J8": -2.8,
        "Twin_Buster_Rifles_D1_D2": -2.5,
        "Rifle_Stock_Guards_D3_D4": -2.0
    }
    
    total_mass_kg = 0.0
    weighted_y_moment = 0.0
    component_breakdown = {}
    
    for name, data in components.items():
        base_alloy_mass = (data["vol_m3"] - data["copper_vol"]) * data["density"]
        embedded_copper_mass = data["copper_vol"] * density_copper
        element_total_mass = base_alloy_mass + embedded_copper_mass
        
        total_mass_kg += element_total_mass
        weighted_y_moment += element_total_mass * positions[name]
        component_breakdown[name] = round(element_total_mass, 2)
        
    center_of_gravity_y = weighted_y_moment / total_mass_kg
    
    return total_mass_kg, center_of_gravity_y, component_breakdown

if __name__ == "__main__":
    mass, cog_y, details = execute_upper_limb_mass_tally()
    
    print("=== [UNIVAC-IX AIRFRAME MASS LOGISTICS LOGS] ===")
    print(f"Total Upper Extremity Weight: {round(mass, 2)} kg")
    print(f"Vertical Center of Gravity Index: {round(cog_y, 3)} meters")
    print("------------------------------------------------")
    for component, weight in details.items():
        print(f"Module Station: {component.ljust(28)} | Net Mass: {weight} kg")
    print("================================================")
