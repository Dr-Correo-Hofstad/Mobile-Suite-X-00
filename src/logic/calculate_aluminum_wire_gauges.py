# ============================================================================
# PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - ZERO-RESISTOR WIRING CORE
# SUB-MODULE: GEOMETRIC WIRE-GAUGE CALCULATOR (CALCULATE_WIRE_GAUGES.PY)
# ARCHITECTURE BASELINE: ALUMINUM 1350 MATERIAL PARALLEL REDIRECTION
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
        elif awg_rounded == -3: return "4/0 AWG Busbar"
        else:
            kcmil = round(area_mm2 * 1.97352)
            return f"{kcmil} kcmil (MCM) Heavy Busbar"
    else:
        return f"{awg_rounded} AWG Track"

def calculate_geometry_wire_matrix():
    """
    Translates structural routing lengths and capacities into required aluminum
    cross-sectional areas and standard AWG sizes.
    """
    # 1. PHYSICAL CONSTANT UPDATE: Shifted from Copper to Pure Aluminum 1350
    rho_aluminum = 2.82e-8        # Material resistivity of aluminum (Ohm-meter)
    r_equivalent_target = 0.0005  

    capacities = {
        "Deflector_Shield_Shunt": 1200000.0,
        "Twin_Buster_Rifle_Port": 1500000.0,
        "Twin_Buster_Rifle_Stbd": 1500000.0,
        "Waist_Rotary_Actuator": 350000.0,
        "Main_Wing_Actuator_1": 130000.0,
        "Knee_Piston_Branch": 80000.0,
        "Wrist_Rotary_Branch": 20000.0,
        "Finger_Digit_1": 1500.0
    }
    
    e_total = sum(capacities.values())
    
    lengths = {
        "Deflector_Shield_Shunt": 3.40,
        "Twin_Buster_Rifle_Port": 3.85, "Twin_Buster_Rifle_Stbd": 3.85,
        "Waist_Rotary_Actuator": 1.15,
        "Main_Wing_Actuator_1": 2.65,
        "Knee_Piston_Branch": 1.45,
        "Wrist_Rotary_Branch": 0.45,
        "Finger_Digit_1": 0.22
    }
    
    gauge_report = {}
    for branch, length in lengths.items():
        e_n = capacities[branch]
        r_n = r_equivalent_target * (e_total / e_n)
        area_mm2 = ((rho_aluminum * length) / r_n) * 1e6   
        gauge_report[branch] = {
            "length_m": length, "capacity_joules": e_n,
            "target_resistance_ohms": round(r_n, 6),
            "required_area_mm2": round(area_mm2, 4), "assigned_gauge": get_true_awg(area_mm2)
        }
    return e_total, gauge_report

if __name__ == "__main__":
    total_energy, matrix = calculate_geometry_wire_matrix()
    print("=== [UNIVAC-IX REVISED ALUMINUM METRIC WIRING COMPLIANCE MATRIX] ===")
    print(f"Global Cross-Axis System Energy Pool: {total_energy:,} Joules")
    print("---------------------------------------------------------------------")
    for branch, specs in sorted(matrix.items()):
        print(f"Node Location: {branch.ljust(24)} | {specs['length_m']}m | \033[1;36m{specs['assigned_gauge']}\033[0m")
