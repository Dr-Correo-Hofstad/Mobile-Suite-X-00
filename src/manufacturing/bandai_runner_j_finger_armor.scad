// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - ROBOTIC MANIPULATOR HULL
// COMPONENT VAULT: BANDAI CAST RUNNER J - FINGER SHIELDS J5 THROUGH J8
// PACKAGING RE-ARCHITECTURE: SUB-ARMOR MODULAR CAPACITOR HOUSING RECESSES
// DESIGN CRITERIA: INTERPHALANX SLIDING RAILS & DLC LOW-FRICTION LINERS
// ============================================================================

$fn = 100; // Circular segment rendering resolution count

// Structural Constants Scaled 1:1 for a 16.7-Meter Airframe Scale (mm)
phalanx_armor_length = 240;             // Total longitudinal vertical height (mm)
finger_outer_diameter = 145;            // External finger shell envelope width (mm)
armor_skin_thickness = 35;              // Solid TiAl protective plating wall (mm)
harness_conduit_width = 40;             // Cast-in 4oz copper logic trace track (mm)
capacitor_pocket_depth = 15;            // Sub-armor recessed housing pocket depth (mm)
capacitor_pocket_width = 80;            // Transverse MLCC array pocket width (mm)

module Runner_J_Finger_Armor_Forge() {
    // Central Supply Injection Runner Axis (Molten Feed Line from Siphon Forge)
    color([0.22, 0.22, 0.25]) {
        cylinder(h = phalanx_armor_length * 3.5, d = 35, center = true);
        // Direct injection gates tracking straight into the part mold cavities
        for (z_offset = [-500, 500]) {
            translate([0, 0, z_offset]) rotate()
                cylinder(h = 350, d = 18);
        }
    }
    
    // Instantiate Scaled Protective Armor Molds Symmetrically
    Cast_Distal_Tip_Cowls();
    Cast_Interphalanx_Sliders();
}

module Cast_Distal_Tip_Cowls() {
    // ---- PARTS J5 & J6: DISTAL TIP PROTECTIVE ARMOR COWLINGS ---- [Page 6, Step 3 & 4]
    color([0.85, 0.85, 0.9]) { // Classic White Armor Spec
        // Left Distal Tip Shield (J5)
        translate([-400, 0, 400])
            difference() {
                // Tapered external protective fingertip guard shield block
                cylinder(h = phalanx_armor_length * 0.6, d1 = finger_outer_diameter, d2 = finger_outer_diameter * 0.7, center = true);
                
                // Internal pocket excavation (Leaves the rigid 35mm protective wall)
                cylinder(h = phalanx_armor_length, d1 = finger_outer_diameter - (armor_skin_thickness*2), d2 = (finger_outer_diameter * 0.7) - (armor_skin_thickness*2), center = true);
                
                // Continuous cast-in routing track for the 4oz solid-state wiring rails
                cube([harness_conduit_width, finger_outer_diameter + 20, phalanx_armor_length], center = true);
                
                // Slicing profile tool to generate an asymmetrical half-shell part component
                translate([0, -finger_outer_diameter, 0])
                    cube([finger_outer_diameter * 2, finger_outer_diameter * 2, phalanx_armor_length * 2], center = true);
            }
            
        // Right Distal Tip Shield (J6)
        translate() rotate()
            difference() {
                cylinder(h = phalanx_armor_length * 0.6, d1 = finger_outer_diameter, d2 = finger_outer_diameter * 0.7, center = true);
                cylinder(h = phalanx_armor_length, d1 = finger_outer_diameter - (armor_skin_thickness*2), d2 = (finger_outer_diameter * 0.7) - (armor_skin_thickness*2), center = true);
                cube([harness_conduit_width, finger_outer_diameter + 20, phalanx_armor_length], center = true);
                translate([0, -finger_outer_diameter, 0])
                    cube([finger_outer_diameter * 2, finger_outer_diameter * 2, phalanx_armor_length * 2], center = true);
            }
    }
}

module Cast_Interphalanx_Sliders() {
    // ---- PARTS J7 & J8: DYNAMIC INTERPHALANX SLIDING COVERS ---- [Page 6, Step 3 & 4]
    // Houses internal pockets to seat the peripheral capacitor banks with DLC tracks
    color([0.2, 0.4, 0.8]) { // Cobalt Blue Accent Armor Spec
        // Left Interphalanx Slider (J7)
        translate([-400, 0, -400])
            difference() {
                cylinder(h = phalanx_armor_length * 0.5, d = finger_outer_diameter + 20, center = true);
                cylinder(h = phalanx_armor_length * 0.7, d = finger_outer_diameter + 20 - (armor_skin_thickness*2), center = true);
                
                // SUB-ARMOR RECESSED CAPACITOR POCKETS [Milled inside the shield lining]
                translate([0, (finger_outer_diameter/2 - armor_skin_thickness + capacitor_pocket_depth/2), 0])
                    cube([capacitor_pocket_width, capacitor_pocket_depth, 100], center = true);
                
                cube([harness_conduit_width, finger_outer_diameter + 40, phalanx_armor_length], center = true);
                translate([0, -finger_outer_diameter, 0]) cube([finger_outer_diameter * 3, finger_outer_diameter * 2, phalanx_armor_length * 2], center = true);
            }
            
        // Right Interphalanx Slider (J8)
        translate([400, 0, -400]) rotate()
            difference() {
                cylinder(h = phalanx_armor_length * 0.5, d = finger_outer_diameter + 20, center = true);
                cylinder(h = phalanx_armor_length * 0.7, d = finger_outer_diameter + 20 - (armor_skin_thickness*2), center = true);
                
                translate([0, (finger_outer_diameter/2 - armor_skin_thickness + capacitor_pocket_depth/2), 0])
                    cube([capacitor_pocket_width, capacitor_pocket_depth, 100], center = true);
                
                cube([harness_conduit_width, finger_outer_diameter + 40, phalanx_armor_length], center = true);
                translate([0, -finger_outer_diameter, 0]) cube([finger_outer_diameter * 3, finger_outer_diameter * 2, phalanx_armor_length * 2], center = true);
            }
    }
}

// Render Master Assembly to Parameter Workspace
Runner_J_Finger_Armor_Forge();
