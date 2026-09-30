# ============================================================================
# PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - RETRACTABLE DEFENSE MATRIX
# SUB-MODULE: AUTOMATED DOOR ACTUATION TIMING VERIFICATION (CANNON_DOOR_SLIDE.PY)
# DESIGN RULES: SOLID-STATE FULL SQUARE-WAVE BUS VOLTAGE CONFIGURATION
# COMPATIBILITY: 1/144 HG FIGHTING ACTION STEP 02-5 / 16.7M UPPER COLLAR AIRFRAME
# ============================================================================

import sys
import json

def verify_actuator_timing(mass_kg=145.0, travel_m=0.65, force_n=15000.0, step_s=0.001):
    """
    Simulates the deterministic stepping cycle of the linear micro-actuators
    under full telemetric square-wave voltage rise intervals (0.0V -> 1.0V).
    """
    time_s = 0.0
    velocity_m_s = 0.0
    position_m = 0.0
    
    # Boundary tracking array to log physical framework stress vectors
    telemetry_log = []
    
    # Execute numerical integration across 1ms clock heartbeat slices
    while position_m < travel_m and time_s < 0.500:
        # F = m * a -> Acceleration derived straight from the telemetric bus current
        acceleration = force_n / mass_kg
        velocity_m_s += acceleration * step_s
        position_m += velocity_m_s * step_s
        time_s += step_s
        
        # Log critical steps at 20ms intervals for the UNIVAC-IX compiler queue
        if int(time_s * 1000) % 20 == 0:
            telemetry_log.append({
                "time_ms": round(time_s * 1000, 2),
                "position_mm": round(position_m * 1000, 2),
                "velocity_m_s": round(velocity_m_s, 2)
            })
            
    # Verify the final interlock criteria to ensure structural safety bounds
    interlock_secured = position_m >= travel_m
    
    return {
        "success": interlock_secured,
        "total_time_ms": round(time_s * 1000, 2),
        "terminal_velocity_m_s": round(velocity_m_s, 2),
        "final_position_mm": round(position_m * 1000, 2),
        "stepped_telemetry": telemetry_log
    }

if __name__ == "__main__":
    # Execute master cycle simulation
    results = verify_actuator_timing()
    
    print("=== [UNIVAC HARDWARE INTERLOCK VERIFICATION] ===")
    print(f"Status Matrix Locked: {results['success']}")
    print(f"Total Actuation Time: {results['total_time_ms']} ms")
    print(f"Terminal Output Speed: {results['terminal_velocity_m_s']} m/s")
    print(f"Final Clearance Path: {results['final_position_mm']} mm")
    print("================================================")
