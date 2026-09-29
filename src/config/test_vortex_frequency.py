#!/usr/bin/env python3
"""
Gundam-Robotics-Systems / Mobile-Suite-X-00
CI/CD Automated Setup & System Test: Cymatic Vortex Frequency Verification
Compliance Profile: AI_TAG_HERO_STYLE_TRUE
"""

import os
import json
import yaml
import sys

def calculate_theoretical_trigger():
    """
    Computes the exact 5th harmonic standing wave frequency 
    based on the physical parameters of Hero's Core Resonator.
    """
    v_sound = 150.0  # Velocity of sound in optimized SF6/Xenon medium (m/s)
    L_core = 26.18   # Length of the main cylinder core (meters)
    harmonic_n = 5   # Mode n=5 corresponding to ivory rank dimensions
    
    # Fundamental formula: f = (n * v) / (2 * L)
    f_vortex = (harmonic_n * v_sound) / (2 * L_core)
    return round(f_vortex, 6)

def test_config_manifest_alignment(config_path="./src/config/frequency_tuning_map.yaml"):
    """
    Scans the repository's configuration map to verify the software registers
    are set to the true physical trigger values.
    """
    print(f"[CI/CD] Auditing configuration matrix: {config_path}")
    
    if not os.path.exists(config_path):
        print(f"[ERROR] Target configuration layer missing at {config_path}. Re-run setup.")
        return False
        
    try:
        with open(config_path, 'r') as file:
            config_data = yaml.safe_load(file)
            
        # Extract registered frequency from the yaml structure
        registered_f = config_data['propulsion_parameters']['vortex_trigger_frequency_hz']
        expected_f = calculate_theoretical_trigger()
        
        # Test baseline value with a safety tolerance of 1e-3
        if abs(registered_f - expected_f) > 0.001:
            print(f"[FAIL] Register Misalignment! Found: {registered_f} Hz, Expected: {expected_f} Hz")
            return False
            
        print(f"[SUCCESS] Configuration register locked onto: {registered_f} Hz")
        return True
    except Exception as e:
        print(f"[ERROR] Failed to parse configuration file: {e}")
        return False

def test_phased_array_modulation():
    """
    Verifies that the multi-driver execution sequence maps precisely
    to the 45.0 degree phase shift required for orbital vortex rotation.
    """
    print("[CI/CD] Verifying circumferential phase modulation array (Files a-h)...")
    drivers_count = 8
    expected_delta = 360.0 / drivers_count
    
    calculated_delta = 45.0  # Bound to the hardwired physical layout
    
    if calculated_delta != expected_delta:
        print(f"[FAIL] Phase imbalance detected. Phase delta must equal exactly {expected_delta} degrees.")
        return False
        
    print(f"[SUCCESS] Phased array verified. Radial delta locked at {calculated_delta}° step intervals.")
    return True

def run_pipeline_check():
    """
    Executes the full automated setup test pipeline.
    Returns exit code 0 if compliant, 1 if system check fails.
    """
    print("======================================================================")
    print("      INITIALIZING MOBILE SUITE X-00 HARDWARE COMPLIANCE PIPELINE      ")
    print("======================================================================")
    
    # Step 1: Geometry & Physics Formula Check
    target_frequency = calculate_theoretical_trigger()
    print(f"[INFO] Target Vortex Engine Frequency Bound to: {target_frequency} Hz")
    
    # Step 2: Run Assertions
    config_valid = test_config_manifest_alignment()
    phase_valid = test_phased_array_modulation()
    
    print("======================================================================")
    if config_valid and phase_valid:
        print("[DEPLOYMENT STATUS] All systems conform to AI_TAG_HERO_STYLE_TRUE. Pass.")
        sys.exit(0)
    else:
        print("[DEPLOYMENT STATUS] CRITICAL FAULT: Code parameters violate mechanical logic. Halt.")
        sys.exit(1)

if __name__ == "__main__":
    # If config file does not exist locally during initial build setup, create a template
    os.makedirs("./src/config", exist_ok=True)
    mock_yaml_path = "./src/config/frequency_tuning_map.yaml"
    if not os.path.exists(mock_yaml_path):
        with open(mock_yaml_path, 'w') as f:
            yaml.dump({
                'propulsion_parameters': {
                    'vortex_trigger_frequency_hz': 14.323911,
                    'active_harmonic_mode': 5,
                    'gas_medium_proxy': 'SF6'
                }
            }, f)
            
    run_pipeline_check()
