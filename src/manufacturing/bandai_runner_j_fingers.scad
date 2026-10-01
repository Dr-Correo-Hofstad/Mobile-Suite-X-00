// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - MANIPULATOR CORE DESIGN
// COMPONENT VAULT: BANDAI CAST RUNNER J - FINGER HOUSINGS J1 THROUGH J8
// CONFIGURATION STANDARD: SOLID-STATE INTEGRATED COUPLING LINKAGES
// INTERFACE SPECS: THREE-PHALANX PARALLEL BONES & CYCLOIDAL JOINT RECEPTACLES
// ============================================================================

$fn = 60; // Optimized segment resolution for repetitive micro-arrays

// Sizing Constants Scaled 1:1 for a 16.7-Meter Airframe Scale (mm)
runner_bar_length = 2400;               // Main horizontal feed rail span (mm)
base_runner_diameter = 38;             // Central material distribution shaft (mm)
proximal_bone_length = 240;             // Core J1/J2 bone axis height (mm)
finger_armor_wall = 35;                 // Zoned TiAl protective casing wall (mm)
cycloidal_knuckle_bore = 65;            // Micro-reducer housing diameter (mm)

module Runner_J_Finger_Forge() {
    // 1. Central Distribution Sprue (Feeds molten TiAl from Siphon Forge)
    color([0.22, 0.22, 0.25]) {
        cylinder(h = runner_bar_length, d = base_runner_diameter, center = true);
        
        // Lateral injection gates mapping straight to parts cavities
        for (z_offset = [-900, -300, 300, 900]) {
            translate([0, 0, z_offset]) rotate([0, 90, 0])
                cylinder(h = 450, d = base_runner_diameter * 0.5);
        }
    }
    
    // 2. Instantiate Connected Finger Component Molds Cavities (Parts J1-J8)
    Cast_Segmented_Phalanx_Bones();
}

module Cast_Segmented_Phalanx_Bones() {
    // ---- PARTS J1 & J2: PROXIMAL SKELETAL PHALANX BONES ---- [Page 6, Step 3 & 4]
    for (i = [0 : 1]) {
        translate([450, 0, 900 - (i * 600)]) color([0.4, 0.4, 0.42]) {
            difference() {
                // Main rigid base knuckle bone core segment
                cylinder(h = proximal_bone_length, d = cycloidal_knuckle_bore + 50, center = true);
                // Internal bore path housing the micro-cycloidal roller loops
                cylinder(h = proximal_bone_length + 10, d = cycloidal_knuckle_bore, center = true);
                // Embedded tracking slot for the 4oz copper solid-state harness
                cube([20, 40, proximal_bone_length + 20], center = true);
            }
        }
    }
    
    // ---- PARTS J3 & J4: MIDDLE SKELETAL PHALANX BONES ---- [Page 6, Step 3 & 4]
    for (i = [0 : 1]) {
        translate([450, 0, -300 - (i * 600)]) color([0.4, 0.4, 0.42]) {
            difference() {
                cylinder(h = proximal_bone_length * 0.8, d = cycloidal_knuckle_bore + 40, center = true);
                cylinder(h = proximal_bone_length, d = cycloidal_knuckle_bore * 0.8, center = true);
                cube([15, 35, proximal_bone_length], center = true);
            }
        }
    }

    // ---- PARTS J5 & J6: DISTAL INTERPHALANX TIP CORES ---- [Page 6, Step 3 & 4]
    for (i = [0 : 1]) {
        translate([-450, 0, 900 - (i * 600)]) color([0.45, 0.45, 0.48]) {
            difference() {
                cube([80, 110, proximal_bone_length * 0.65], center = true);
                rotate([0, 90, 0]) cylinder(h = 100, d = 40, center = true);
            }
        }
    }

    // ---- PARTS J7 & J8: EXTERNAL SHIELD ARMOR CASINGS ---- [Page 6, Step 3 & 4]
    // Utilizes sub-surface Diamond-Like Carbon (DLC) liners to shield moving knuckles
    for (i = [0 : 1]) {
        translate([-450, 0, -300 - (i * 600)]) color([0.8, 0.8, 0.85]) {
            difference() {
                // Curved outer protective shield half-shell
                cylinder(h = proximal_bone_length * 0.7, d = cycloidal_knuckle_bore + 90, center = true);
                // Internal pocket milling (Leaves 35mm thick solid defensive wall)
                cylinder(h = proximal_bone_length, d = cycloidal_knuckle_bore + 90 - (finger_armor_wall * 2), center = true);
                // Splitting profile tool to forge a clean half-shell component panel
                translate([0, -200, 0]) cube([300, 400, 500], center = true);
            }
        }
    }
}

// Render Master Component Assembly to Workspace Parametric Window
Runner_J_Finger_Forge();
