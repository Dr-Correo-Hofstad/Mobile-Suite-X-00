# ============================================================================
# PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - ZERO-RESISTOR WIRING CORE
# SUB-MODULE: GEOMETRIC WIRE-GAUGE CALCULATOR (CALCULATE_WIRE_GAUGES.PY)
# ARCHITECTURE BASELINE: RING TOPOLOGY PASSIVE LOAD DISTRIBUTION (EXTREMITIES)
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
    
    if awg_rounded == 0:
        return "1/0 AWG Rail"
    elif awg_rounded == -1:
        return "2/0 AWG Rail"
    elif awg_rounded == -2:
        return "3/0 AWG Rail"
    elif awg_rounded == -3:
        return "4/0 AWG Busbar"
    elif awg_rounded < -3:
        kcmil = round(area_mm2 * 1.97352)
        return f"{kcmil} kcmil Heavy Busbar"
    else:
        return f"{awg_rounded} AWG Track"

def calculate_geometry_wire_matrix():
    """
    Translates structural routing lengths and total extremity capacitor configurations
    directly into required copper cross-sectional areas and standard AWG sizes.
    """
    # 1. Physical and Material Constants
    rho_copper = 1.68e-8          # Material resistivity of pure copper (Ohm-meter)
    r_equivalent_target = 0.0005  # Target total system network resistance (Ohms)
    
    # 2. Complete 24-Node Capacitor Energy Matrix (Joules)
    # Scaled to incorporate fine-digit hand and foot control networks
    capacities = {
        "Wrist_Rotary_Branch": 20000.0,
        "Elbow_Flexor_Branch": 40000.0,
        "Main_Wing_Actuator_1": 130000.0,
        "Main_Wing_Actuator_2": 130000.0,
        "Knee_Piston_Branch": 80000.0,
        "Ankle_Actuator_Branch": 80000.0,
        "Shoulder_Cowl_Branch": 120000.0,
        "Deflector_Shield_Shunt": 1200000.0,
        # Micro-Extremities Expansion
        "Finger_Digit_1": 1500.0,
        "Finger_Digit_2": 1500.0,
        "Finger_Digit_3": 1500.0,
        "Finger_Digit_4": 1500.0,
        "Finger_Digit_5": 1500.0,
        "Thumb_Opponens_Actuator": 3500.0,
        "Toe_Stabilizer_1": 4000.0,
        "Toe_Stabilizer_2": 4000.0,
        "Toe_Stabilizer_3": 4000.0
    }
    
    e_total = sum(capacities.values())
    
    # 3. Structural Routing Distance Tracks (Meters from node to localized load)
    lengths = {
        "Wrist_Rotary_Branch": 0.45,
        "Elbow_Flexor_Branch": 0.85,
        "Main_Wing_Actuator_1": 2.65,
        "Main_Wing_Actuator_2": 2.65,
        "Knee_Piston_Branch": 1.45,
        "Ankle_Actuator_Branch": 0.95,
        "Shoulder_Cowl_Branch": 1.85,
        "Deflector_Shield_Shunt": 3.40,
        # Physical Run Distances through hand/foot bones
        "Finger_Digit_1": 0.22,
        "Finger_Digit_2": 0.22,
        "Finger_Digit_3": 0.22,
        "Finger_Digit_4": 0.22,
        "Finger_Digit_5": 0.22,
        "Thumb_Opponens_Actuator": 0.18,
        "Toe_Stabilizer_1": 0.34,
        "Toe_Stabilizer_2": 0.34,
        "Toe_Stabilizer_3": 0.34
    }
    
    gauge_report = {}
    
    for branch, length in lengths.items():
        e_n = capacities[branch]
        
        # Calculate target branch resistance based on expanded capacity ratio
        r_n = r_equivalent_target * (e_total / e_n)
        
        # Extract required cross-sectional area (mm^2)
        area_m2 = (rho_copper * length) / r_n
        area_mm2 = area_m2 * 1e6   
        
        # Match area to standard wire gauge definitions
        awg_output = get_true_awg(area_mm2)
            
        gauge_report[branch] = {
            "length_m": length,
            "capacity_joules": e_n,
            "target_resistance_ohms": round(r_n, 6),
            "required_area_mm2": round(area_mm2, 4),
            "assigned_gauge": awg_output
        }
        
    return e_total, gauge_report

if __name__ == "__main__":
    total_energy, matrix = calculate_geometry_wire_matrix()
    
    print("=== [UNIVAC-IX TERMINAL MICRO-GEOMETRIC COMPLIANCE MATRIX] ===")
    print(f"Total System Energy Storage Capacity: {total_energy:,} Joules")
    print("----------------------------------------------------------------")
    for branch, specs in sorted(matrix.items()):
        print(f"Branch Node   : {branch.ljust(24)}")
        print(f"  Track Path  : {specs['length_m']} meters | Destination Capacity: {specs['capacity_joules']:,} J")
        print(f"  Resistance  : {specs['target_resistance_ohms']} Ohms | Required Copper Area: {specs['required_area_mm2']} mm²")
        print(f"  Final Spec  : \033[1;33m{specs['assigned_gauge']}\033[0m")
        print("----------------------------------------------------------------")
    print("================================================================")
