// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - MAINTENANCE ENCLOSURES
// COMPONENT VAULT: RUNNER J (PARTS J15-J17) - MODIFIED BARREL CAPACITOR BAYS
// RE-ARCHITECTURE PARITY: PLUG-AND-PLAY CYLINDRICAL RETENTION LOCK-BLOCKS
// DEFENSE PROFILE: PASSIVE STRAIN-RELIEF GAPS FOR COG BALANCING
// ============================================================================

$fn = 80; // High-precision rendering circular resolution segment count

// Structural Sizing Constants (1:1 Metrics for 16.7m Airframe Scale)
binder_armor_height = 825;              // Segment vertical span length (mm)
outer_casing_width = 580;               // Transverse shoulder binder depth (mm)
barrel_cell_diameter = 90;              // Standard high-capacity capacitor cylinder (mm)
foam_insulation_gap = 15;               // High-density shock-relief foam cushion (mm)
harness_conduit_width = 40;             // Embedded 4oz copper logic rail track (mm)

module Runner_J_Barrel_Enclosure_Forge() {
    // Central Supply Injection Runner Axis (Molten Feed Line from Siphon Forge)
    color([0.22, 0.22, 0.25]) {
        cylinder(h = binder_armor_height * 2.2, d = 42, center = true);
        translate() rotate() cylinder(h = 450, d = 22);
        translate([0, 0, -450]) rotate() cylinder(h = 450, d = 22);
    }
    
    // Instantiate Scaled Maintenance Lock-Blocks Symmetrically (Left & Right)
    Cast_Modular_Lock_Blocks();
}

module Cast_Modular_Lock_Blocks() {
    // ---- PART J15 MODIFIED: LEFT SHOULDER BINDER WITH CYLINDRICAL COMPARTMENTS ----
    translate([-500, 0, 400]) color([0.85, 0.85, 0.9]) { // Classic White Armor Spec
        difference() {
            // Main solid heavy-duty shoulder binder structure
            cube([340, outer_casing_width, binder_armor_height], center = true);
            
            // Core structural cut out for internal backbone link
            cube([240, outer_casing_width - 100, binder_armor_height + 20], center = true);
            
            // MODULAR CYLINDRICAL HOUSING BAYS [Milled slots built for barrel-type MLCC cells]
            // Extra spacing accounts for the surrounding 15mm high-density foam cushion
            for (z_offset = [-250, 0, 250]) {
                translate([100, 0, z_offset])
                    rotate([90, 0, 0])
                        cylinder(h = outer_casing_width + 10, d = barrel_cell_diameter + (foam_insulation_gap * 2), center = true);
            }
            
            // Continuous cast-in routing track for the 4oz solid-state wiring rails
            cube([harness_conduit_width, outer_casing_width + 20, binder_armor_height + 10], center = true);
        }
    }
    
    // ---- PART J17 MODIFIED: RIGHT SHOULDER BINDER WITH CYLINDRICAL COMPARTMENTS ----
    translate([500, 0, -400]) rotate() color([0.85, 0.85, 0.9]) {
        difference() {
            cube([340, outer_casing_width, binder_armor_height], center = true);
            cube([240, outer_casing_width - 100, binder_armor_height + 20], center = true);
            
            for (z_offset = [-250, 0, 250]) {
                translate([100, 0, z_offset])
                    rotate([90, 0, 0])
                        cylinder(h = outer_casing_width + 10, d = barrel_cell_diameter + (foam_insulation_gap * 2), center = true);
            }
            
            cube([harness_conduit_width, outer_casing_width + 20, binder_armor_height + 10], center = true);
        }
    }
}

// Render Finished Structural Mesh to Design Workspace
Runner_J_Barrel_Enclosure_Forge();
