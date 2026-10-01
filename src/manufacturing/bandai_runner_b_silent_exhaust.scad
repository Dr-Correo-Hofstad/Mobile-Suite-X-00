// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - SILENT REBALANCING MATRIX
// COMPONENT VAULT: BANDAI CAST RUNNER B - RESONANT TUNED NOZZLE B21 & B22
// ENGINE PAIRING: UP-SCALED GM AXIAL-FLUX MOTOR CORE (9,000 RPM / 150 Hz)
// SOUND TUNING MECHANISM: QUARTER-WAVE ANTIMATTER WAVE HELMHOLTZ ISOLATION
// ============================================================================

$fn = 120; // High-precision rendering circular segment count

// Acoustic Optimization Constants (Derived from 150 Hz / 330 m/s Speed of Sound)
exhaust_resonant_length = 980;          // Matched quarter-wave tuned length (mm)
nozzle_throat_diameter = 740;           // Core acoustic absorption bore width (mm)
armor_casing_wall = 60;                 // Solid TiAl containment structural wall (mm)
pzt_matrix_depth = 15;                  // Sound-to-electric harvesting crystal zone (mm)
harness_conduit_width = 80;             // Embedded 4oz copper logic trace track (mm)

module Runner_B_Silent_Exhaust_Forge() {
    // Central Supply Injection Runner Axis (Molten Feed Line from Siphon Forge)
    color([0.22, 0.22, 0.24]) {
        cylinder(h = exhaust_resonant_length * 2.2, d = 42, center = true);
        // Direct injection gates tracking straight into the part mold cavities
        translate([0, 0, 450]) rotate([0, 90, 0]) cylinder(h = 450, d = 22);
        translate([0, 0, -450]) rotate([0, 90, 0]) cylinder(h = 450, d = 22);
    }
    
    // Instantiate Scaled Structural Molds Symmetrically
    Cast_Resonant_Tuned_Exhaust();
}

module Cast_Resonant_Tuned_Exhaust() {
    // ---- PART B21: 150Hz RESONANT TUNED CONTAINMENT BARREL ---- [Page 18, Step 10-1]
    translate([-400, 0, 450]) color([0.7, 0.7, 0.75]) { // Standard Armor Grey Spec
        difference() {
            // Main solid heavy-duty high-pressure containment block
            cylinder(h = exhaust_resonant_length, d = nozzle_throat_diameter + (armor_casing_wall * 2), center = true);
            
            // Tuned Acoustic Absorption Bore (Traps 150 Hz Engine Oscillations)
            cylinder(h = exhaust_resonant_length + 20, d = nozzle_throat_diameter, center = true);
            
            // Sub-surface recess slots for the sound-harvesting PZT crystal liners
            cylinder(h = exhaust_resonant_length + 10, d = nozzle_throat_diameter + (pzt_matrix_depth * 2), center = true);
            
            // Continuous cast-in routing track for the 4oz solid-state wiring rails
            cube([harness_conduit_width, nozzle_throat_diameter + 150, exhaust_resonant_length + 20], center = true);
        }
    }
    
    // ---- PART B22: VARIABLE DEFLECTION COALESCENCE EXHAUST FLAP ---- [Page 18, Step 10-3]
    translate([400, 0, -450]) color([0.3, 0.3, 0.32]) { // Inner Frame Dark Spec
        difference() {
            // Flat tapered deflection vector shield plate segment
            cube([260, 450, 520], center = true);
            
            // Internal mounting slot for the air-gapped magnetic track pins
            translate([0, 0, (520/2 - 60)])
                rotate([0, 90, 0]) cylinder(h = 300, d = 45, center = true);
                
            cube([harness_conduit_width, 500, 520 + 10], center = true);
        }
    }
}

// Render Master Assembly to Parameter Workspace
Runner_B_Silent_Exhaust_Forge();
