// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - TORSO INNER BACKBONE INFRA
// COMPONENT VAULT: BANDAI CAST RUNNER G - FRONT SHOULDERS G5 & G6
// PACKAGING RE-ARCHITECTURE: SUB-ARMOR CAPACITOR RECESSED BANK INTEGRATION
// DESIGN STYLE: NVIDIA FOUNDERS EDITION AGGRESSIVE PLANAR GEOMETRY MATRIX
// CONFIG METRIC: SCALED TITANIUM CASTS WITH CLAVICLE SLIDERS (1:1 ACTUAL METRIC)
// ============================================================================

$fn = 100; // High-precision circular resolution segment count

// Structural Constants Scaled 1:1 for a 16.7-Meter Airframe Scale (mm)
frame_total_length = 1180;               // Total longitudinal vertical height (mm)
clavicle_track_width = 140;              // Core internal sliding track width (mm)
armor_skin_thickness = 65;              // Solid TiAl protective plating wall (mm)
harness_conduit_width = 80;             // Cast-in 4oz copper logic trace track (mm)
capacitor_pocket_depth = 15;            // Sub-armor recessed housing pocket depth (mm)
capacitor_pocket_width = 140;           // Transverse MLCC array pocket width (mm)

module Runner_G_Front_Shoulder_Forge() {
    // Central Supply Injection Runner Axis (Molten Feed Line from Siphon Forge)
    color([0.22, 0.22, 0.25]) {
        cylinder(h = frame_total_length * 1.5, d = 42, center = true);
        // Direct injection gates tracking straight into the part mold cavities
        translate() rotate() cylinder(h = 450, d = 22);
        translate([0, -300, -400]) rotate() cylinder(h = 450, d = 22);
    }
    
    // Instantiate Scaled Skeutomorphic Part Molds Symmetrically (Left & Right)
    Cast_Internal_Front_Shoulders();
}

module Cast_Internal_Front_Shoulders() {
    // ---- PART G5: INTERNAL LEFT UPPER TORSO FRONT SHOULDER FRAME ----
    translate([-450, 0, 450]) color([0.35, 0.35, 0.38]) { // Inner Frame Dark Spec
        difference() {
            // Main solid heavy-duty thoracic framework structure block segment
            cube([620, 340, frame_total_length * 0.45], center = true);
            
            // LINEAR CLAVICLE GUIDE TRACK [Milled out for sliding clavicle bars]
            cube([clavicle_track_width, 360, frame_total_length * 0.35], center = true);
            
            // SUB-ARMOR RECESSED CAPACITOR POCKETS [Segmented rows cut inside the frame walls]
            for (z_offset = [-200, 0, 200]) {
                translate([(620/2 - armor_skin_thickness + capacitor_pocket_depth/2), 0, z_offset])
                    cube([capacitor_pocket_depth, capacitor_pocket_width, 100], center = true);
            }
            
            // Continuous cast-in routing track for the 4oz solid-state wiring rails
            cube([harness_conduit_width, 360, frame_total_length], center = true);
            
            // Slicing profile tool to generate an asymmetrical half-shell part component
            translate([310, 0, 0])
                cube([620, 400, frame_total_length * 2], center = true);
        }
    }
    
    // ---- PART G6: INTERNAL RIGHT UPPER TORSO FRONT SHOULDER FRAME ----
    translate([450, 0, -450]) rotate() color([0.35, 0.35, 0.38]) {
        difference() {
            cube([620, 340, frame_total_length * 0.45], center = true);
            cube([clavicle_track_width, 360, frame_total_length * 0.35], center = true);
            
            for (z_offset = [-200, 0, 200]) {
                translate([(620/2 - armor_skin_thickness + capacitor_pocket_depth/2), 0, z_offset])
                    cube([capacitor_pocket_depth, capacitor_pocket_width, 100], center = true);
            }
            
            cube([harness_conduit_width, 360, frame_total_length], center = true);
            translate([310, 0, 0])
                cube([620, 400, frame_total_length * 2], center = true);
        }
    }
}

// Render Master Assembly to Parameter Workspace
Runner_G_Front_Shoulder_Forge();
