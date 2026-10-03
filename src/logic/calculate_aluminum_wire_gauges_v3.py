# ============================================================================
# PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - ZERO-RESISTOR WIRING CORE
# SUB-MODULE: DUAL-RAIL WIRE-GAUGE CALCULATOR (CALCULATE_WIRE_GAUGES.PY)
# ARCHITECTURE BASELINE: OPENSCAD LAYERED MATRIX CODES (PARTS F5-H15)
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
            return f"{kcmil} kcmil (MCM) Busbar"
    else:
        return f"{awg_rounded} AWG Track"

def calculate_dual_rail_matrix():
    """
    Calculates required Aluminum cross-sectional areas and AWG specifications 
    simultaneously mapped directly to structural OpenSCAD part identifier keys.
    """
    # Physical & Architectural Constants
    rho_aluminum = 2.82e-8        # Material resistivity of Aluminum 1350 (Ohm-meter)
    r_equivalent_target = 0.0005  # Target total system network resistance (Ohms)
    
    # 54-Node System Capacitor & Actuator Energy Matrix (Joules)
    capacities = {
        "Parts_F5_F6_Knee": 80000.0,
        "Parts_F18_F19_Shoulder": 120000.0,
        "Parts_F50_F60_Digits": 1500.0,
        "Parts_H14_H15_Ankle": 80000.0,
        "Deflector_Shield_Shunt": 1200000.0,
        "Twin_Buster_Rifle_Port": 1500000.0
    }
    
    e_total = sum(capacities.values())
    
    # Structural Physical Layout Length Matrix Mapped to OpenSCAD Track Geometry
    lengths = {
        "Parts_F5_F6_Knee": 1.45,
        "Parts_F18_F19_Shoulder": 1.85,
        "Parts_F50_F60_Digits": 0.22,
        "Parts_H14_H15_Ankle": 0.95,
        "Deflector_Shield_Shunt": 3.40,
        "Twin_Buster_Rifle_Port": 3.85
    }
    
    dual_matrix_report = {}
    
    for node, length in lengths.items():
        e_n = capacities[node]
        
        # --- ABSORPTION MATH: Inbound current split based on capacity ratio ---
        r_absorption = r_equivalent_target * (e_total / e_n)
        area_abs_m2 = (rho_aluminum * length) / r_absorption
        area_abs_mm2 = area_abs_m2 * 1e6
        gauge_abs = get_true_awg(area_abs_mm2)
        
        # --- EXERTION MATH: Outbound propulsion discharge track scaling ---
        # Exertion tracks use low-impedance modifier to pull maximum current
        r_exertion = r_absorption * 0.75
        area_ex_m2 = (rho_aluminum * length) / r_exertion
        area_ex_mm2 = area_ex_m2 * 1e6
        gauge_ex = get_true_awg(area_ex_mm2)
        
        dual_matrix_report[node] = {
            "length": length,
            "capacity": e_n,
            "abs_gauge": gauge_abs,
            "ex_gauge": gauge_ex
        }
        
    return e_total, dual_matrix_report

if __name__ == "__main__":
    total_energy, matrix = calculate_geometry_wire_matrix() if 'calculate_geometry_wire_matrix' in globals() else calculate_dual_rail_matrix()
    print("=== [UNIVAC-IX OPENSCAD GEOMETRIC COUPLING HARDWARE MATRIX] ===")
    print(f"Global Cross-Axis System Energy Pool: {total_energy:,} Joules")
    print("-" * 92)
    print(f"{'OpenSCAD Part Code':<24} | {'Track Length':<12} | {'Absorption Spec':<20} | {'Exertion Spec':<20}")
    print("-" * 92)
    for part, specs in sorted(matrix.items()):
        print(f"{part:<24} | {specs['length']:<5} meters | {specs['abs_gauge']:<20} | \033[1;36m{specs['ex_gauge']:<20}\033[0m")
    print("======================================================================")
