// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - MANIPULATOR STRUCTURAL CORE
// COMPONENT VAULT: BANDAI CAST RUNNER C - GAUNTLET CUFFS C11 & C12
// PACKAGING RE-ARCHITECTURE: SUB-ARMOR CAPACITOR RECESSED BANK INTEGRATION
// CONFIG METRIC: SCALED TITANIUM CASTS (1:1 ACTUAL METRIC UP-SCALE)
// ============================================================================

$fn = 100; // Circular segment rendering resolution count

// Structural Constants Scaled 1:1 for a 16.7-Meter Airframe Scale (mm)
gauntlet_total_length = 820;             // Total longitudinal vertical height (mm)
gauntlet_outer_diameter = 440;           // Transverse arm sleeve casing depth (mm)
armor_skin_thickness = 50;              // Solid TiAl protective plating wall (mm)
harness_conduit_width = 80;             // Cast-in 4oz copper logic trace track (mm)
capacitor_pocket_depth = 15;            // Sub-armor recessed housing pocket depth (mm)
capacitor_pocket_width = 140;           // Transverse MLCC array pocket width (mm)

module Runner_C_Gauntlet_Cuff_Forge() {
    // Central Supply Injection Runner Axis (Molten Feed Line from Siphon Forge)
    color([0.22, 0.22, 0.24]) {
        cylinder(h = gauntlet_total_length * 1.5, d = 42, center = true);
        // Direct injection gates tracking straight into the part mold cavities
        translate() rotate() cylinder(h = 450, d = 22);
        translate([0, 300, -400]) rotate() cylinder(h = 450, d = 22);
    }
    
    // Instantiate Scaled Skeutomorphic Part Molds Symmetrically (Left & Right)
    Cast_Outer_Gauntlet_Cuffs();
}

module Cast_Outer_Gauntlet_Cuffs() {
    // ---- PART C11: OUTER LEFT PROTECTIVE UPPER FOREARM GAUNTLET CUFF ---- [Page 5, Step 03-3]
    translate([-450, 0, 350]) color([0.2, 0.4, 0.8]) { // Cobalt Blue Accent Spec
        difference() {
            // Main cylindrical contoured weapon docking sleeve casing
            cylinder(h = gauntlet_total_length * 0.45, d1 = gauntlet_outer_diameter + 80, d2 = gauntlet_outer_diameter, center = true);
            
            // Internal channel boring (Fits securely over the sliding forearm armor shell)
            cylinder(h = gauntlet_total_length * 0.5, d = gauntlet_outer_diameter - 20, center = true);
            
            // SUB-ARMOR RECESSED CAPACITOR POCKETS [Segmented rows cut inside the armor inner wall]
            for (z_offset = [-120, 0, 120]) {
                translate([0, (gauntlet_outer_diameter/2 - armor_skin_thickness + capacitor_pocket_depth/2), z_offset])
                    cube([capacitor_pocket_width, capacitor_pocket_depth, 90], center = true);
            }
            
            // Continuous cast-in routing track for the 4oz solid-state wiring rails
            cube([harness_conduit_width, gauntlet_outer_diameter + 100, gauntlet_total_length], center = true);
            
            // Slicing profile tool to generate an asymmetrical half-shell part component
            translate([0, -gauntlet_outer_diameter, 0])
                cube([gauntlet_outer_diameter * 2, gauntlet_outer_diameter * 2, gauntlet_total_length * 2], center = true);
        }
    }
    
    // ---- PART C12: OUTER RIGHT PROTECTIVE UPPER FOREARM GAUNTLET CUFF ---- [Page 5, Step 03-3]
    translate([450, 0, -350]) rotate() color([0.2, 0.4, 0.8]) {
        difference() {
            cylinder(h = gauntlet_total_length * 0.45, d1 = gauntlet_outer_diameter + 80, d2 = gauntlet_outer_diameter, center = true);
            cylinder(h = gauntlet_total_length * 0.5, d = gauntlet_outer_diameter - 20, center = true);
            
            for (z_offset = [-120, 0, 120]) {
                translate([0, (gauntlet_outer_diameter/2 - armor_skin_thickness + capacitor_pocket_depth/2), z_offset])
                    cube([capacitor_pocket_width, capacitor_pocket_depth, 90], center = true);
            }
            
            cube([harness_conduit_width, gauntlet_outer_diameter + 100, gauntlet_total_length], center = true);
            translate([0, -gauntlet_outer_diameter, 0])
                cube([gauntlet_outer_diameter * 2, gauntlet_outer_diameter * 2, gauntlet_total_length * 2], center = true);
        }
    }
}

// Render Master Assembly to Parameter Workspace
Runner_C_Gauntlet_Cuff_Forge();
