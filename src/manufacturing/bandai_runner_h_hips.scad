// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - LOWER CHASSIS LOCOMOTION VAULT
// COMPONENT VAULT: BANDAI CAST RUNNER H - HIP SWIVELS H1, H2 & H12
// CIRCUIT RULES: FULL SQUARE-WAVE RETROFITTING & INDUCTIVE POWER PLUGS
// METRIC SPECS: DUAL-AXIS CROSS LINKAGE SCALED FOR 16.7M BI-PEDAL AIRFRAME
// ============================================================================

$fn = 100; // Circular segment fidelity calculation count

// Sizing Constants Scaled 1:1 for a 16.7-Meter Airframe Scale (mm)
hip_swivel_height = 820;                // Total longitudinal axis height (mm)
joint_bore_diameter = 480;              // Internal rotational bearing path (mm)
structural_casing_wall = 55;            // Thick TiAl frame reinforcement (mm)
harness_conduit_width = 80;             // Embedded 4oz copper logic trace track (mm)
linkage_cross_length = 740;              // H12 universal joint cross-span (mm)

module Runner_H_Hip_Forge() {
    // Central Supply Injection Runner Axis (Molten Feed Line from Siphon Forge)
    color([0.22, 0.22, 0.25]) {
        cylinder(h = hip_swivel_height * 2.5, d = 42, center = true);
        // Direct feed gates tracking straight into the part mold cavities
        translate([0, 0, 800]) rotate([0, 90, 0]) cylinder(h = 500, d = 22);
        translate([0, 0, -800]) rotate([0, 90, 0]) cylinder(h = 500, d = 22);
    }
    
    // Instantiate Scaled Skeutomorphic Part Molds Symmetrically
    Cast_Internal_Hip_Mechanisms();
}

module Cast_Internal_Hip_Mechanisms() {
    // ---- PART H1: INTERNAL LEFT HIP SWIVEL BASE HOUSING ---- [Page 7, Step 6]
    translate([-450, 0, 700]) color([0.45, 0.45, 0.48]) {
        difference() {
            // Main heavy-duty collar block mounting to the pelvic ring
            cube([360, 480, hip_swivel_height * 0.5], center = true);
            
            // Concentric Internal Boring for the Swivel Bearing Track
            cylinder(h = 500, d = joint_bore_diameter, center = true);
            
            // Continuous cast-in routing track for the 4oz solid-state wiring rails
            cube([harness_conduit_width, 500, hip_swivel_height], center = true);
        }
    }
    
    // ---- PART H2: INTERNAL RIGHT HIP SWIVEL BASE HOUSING ---- [Page 7, Step 6]
    translate([450, 0, 700]) rotate([0, 0, 180]) color([0.45, 0.45, 0.48]) {
        difference() {
            cube([360, 480, hip_swivel_height * 0.5], center = true);
            cylinder(h = 500, d = joint_bore_diameter, center = true);
            cube([harness_conduit_width, 500, hip_swivel_height], center = true);
        }
    }

    // ---- PART H12: DUAL-AXIS UNIVERSAL CROSS-DRIVE LINKAGE ---- [Page 17, Step 09]
    // Functions as a constant-velocity universal spline coordinating multi-angle strides
    translate([0, 0, -600]) color([0.3, 0.3, 0.32]) {
        difference() {
            // Central cross block element
            union() {
                cube([linkage_cross_length, 180, 180], center = true);
                rotate([0, 90, 0])
                    cube([linkage_cross_length, 180, 180], center = true);
            }
            
            // Integrated inner path clearing the air-gapped inductive power cores
            cylinder(h = 300, d = 90, center = true);
            rotate([90, 0, 0])
                cylinder(h = 300, d = 90, center = true);
        }
    }
}

// Instantiate Global Tray Assembly for Workspace Geometry Compiling
Runner_H_Hip_Forge();
