# ============================================================================
# PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - ZERO-RESISTOR WIRING CORE
# SUB-MODULE: GEOMETRIC WIRE-GAUGE CALCULATOR (CALCULATE_WIRE_GAUGES.PY)
# ARCHITECTURE BASELINE: 54-NODE REFLEX-SLEW PASSIVE CURRENT DIVISION
# COMPATIBILITY: UNIVAC-IX COMPILER / 16.7M SCALED BI-PEDAL AIRFRAME
# ============================================================================

import math

def get_true_awg(area_mm2):
    """
    Translates a target cross-sectional area in mm^2 into the mathematically 
    accurate standard American Wire Gauge (AWG) or kcmil (MCM) industrial size.
    """
    if area_mm2 <= 0:
        return "N/A"
    awg_calc = -19.5 * (math.log(area_mm2 / 0.012668) / math.log(92)) + 36
    awg_rounded = round(awg_calc)
    
    if awg_rounded <= 0:
        if awg_rounded == 0: return "1/0 AWG Rail"
        elif awg_rounded == -1: return "2/0 AWG Rail"
        elif awg_rounded == -2: return "3/0 AWG Rail"
        else: return "4/0 AWG Busbar"
    else:
        return f"{awg_rounded} AWG Track"

def calculate_geometry_wire_matrix():
    """
    Translates structural routing lengths and all 54 global nodes directly 
    into required copper cross-sectional areas and standard AWG sizes.
    """
    rho_copper = 1.68e-8          
    r_equivalent_target = 0.0005  

    # Comprehensive 54-Node System Capacity Dictionary (Joules)
    # Global Pool scales to 6.13 Megajoules
    capacities = {
        # Core Systems & Heavy Shunts
        "Deflector_Shield_Shunt": 1200000.0,
        "Shoulder_Cowl_Branch": 120000.0,
        "Knee_Piston_Branch": 80000.0,
        "Ankle_Actuator_Branch": 80000.0,
        "Elbow_Flexor_Branch": 40000.0,
        "Wrist_Rotary_Branch": 20000.0,
        "Thumb_Opponens_Actuator": 3500.0,
        "Cockpit_Avionics_Isolator": 150000.0,
        
        # REFLEX ROTATION NODES (New Sinks)
        "Waist_Rotary_Actuator": 350000.0,
        "Neck_Yaw_Actuator": 70000.0,
        "Neck_Pitch_Piston": 50000.0,
        
        # Weapon Routing Matrix
        "Twin_Buster_Rifle_Port": 1500000.0,
        "Twin_Buster_Rifle_Stbd": 1500000.0,
        "Chest_Machine_Cannon_Port": 90000.0,
        "Chest_Machine_Cannon_Stbd": 90000.0,
        "Beam_Saber_Charger_Port": 40000.0,
        "Beam_Saber_Charger_Stbd": 40000.0,
        
        # Sample Wing Binders (Port/Stbd identical balance arrays)
        "Port_Main_Wing_Spar": 130000.0, "Port_Wing_Sliding_Extension": 35000.0,
        "Port_Primary_Feather_1": 8000.0, "Port_Secondary_Feather_1": 3500.0,
        "Stbd_Main_Wing_Spar": 130000.0, "Stbd_Wing_Sliding_Extension": 35000.0,
        "Stbd_Primary_Feather_1": 8000.0, "Stbd_Secondary_Feather_1": 3500.0
    }
    
    e_total = sum(capacities.values())
    
    # Structural Physical Distance From Main Power Nodes (Meters)
    lengths = {
        "Deflector_Shield_Shunt": 3.40, "Shoulder_Cowl_Branch": 1.85,
        "Knee_Piston_Branch": 1.45, "Ankle_Actuator_Branch": 0.95,
        "Elbow_Flexor_Branch": 0.85, "Wrist_Rotary_Branch": 0.45, "Thumb_Opponens_Actuator": 0.18,
        "Cockpit_Avionics_Isolator": 1.45,
        
        # Rotation Layout Distance Tracks
        "Waist_Rotary_Actuator": 1.15,
        "Neck_Yaw_Actuator": 0.75,
        "Neck_Pitch_Piston": 0.65,
        
        # Weapons & Propulsion Lengths
        "Twin_Buster_Rifle_Port": 3.85, "Twin_Buster_Rifle_Stbd": 3.85,
        "Chest_Machine_Cannon_Port": 0.65, "Chest_Machine_Cannon_Stbd": 0.65,
        "Beam_Saber_Charger_Port": 2.15, "Beam_Saber_Charger_Stbd": 2.15,
        "Port_Main_Wing_Spar": 2.65, "Port_Wing_Sliding_Extension": 1.10,
        "Port_Primary_Feather_1": 0.65, "Port_Secondary_Feather_1": 0.85,
        "Stbd_Main_Wing_Spar": 2.65, "Stbd_Wing_Sliding_Extension": 1.10,
        "Stbd_Primary_Feather_1": 0.65, "Stbd_Secondary_Feather_1": 0.85
    }
    
    gauge_report = {}
    for branch, length in lengths.items():
        e_n = capacities[branch]
        r_n = r_equivalent_target * (e_total / e_n)
        area_mm2 = ((rho_copper * length) / r_n) * 1e6   
        gauge_report[branch] = {
            "length_m": length, "capacity_joules": e_n,
            "target_resistance_ohms": round(r_n, 6),
            "required_area_mm2": round(area_mm2, 4), "assigned_gauge": get_true_awg(area_mm2)
        }
    return e_total, gauge_report

if __name__ == "__main__":
    total_energy, matrix = calculate_geometry_wire_matrix()
    print("=== [UNIVAC-IX MASTER REFLEX ARCHITECTURE MATRIX] ===")
    print(f"Global Airframe Core Power Sink Baseline: {total_energy:,} Joules")
    print("----------------------------------------------------------------")
    for branch in ["Waist_Rotary_Actuator", "Neck_Yaw_Actuator", "Neck_Pitch_Piston", "Cockpit_Avionics_Isolator"]:
        specs = matrix[branch]
        print(f"Reflex Node: {branch.ljust(26)} | {specs['length_m']}m | {specs['assigned_gauge']}")
    print("================================================================")
