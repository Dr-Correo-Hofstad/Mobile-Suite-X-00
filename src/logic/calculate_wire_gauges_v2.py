# ============================================================================
# PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - ZERO-RESISTOR WIRING CORE
# SUB-MODULE: GEOMETRIC WIRE-GAUGE CALCULATOR (CALCULATE_WIRE_GAUGES.PY)
# ARCHITECTURE BASELINE: CAPACITY-TO-CONDUCTANCE PASSIVE CURRENT DIVISION
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
        
    # Corrected formula for area-to-AWG conversion (using -19.5 coefficient)
    awg_calc = -19.5 * (math.log(area_mm2 / 0.012668) / math.log(92)) + 36
    awg_rounded = round(awg_calc)
    
    # Map heavy industrial sizes falling below 0 AWG (0, 00, 000, 0000)
    if awg_rounded == 0:
        return "1/0 AWG (0 AWG) Rail"
    elif awg_rounded == -1:
        return "2/0 AWG (00 AWG) Rail"
    elif awg_rounded == -2:
        return "3/0 AWG (000 AWG) Rail"
    elif awg_rounded == -3:
        return "4/0 AWG (0000 AWG) Busbar"
    elif awg_rounded < -3:
        # Convert very heavy rails to standard industrial kcmil/MCM units
        kcmil = round(area_mm2 * 1.97352)
        return f"{kcmil} kcmil (MCM) Heavy Busbar"
    else:
        return f"{awg_rounded} AWG Solid Core"

def calculate_geometry_wire_matrix():
    """
    Translates structural routing lengths and capacitor maximum energy capacities
    directly into required copper cross-sectional areas and standard AWG sizes.
    """
    # 1. Physical and Material Constants
    rho_copper = 1.68e-8          # Material resistivity of pure copper (Ohm-meter)
    r_equivalent_target = 0.0005  # Target total system network resistance (Ohms)
    
    # 2. Capacitor Energy Matrix (Joules)
    e_knee = 80000.0              # 0.25F @ 800V local knee bank
    e_ankle = 80000.0             # 0.25F @ 800V local ankle bank
    e_shoulder = 120000.0         # Reinforced 0.375F upper shoulder bank
    e_shield_sink = 1200000.0     # Siemens infinite-power deflector ring capacity
    
    e_total = e_knee + e_ankle + e_shoulder + e_shield_sink
    
    # 3. Structural Routing Distance Tracks (Meters from node to load)
    lengths = {
        "Knee_Piston_Branch": 1.45,
        "Ankle_Actuator_Branch": 0.95,
        "Shoulder_Cowl_Branch": 1.85,
        "Deflector_Shield_Shunt": 3.40
    }
    
    capacities = {
        "Knee_Piston_Branch": e_knee,
        "Ankle_Actuator_Branch": e_ankle,
        "Shoulder_Cowl_Branch": e_shoulder,
        "Deflector_Shield_Shunt": e_shield_sink
    }
    
    gauge_report = {}
    
    for branch, length in lengths.items():
        e_n = capacities[branch]
        
        # Calculate target branch resistance based on capacity ratio
        r_n = r_equivalent_target * (e_total / e_n)
        
        # Extract required cross-sectional area (mm^2)
        area_m2 = (rho_copper * length) / r_n
        area_mm2 = area_m2 * 1e6   # Convert square meters to square millimeters
        
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
    
    print("=== [UNIVAC-IX GEOMETRIC WIRING COMPLIANCE MATRIX - REVISED] ===")
    print(f"Total System Energy Storage Capacity: {total_energy:,} Joules")
    print("----------------------------------------------------------------")
    for branch, specs in matrix.items():
        print(f"Branch Node   : {branch.ljust(24)}")
        print(f"  Track Path  : {specs['length_m']} meters | Destination Capacity: {specs['capacity_joules']:,} J")
        print(f"  Resistance  : {specs['target_resistance_ohms']} Ohms | Required Copper Area: {specs['required_area_mm2']} mm²")
        print(f"  Final Spec  : \033[1;33m{specs['assigned_gauge']}\033[0m")
        print("----------------------------------------------------------------")
    print("================================================================")
