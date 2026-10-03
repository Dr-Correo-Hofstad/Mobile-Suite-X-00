# ============================================================================
# PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - ZERO-RESISTOR WIRING CORE
# SUB-MODULE: GEOMETRIC WIRE-GAUGE CALCULATOR (CALCULATE_WIRE_GAUGES.PY)
# ARCHITECTURE BASELINE: RING TOPOLOGY PASSIVE LOAD DISTRIBUTION
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
        return f"{awg_rounded} AWG Solid Core"

def calculate_geometry_wire_matrix():
    """
    Translates structural routing lengths and expanded capacitor maximum energy 
    capacities directly into required copper cross-sectional areas and standard AWG sizes.
    """
    # 1. Physical and Material Constants
    rho_copper = 1.68e-8          # Material resistivity of pure copper (Ohm-meter)
    r_equivalent_target = 0.0005  # Target total system network resistance (Ohms)
    
    # 2. Expanded Capacitor Energy Matrix (Joules)
    # Total System Capacity Scales to 1.80 MJ
    capacities = {
        "Knee_Piston_Branch": 80000.0,       # 0.25F @ 800V
        "Ankle_Actuator_Branch": 80000.0,    # 0.25F @ 800V
        "Shoulder_Cowl_Branch": 120000.0,    # 0.375F @ 800V
        "Wrist_Rotary_Branch": 20000.0,      # 0.0625F @ 800V
        "Elbow_Flexor_Branch": 40000.0,      # 0.125F @ 800V
        "Main_Wing_Actuator_1": 130000.0,    # 0.40625F @ 800V
        "Main_Wing_Actuator_2": 130000.0,    # 0.40625F @ 800V
        "Deflector_Shield_Shunt": 1200000.0  # Siemens Infinite Power Sink
    }
    
    e_total = sum(capacities.values())
    
    # 3. Structural Routing Distance Tracks (Meters from node to load)
    lengths = {
        "Knee_Piston_Branch": 1.45,
        "Ankle_Actuator_Branch": 0.95,
        "Shoulder_Cowl_Branch": 1.85,
        "Wrist_Rotary_Branch": 0.45,
        "Elbow_Flexor_Branch": 0.85,
        "Main_Wing_Actuator_1": 2.65,
        "Main_Wing_Actuator_2": 2.65,
        "Deflector_Shield_Shunt": 3.40
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
    
    print("=== [UNIVAC-IX EXPANDED GEOMETRIC WIRING COMPLIANCE MATRIX] ===")
    print(f"Total System Energy Storage Capacity: {total_energy:,} Joules")
    print("----------------------------------------------------------------")
    for branch, specs in matrix.items():
        print(f"Branch Node   : {branch.ljust(24)}")
        print(f"  Track Path  : {specs['length_m']} meters | Destination Capacity: {specs['capacity_joules']:,} J")
        print(f"  Resistance  : {specs['target_resistance_ohms']} Ohms | Required Copper Area: {specs['required_area_mm2']} mm²")
        print(f"  Final Spec  : \033[1;33m{specs['assigned_gauge']}\033[0m")
        print("----------------------------------------------------------------")
    print("================================================================")
