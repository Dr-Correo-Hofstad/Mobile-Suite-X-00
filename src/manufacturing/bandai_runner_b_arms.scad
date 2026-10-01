// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - AIRFRAME SKELETAL MATRIX
// COMPONENT VAULT: BANDAI CAST RUNNER B - UPPER ARM BONES B13 & B14
// INTEGRATION CONFIG: HYDRAULIC-FREE DUAL-MOTION CYCLOIDAL ELBOW SOCKETS
// ELECTRICAL SPECS: SOLID-STATE CAST-IN POWER RAILS FOR SQUARE-WAVE BUS
// ============================================================================

$fn = 100; // Circular segment resolution calculation count

// Structural Constants Scaled 1:1 for a 16.7-Meter Airframe Scale (mm)
upper_arm_length = 2150;                // Total longitudinal upper arm axis (mm)
elbow_socket_bore = 480;                // Cycloidal gear housing track outer diameter (mm)
skeletal_core_wall = 55;                // Thick TiAl interior structural bone thickness (mm)
harness_conduit_width = 80;             // Cast-in 4oz copper logic trace track width (mm)

module Runner_B_Arm_Forge() {
    // Central Supply Injection Runner Axis (Molten Feed Line from Siphon Forge)
    color([0.22, 0.22, 0.24]) {
        cylinder(h = upper_arm_length * 1.5, d = 42, center = true);
        // Direct injection gates tracking straight into the part cavity blocks
        translate([0, 0, 500]) rotate([0, 90, 0]) cylinder(h = 450, d = 22);
        translate([0, 0, -500]) rotate([0, 90, 0]) cylinder(h = 450, d = 22);
    }
    
    // Instantiate Scaled Skeutomorphic Part Molds Symmetrically
    Cast_Internal_Arm_Bones();
}

module Cast_Internal_Arm_Bones() {
    // ---- PART B13: INTERNAL LEFT UPPER ARM SKELETAL FRAME ---- [Page 6, Step 4]
    translate([-450, 0, 450]) color([0.4, 0.4, 0.42]) {
        difference() {
            // Main solid internal bone backbone column
            cube([280, 280, upper_arm_length * 0.45], center = true);
            
            // Integrated Cycloidal Elbow Interface Socket Bore
            translate([0, 0, -(upper_arm_length * 0.18)])
                rotate([90, 0, 0])
                    cylinder(h = 300, d = elbow_socket_bore, center = true);
            
            // Continuous cast-in routing track for the 4oz solid-state wiring rails
            cube([harness_conduit_width, 300, upper_arm_length], center = true);
        }
    }
    
    // ---- PART B14: INTERNAL RIGHT UPPER ARM SKELETAL FRAME ---- [Page 6, Step 3]
    translate([450, 0, -450]) rotate([0, 0, 180]) color([0.4, 0.4, 0.42]) {
        difference() {
            cube([280, 280, upper_arm_length * 0.45], center = true);
            translate([0, 0, -(upper_arm_length * 0.18)])
                rotate([90, 0, 0])
                    cylinder(h = 300, d = elbow_socket_bore, center = true);
            cube([harness_conduit_width, 300, upper_arm_length], center = true);
        }
    }
}

// Render Master Assembly to Parameter Workspace
Runner_B_Arm_Forge();
