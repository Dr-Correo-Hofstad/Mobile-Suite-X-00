// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - AIRFRAME STRUCTURAL CORE
// COMPONENTS: RUNNER G (SHOULDER COUPLERS) & RUNNER B (WING REDUCERS)
// MATERIAL BASELINE: TRANS-ALUMINUM OXYNITRIDE & SOLID TITANIUM ALLOYS
// DESIGN TARGET: 100% SQUARE-WAVE SNAP-CIRCUIT BUS REACTIONARY PROTECTION
// ============================================================================

$fn = 100; // Circular segment resolution

// Metric Scaling Parameters (1:1 Dimensions for 16.7m Mecha Scale)
shoulder_beam_width = 3800;             // Total internal frame span (mm)
wing_arm_length = 1650;                 // Longitudinal joint axis extension (mm)
clear_aluminum_diameter = 900;          // Central clear green window width (mm)
cycloidal_housing_bore = 520;           // B8 Gear box enclosure envelope (mm)
frame_core_thickness = 85;              // Main load-bearing bone wall (mm)

module Master_Torso_Junction() {
    // 1. Central Transparent Aluminum Window Matrix (The Zero Sensor Node)
    color([0.1, 0.8, 0.3, 0.4]) { // See-Through Green Ceramic Material
        rotate([90, 0, 0])
            cylinder(h = frame_core_thickness + 20, d = clear_aluminum_diameter, center = true);
    }
    
    // 2. Instantiate Connected Mechanical Runner Parts
    Build_Runner_G_Shoulders();
    Build_Runner_B_Wing_Joints();
}

module Build_Runner_G_Shoulders() {
    // ---- PARTS G1 & G2: INTERNAL SHOULDER CROSS-AXIS BRACES ---- [Page 4, Step 05-1]
    color([0.35, 0.35, 0.38]) {
        // Left Internal Brace Core (G1)
        translate([-(clear_aluminum_diameter/2 + 200), 0, 0])
            difference() {
                cube([600, 450, 700], center = true);
                // Cast-in conduit path for the 4oz solid-state wiring tracks
                cube([80, 500, 250], center = true);
            }
            
        // Right Internal Brace Core (G2)
        translate([(clear_aluminum_diameter/2 + 200), 0, 0])
            difference() {
                cube([600, 450, 700], center = true);
                cube([80, 500, 250], center = true);
            }
    }
    
    // ---- PART G10: MULTI-AXIS ALIGNMENT EXTENSION LINK ---- [Page 4, Step 05-1]
    color([0.4, 0.4, 0.42]) {
        translate([0, 0, 450])
            cube([shoulder_beam_width * 0.4, 300, 150], center = true);
    }
}

module Build_Runner_B_Wing_Joints() {
    // ---- PARTS B1 & B2: WING JOINT ARTICULATION MECHANISMS ---- [Page 5, Step 06-1]
    color([0.7, 0.7, 0.72]) {
        // Left Wing Extension Arm Rod (B1)
        translate([-(shoulder_beam_width/2 - 200), 150, 200])
            rotate([0, 45, 0])
                cube([120, 120, wing_arm_length], center = true);
                
        // Right Wing Extension Arm Rod (B2)
        translate([(shoulder_beam_width/2 - 200), 150, 200])
            rotate([0, -45, 0])
                cube([120, 120, wing_arm_length], center = true);
    }
    
    // ---- PART B8: REINFORCED CYCLOIDAL REDUCER ENCLOSURE ---- [Page 5, Step 06-2]
    // Houses the high-torque crown rollers to eliminate gear tooth backlash
    translate([-(shoulder_beam_width/2), 150, 600])
        rotate([90, 0, 0])
            color([0.5, 0.5, 0.55]) {
                difference() {
                    cylinder(h = 380, d = cycloidal_housing_bore + 120, center = true);
                    cylinder(h = 400, d = cycloidal_housing_bore, center = true);
                }
            }
            
    translate([shoulder_beam_width/2, 150, 600])
        rotate([90, 0, 0])
            color([0.5, 0.5, 0.55]) {
                difference() {
                    cylinder(h = 380, d = cycloidal_housing_bore + 120, center = true);
                    cylinder(h = 400, d = cycloidal_housing_bore, center = true);
                }
            }
}

// Instantiate Unified Framework Assembly for Workspace Verification
Master_Torso_Junction();
