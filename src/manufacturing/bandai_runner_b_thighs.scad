// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - LOWER CHASSIS BONE MATRIX
// COMPONENT VAULT: BANDAI CAST RUNNER B - UPPER THIGH FRAMES B24 & B25
// INTEGRATION BOUND: HYDRAULIC-FREE DUAL-MOTION CYCLOIDAL HIP SOCKETS
// ELECTRICAL PARITY: SOLID-STATE CAST-IN POWER RAILS FOR SQUARE-WAVE BUS
// ============================================================================

$fn = 100; // Circular segment resolution count

// Structural Constants Scaled 1:1 for a 16.7-Meter Airframe Scale (mm)
thigh_bone_length = 2850;               // Total longitudinal thigh axis height (mm)
hip_socket_bore = 540;                  // Cycloidal gear housing track outer diameter (mm)
skeletal_core_wall = 65;                // Thick TiAl interior structural bone thickness (mm)
harness_conduit_width = 80;             // Cast-in 4oz copper logic trace track width (mm)

module Runner_B_Thigh_Forge() {
    // Central Supply Injection Runner Axis (Molten Feed Line from Siphon Forge)
    color([0.22, 0.22, 0.24]) {
        cylinder(h = thigh_bone_length * 1.5, d = 42, center = true);
        // Direct feed gates tracking straight into the part cavity blocks
        translate() rotate([0, 90, 0]) cylinder(h = 500, d = 22);
        translate([0, 0, -800]) rotate([0, 90, 0]) cylinder(h = 500, d = 22);
    }
    
    // Instantiate Scaled Skeutomorphic Part Molds Symmetrically
    Cast_Internal_Thigh_Bones();
}

module Cast_Internal_Thigh_Bones() {
    // ---- PART B24: INTERNAL LEFT THIGH SKELETAL FRAME ---- [Page 6, Step 2]
    translate([-450, 0, 600]) color([0.4, 0.4, 0.42]) {
        difference() {
            // Main solid internal bone backbone column
            cube([340, 340, thigh_bone_length * 0.45], center = true);
            
            // Integrated Cycloidal Hip Interface Socket Bore
            translate([0, 0, (thigh_bone_length * 0.2)])
                rotate([0, 90, 0])
                    cylinder(h = 360, d = hip_socket_bore, center = true);
            
            // Continuous cast-in routing track for the 4oz solid-state wiring rails
            cube([harness_conduit_width, 360, thigh_bone_length], center = true);
        }
    }
    
    // ---- PART B25: INTERNAL RIGHT THIGH SKELETAL FRAME ---- [Page 6, Step 1]
    translate([450, 0, -600]) rotate([0, 0, 180]) color([0.4, 0.4, 0.42]) {
        difference() {
            cube([340, 340, thigh_bone_length * 0.45], center = true);
            translate([0, 0, (thigh_bone_length * 0.2)])
                rotate([0, 90, 0])
                    cylinder(h = 360, d = hip_socket_bore, center = true);
            cube([harness_conduit_width, 360, thigh_bone_length], center = true);
        }
    }
}

// Instantiate Global Tray Assembly for Workspace Geometry Compiling
Runner_B_Thigh_Forge();
