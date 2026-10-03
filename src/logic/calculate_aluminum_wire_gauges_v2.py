# ============================================================================
# PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - ZERO-RESISTOR WIRING CORE
# SUB-MODULE: DUAL-RAIL WIRE-GAUGE CALCULATOR (CALCULATE_WIRE_GAUGES.PY)
# ARCHITECTURE BASELINE: DUAL-TRACK ABSORPTION & EXERTION PASSIVE MATRIX
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
    simultaneously for both Absorption (Inbound) and Exertion (Outbound) tracks.
    """
    # 1. Physical & Architectural Constants
    rho_aluminum = 2.82e-8        # Material resistivity of Aluminum 1350 (Ohm-meter)
    r_equivalent_target = 0.0005  # Target total system network resistance (Ohms)
    
    # 2. 54-Node System Capacitor & Actuator Energy Matrix (Joules)
    capacities = {
        # Core & Shunts
        "Deflector_Shield_Shunt": 1200000.0,
        "Cockpit_Avionics_Isolator": 150000.0,
        "Waist_Rotary_Actuator": 350000.0,
        "Shoulder_Cowl_Branch": 120000.0,
        # Arms & Fine Digits
        "Elbow_Flexor_Branch": 40000.0,
        "Wrist_Rotary_Branch": 20000.0,
        "Finger_Digit_1": 1500.0,
        "Thumb_Opponens_Actuator": 3500.0,
        # Legs & Stabilizers
        "Knee_Piston_Branch": 80000.0,
        "Ankle_Actuator_Branch": 80000.0,
        "Toe_Stabilizer_1": 4000.0,
        # Weaponry Sinks
        "Twin_Buster_Rifle_Port": 1500000.0,
        "Beam_Saber_Charger_Port": 40000.0,
        # Wing Binders
        "Port_Main_Wing_Spar": 130000.0,
        "Port_Secondary_Feather_1": 3500.0
    }
    
    e_total = sum(capacities.values())
    
    # 3. Structural Physical Layout Length Matrix (Meters)
    # Dual-rail paths assume symmetric spatial tracking along frame channels
    lengths = {
        "Deflector_Shield_Shunt": 3.40,
        "Cockpit_Avionics_Isolator": 1.45,
        "Waist_Rotary_Actuator": 1.15,
        "Shoulder_Cowl_Branch": 1.85,
        "Elbow_Flexor_Branch": 0.85,
        "Wrist_Rotary_Branch": 0.45,
        "Finger_Digit_1": 0.22,
        "Thumb_Opponens_Actuator": 0.18,
        "Knee_Piston_Branch": 1.45,
        "Ankle_Actuator_Branch": 0.95,
        "Toe_Stabilizer_1": 0.34,
        "Twin_Buster_Rifle_Port": 3.85,
        "Beam_Saber_Charger_Port": 2.15,
        "Port_Main_Wing_Spar": 2.65,
        "Port_Secondary_Feather_1": 0.85
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
        # Exertion tracks use an aggressive 0.75x low-impedance modifier to pull maximum
        # current instantly during active locomotion/firing states (STATE_TAKEOFF)
        r_exertion = r_absorption * 0.75
        area_ex_m2 = (rho_aluminum * length) / r_exertion
        area_ex_mm2 = area_ex_m2 * 1e6
        gauge_ex = get_true_awg(area_ex_mm2)
        
        dual_matrix_report[node] = {
            "length": length,
            "capacity": e_n,
            "abs_res": round(r_absorption, 6),
            "abs_gauge": gauge_abs,
            "ex_res": round(r_exertion, 6),
            "ex_gauge": gauge_ex
        }
        
    return e_total, dual_matrix_report

if __name__ == "__main__":
    total_energy, matrix = calculate_dual_rail_matrix()
    print("=== [UNIVAC-IX REVISED DUAL-RAIL ALUMINUM COMPLIANCE MATRIX] ===")
    print(f"Global Cross-Axis System Energy Pool: {total_energy:,} Joules")
    print("-" * 88)
    print(f"{'Node Location':<26} | {'Length':<6} | {'Absorption (Inbound)':<22} | {'Exertion (Outbound)':<22}")
    print("-" * 88)
    
    # Display representative set of nodes matching your exact locomotion & blast sequence
    sample_display = [
        "Toe_Stabilizer_1", "Ankle_Actuator_Branch", "Knee_Piston_Branch", 
        "Waist_Rotary_Actuator", "Finger_Digit_1", "Twin_Buster_Rifle_Port", 
        "Deflector_Shield_Shunt"
    ]
    
    for node in sample_display:
        metrics = matrix[node]
        print(f"{node:<26} | {metrics['length']:<4}m | {metrics['abs_gauge']:<22} | \033[1;33m{metrics['ex_gauge']:<22}\033[0m")
    print("=" * 88)
