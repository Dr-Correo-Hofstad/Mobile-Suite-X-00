// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - FLIGHT SURFACE CORE
// COMPONENT VAULT: BANDAI CAST RUNNER E (PARTS E19 THROUGH E28)
// ENGINEERING STANDARD: INTEGRATED SOLID-STATE ELECTRICAL HARNESSING
// DESIGN PARITY: DISTAL TRAILING-EDGE FEATHERS & TELEMETRIC FOCUSERS
// ============================================================================

$fn = 60; // Curve resolution parameter

// Sizing Constants Scaled 1:1 for a 16.7-Meter Airframe Scale (mm)
runner_axis_length = 3200;              // Total vertical sprue core feed line (mm)
base_runner_diameter = 38;             // Material feed channel diameter (mm)
distal_feather_base = 1100;             // Baseline vertical height for trailing fins (mm)
harness_conduit_gap = 35;               // Solid-state bus internal seat width (mm)

module Runner_E_Distal_Forge() {
    // 1. Central Distribution Sprue Framework (Siphon Forge Supply Rail)
    color([0.28, 0.28, 0.3]) {
        cylinder(h = runner_axis_length, d = base_runner_diameter, center = true);
        
        // Multi-gate lateral injection paths to feed parts E19-E28 symmetrically
        for (z_step = [-1200 : 400 : 1200]) {
            translate([0, 0, z_step]) rotate([0, 90, 0])
                cylinder(h = 500, d = base_runner_diameter * 0.55);
            translate([0, 0, z_step]) rotate([0, -90, 0])
                cylinder(h = 500, d = base_runner_diameter * 0.55);
        }
    }
    
    // 2. Instantiate Connected Component Molds Symmetrically
    Cast_Left_Distal_Feathers();
    Cast_Right_Distal_Feathers();
}

module Cast_Left_Distal_Feathers() {
    // ---- PARTS E19, E21, E23, E25: LEFT DISTAL SEGMENTS ---- [Pages 9 & 11]
    for (i = [0 : 3]) {
        translate([450, 0, -1000 + (i * 650)]) color([0.9, 0.9, 0.92]) {
            // Incremental scaling factor to emulate the tapering feather lengths down the sprue
            assign(scale_factor = 1.0 - (i * 0.08)) {
                difference() {
                    // Curved airfoil vane plate
                    scale([1.0, 0.12, 1.0])
                        cylinder(h = distal_feather_base * scale_factor, r1 = 180, r2 = 50, center = true);
                    
                    // Internal cast-in seat for the 4oz copper telemetric logic bus links
                    translate([0, 0, -((distal_feather_base * scale_factor)/2 - 80)])
                        cube([harness_conduit_gap, harness_conduit_gap, 60], center = true);
                }
            }
        }
    }
}

module Cast_Right_Distal_Feathers() {
    // ---- PARTS E20, E22, E24, E26: RIGHT DISTAL SEGMENTS ---- [Pages 9 & 11]
    for (i = [0 : 3]) {
        translate([-450, 0, -1000 + (i * 650)]) rotate([0, 0, 180]) color([0.9, 0.9, 0.92]) {
            assign(scale_factor = 1.0 - (i * 0.08)) {
                difference() {
                    scale([1.0, 0.12, 1.0])
                        cylinder(h = distal_feather_base * scale_factor, r1 = 180, r2 = 50, center = true);
                    translate([0, 0, -((distal_feather_base * scale_factor)/2 - 80)])
                        cube([harness_conduit_gap, harness_conduit_gap, 60], center = true);
                }
            }
        }
    }
}

// Instantiate Finished Construction Group for Workspace Evaluation
Runner_E_Distal_Forge();
