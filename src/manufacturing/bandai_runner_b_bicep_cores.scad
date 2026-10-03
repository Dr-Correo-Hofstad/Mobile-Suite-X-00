// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - LIMB SKELETON PROTECTION
// COMPONENT VAULT: BANDAI CAST RUNNER B - BICEP CORES B1 & B2
// PACKAGING RE-ARCHITECTURE: SUB-ARMOR CAPACITOR RECESSED BANK INTEGRATION
// CONFIG METRIC: SCALED TITANIUM CASTS WITH LINEAR SLIDEWAYS (1:1 ACTUAL METRIC)
// ============================================================================

$fn = 100; // High-precision circular resolution segment count

// Structural Constants Scaled 1:1 for a 16.7-Meter Airframe Scale (mm)
bicep_total_length = 1120;               // Total vertical height of bicep frame (mm)
bicep_outer_diameter = 360;              // Bounding thickness of bicep core bone (mm)
track_groove_depth = 30;                 // Shoulder multi-link slider slot depth (mm)
track_groove_width = 60;                 // Shoulder multi-link slider slot width (mm)
armor_skin_thickness = 65;              // Solid TiAl protective plating wall (mm)
harness_conduit_width = 80;             // Cast-in 4oz copper logic trace track (mm)
capacitor_pocket_depth = 15;            // Sub-armor recessed housing pocket depth (mm)
capacitor_pocket_width = 140;           // Transverse MLCC array pocket width (mm)

module Runner_B_Bicep_Core_Forge() {
    // Central Supply Injection Runner Axis (Molten Feed Line from Siphon Forge)
    color([0.25, 0.25, 0.28]) {
        cylinder(h = bicep_total_length * 1.5, d = 42, center = true);
        // Direct injection gates tracking straight into the part mold cavities
        translate([0, 200, 300]) rotate([0, 90, 0]) cylinder(h = 350, d = 22);
        translate([0, -200, -300]) rotate([0, 90, 0]) cylinder(h = 350, d = 22);
    }
    
    // Instantiate Scaled Skeutomorphic Part Molds Symmetrically (Left & Right)
    Cast_Internal_Bicep_Cores();
}

module Cast_Internal_Bicep_Cores() {
    // ---- PART B1: INTERNAL LEFT UPPER BICEPS FRAME CORE ----
    translate([-450, 0, 400]) color([0.35, 0.35, 0.38]) { // Inner Frame Dark Spec
        difference() {
            // Main solid heavy-duty bicep bone block segment
            cylinder(h = bicep_total_length * 0.45, d = bicep_outer_diameter, center = true);
            
            // LINEAR TRACKING COWL SLIDEWAY [Milled out for shoulder multi-link sliders]
            cube([track_groove_width, bicep_outer_diameter + 10, bicep_total_length * 0.5], center = true);
            
            // SUB-ARMOR RECESSED CAPACITOR POCKETS [Segmented rows cut inside the armor inner wall]
            for (z_offset = [-150, 0, 150]) {
                translate([(bicep_outer_diameter/2 - armor_skin_thickness + capacitor_pocket_depth/2), 0, z_offset])
                    cube([capacitor_pocket_depth, capacitor_pocket_width, 100], center = true);
            }
            
            // Continuous cast-in routing track for the 4oz solid-state wiring rails
            translate([0, bicep_outer_diameter/2 - 40, 0])
                cube([harness_conduit_width, 100, bicep_total_length], center = true);
            
            // Slicing profile tool to generate an asymmetrical half-shell part component
            translate([0, -bicep_outer_diameter, 0])
                cube([bicep_outer_diameter * 2, bicep_outer_diameter * 2, bicep_total_length * 2], center = true);
        }
    }
    
    // ---- PART B2: INTERNAL RIGHT UPPER BICEPS FRAME CORE ----
    translate([450, 0, -400]) rotate([0, 0, 180]) color([0.35, 0.35, 0.38]) {
        difference() {
            cylinder(h = bicep_total_length * 0.45, d = bicep_outer_diameter, center = true);
            
            cube([track_groove_width, bicep_outer_diameter + 10, bicep_total_length * 0.5], center = true);
            
            for (z_offset = [-150, 0, 150]) {
                translate([(bicep_outer_diameter/2 - armor_skin_thickness + capacitor_pocket_depth/2), 0, z_offset])
                    cube([capacitor_pocket_depth, capacitor_pocket_width, 100], center = true);
            }
            
            translate([0, bicep_outer_diameter/2 - 40, 0])
                cube([harness_conduit_width, 100, bicep_total_length], center = true);
            
            translate([0, -bicep_outer_diameter, 0])
                cube([bicep_outer_diameter * 2, bicep_outer_diameter * 2, bicep_total_length * 2], center = true);
        }
    }
}

// Render Master Assembly to Parameter Workspace
Runner_B_Bicep_Core_Forge();
