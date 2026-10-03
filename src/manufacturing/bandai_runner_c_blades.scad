// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - MANIPULATOR MELEE EXTRICTIONS
// COMPONENT VAULT: BANDAI CAST RUNNER C - FOREARM BLADES C5 & C6
// RE-ARCHITECTURE PACKAGING: BARREL-TYPE SUB-ARMOR CAPACITOR RECESSED STORAGE
// WEAPON SPEC: MOLECULAR RAZOR EDGE TAPERING (0.05mm MINIMUM THICKNESS STANDARD)
// ============================================================================

$fn = 100; // Circular segment rendering resolution count

// Structural Constants Scaled 1:1 for a 16.7-Meter Airframe Scale (mm)
blade_total_length = 1450;               // Total vertical height of cutting blade (mm)
blade_outer_width = 380;                // Maximum width of base armor panel (mm)
armor_skin_thickness = 50;              // Solid TiAl protective base wall (mm)
harness_conduit_width = 80;             // Cast-in 4oz copper logic trace track (mm)
capacitor_pocket_depth = 15;            // Sub-armor recessed housing pocket depth (mm)
capacitor_pocket_width = 140;           // Transverse MLCC array pocket width (mm)

module Runner_C_Blade_Forge() {
    // Central Supply Injection Runner Axis (Molten Feed Line from Siphon Forge)
    color([0.22, 0.22, 0.24]) {
        cylinder(h = blade_total_length * 1.5, d = 42, center = true);
        // Direct injection gates tracking straight into the part mold cavities
        translate() rotate() cylinder(h = 450, d = 22);
        translate([0, 300, -400]) rotate() cylinder(h = 450, d = 22);
    }
    
    // Instantiate Scaled Hyper-Sharp Part Molds Symmetrically (Left & Right)
    Cast_Sharp_Forearm_Blades();
}

module Cast_Sharp_Forearm_Blades() {
    // ---- PART C5: OUTER LEFT PROTECTIVE FOREARM BLADE SHIELD ---- [Page 5, Step 03-4]
    translate([-450, 0, 450]) color([0.2, 0.4, 0.8]) { // Cobalt Blue Accent Spec
        difference() {
            // Main weapon body with built-in asymmetrical triangular wedge sharpening taper
            linear_extrude(height = blade_total_length * 0.45, center = true, scale = [0.8, 1.0])
                polygon(points = [, 
                    [blade_outer_width, 80], 
                    [blade_outer_width, -80], 
                    [0.05, 0] // Hyper-sharp 0.05mm molecular edge convergence point
                ]);
            
            // SUB-ARMOR RECESSED CAPACITOR POCKETS [Segmented rows cut inside the rear base block]
            for (z_offset = [-200, 0, 200]) {
                translate([(blade_outer_width - armor_skin_thickness - 20), 0, z_offset])
                    cube([capacitor_pocket_depth, capacitor_pocket_width, 120], center = true);
            }
            
            // Continuous cast-in routing track for the 4oz solid-state wiring rails
            translate([blade_outer_width - 40, 0, 0])
                cube([harness_conduit_width, 100, blade_total_length], center = true);
        }
    }
    
    // ---- PART C6: OUTER RIGHT PROTECTIVE FOREARM BLADE SHIELD ---- [Page 5, Step 03-4]
    translate([450, 0, -450]) rotate([0, 0, 180]) color([0.2, 0.4, 0.8]) {
        difference() {
            linear_extrude(height = blade_total_length * 0.45, center = true, scale = [0.8, 1.0])
                polygon(points = [[0, 0], [blade_outer_width, 80], [blade_outer_width, -80], [0.05, 0]]);
            
            for (z_offset = [-200, 0, 200]) {
                translate([(blade_outer_width - armor_skin_thickness - 20), 0, z_offset])
                    cube([capacitor_pocket_depth, capacitor_pocket_width, 120], center = true);
            }
            
            translate([blade_outer_width - 40, 0, 0])
                cube([harness_conduit_width, 100, blade_total_length], center = true);
        }
    }
}

// Render Master Assembly to Parameter Workspace
Runner_C_Blade_Forge();
