// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - LOWER ARM SKELETAL ARCHITECTURE
// COMPONENT VAULT: BANDAI CAST RUNNER B - FOREARM BACKBONES B3 & B4
// MANUFACTURING SPEC: SOLID-STATE CAST-IN POWER RAILS FOR SQUARE-WAVE BUS
// MASS CHECK: PRE-ARMOR WEIGHT PROFILE BALANCING MANDATE FOR 16.7M MECHA
// ============================================================================

$fn = 100; // Circular segment resolution calculation count

// Sizing Constants Scaled 1:1 for a 16.7-Meter Airframe Scale (mm)
forearm_bone_length = 1850;             // Total vertical lower arm height (mm)
wrist_track_diameter = 420;             // Wrist rotation cycloidal reducer track width (mm)
skeletal_core_wall = 50;                // Thick TiAl internal structural bone thickness (mm)
harness_conduit_width = 80;             // Embedded 4oz copper logic trace track width (mm)

module Runner_B_Forearm_Forge() {
    // Central Supply Injection Runner Axis (Molten Feed Line from Siphon Forge)
    color([0.22, 0.22, 0.24]) {
        cylinder(h = forearm_bone_length * 1.5, d = 42, center = true);
        // Direct injection gates tracking straight into the part mold cavities
        translate() rotate() cylinder(h = 450, d = 22);
        translate([0, 0, -500]) rotate() cylinder(h = 450, d = 22);
    }
    
    // Instantiate Scaled Structural Part Molds Symmetrically
    Cast_Internal_Forearm_Backbones();
}

module Cast_Internal_Forearm_Backbones() {
    // ---- PART B3: INTERNAL LEFT FOREARM SKELETAL STRUT ---- [Page 6, Step 3]
    translate([-450, 0, 450]) color([0.4, 0.4, 0.42]) {
        difference() {
            // Main solid internal forearm skeletal structural column
            cube([260, 260, forearm_bone_length * 0.45], center = true);
            
            // Integrated Cycloidal Wrist Rotation Track Housing Bore
            translate([0, 0, -(forearm_bone_length * 0.18)])
                rotate()
                    cylinder(h = 300, d = wrist_track_diameter, center = true);
            
            // Continuous cast-in routing track for the 4oz solid-state wiring rails
            cube([harness_conduit_width, 300, forearm_bone_length], center = true);
        }
    }
    
    // ---- PART B4: INTERNAL RIGHT FOREARM SKELETAL STRUT ---- [Page 6, Step 3]
    translate([450, 0, -450]) rotate() color([0.4, 0.4, 0.42]) {
        difference() {
            cube([260, 260, forearm_bone_length * 0.45], center = true);
            translate([0, 0, -(forearm_bone_length * 0.18)])
                rotate()
                    cylinder(h = 300, d = wrist_track_diameter, center = true);
            cube([harness_conduit_width, 300, forearm_bone_length], center = true);
        }
    }
}

// Render Master Assembly to Parameter Workspace
Runner_B_Forearm_Forge();
