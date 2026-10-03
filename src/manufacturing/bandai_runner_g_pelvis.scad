// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - LOWER AIRFRAME PROTECTION
// COMPONENT VAULT: BANDAI CAST RUNNER G - PELVIC ANCHORS G19 & G20
// PACKAGING RE-ARCHITECTURE: SUB-ARMOR CAPACITOR RECESSED BANK INTEGRATION
// CONFIG METRIC: SCALED TITANIUM CASTS (1:1 ACTUAL METRIC UP-SCALE)
// ============================================================================

$fn = 100; // Circular segment rendering resolution count

// Structural Constants Scaled 1:1 for a 16.7-Meter Airframe Scale (mm)
pelvic_plate_length = 1450;             // Total longitudinal vertical height (mm)
pelvic_outer_width = 820;               // Transverse pelvic shell casing depth (mm)
armor_skin_thickness = 60;              // Solid TiAl protective plating wall (mm)
harness_conduit_width = 80;             // Cast-in 4oz copper logic trace track (mm)
capacitor_pocket_depth = 15;            // Sub-armor recessed housing pocket depth (mm)
capacitor_pocket_width = 140;           // Transverse MLCC array pocket width (mm)

module Runner_G_Pelvic_Anchor_Forge() {
    // Central Supply Injection Runner Axis (Molten Feed Line from Siphon Forge)
    color([0.22, 0.22, 0.25]) {
        cylinder(h = pelvic_plate_length * 1.5, d = 42, center = true);
        // Direct injection gates tracking straight into the part mold cavities
        translate([0, 300, 400]) rotate([0, 90, 0]) cylinder(h = 450, d = 22);
        translate([0, -300, -400]) rotate([0, 90, 0]) cylinder(h = 450, d = 22);
    }
    
    // Instantiate Scaled Skeutomorphic Part Molds Symmetrically (Left & Right)
    Cast_Internal_Pelvic_Anchors();
}

module Cast_Internal_Pelvic_Anchors() {
    // ---- PART G19: INTERNAL LEFT PELVIC LOAD PLATE ANCHOR ---- [Page 18, Step 09-1]
    translate([-450, 0, 450]) color([0.35, 0.35, 0.38]) { // Inner Frame Dark Spec
        difference() {
            // Main solid heavy-duty lower frame stabilization anchor block
            cube([pelvic_outer_width * 0.45, 340, pelvic_plate_length * 0.45], center = true);
            
            // Core structural cut out for internal backbone link mounting
            cube([pelvic_outer_width * 0.35, 360, pelvic_plate_length * 0.35], center = true);
            
            // SUB-ARMOR RECESSED CAPACITOR POCKETS [Segmented rows cut inside the anchor wall]
            for (z_offset = [-200, 0, 200]) {
                translate([(pelvic_outer_width * 0.15 - armor_skin_thickness + capacitor_pocket_depth/2), 0, z_offset])
                    cube([capacitor_pocket_depth, capacitor_pocket_width, 140], center = true);
            }
            
            // Continuous cast-in routing track for the 4oz solid-state wiring rails
            cube([harness_conduit_width, 360, pelvic_plate_length], center = true);
        }
    }
    
    // ---- PART G20: INTERNAL RIGHT PELVIC LOAD PLATE ANCHOR ---- [Page 18, Step 09-1]
    translate([450, 0, -450]) rotate([0, 0, 180]) color([0.35, 0.35, 0.38]) {
        difference() {
            cube([pelvic_outer_width * 0.45, 340, pelvic_plate_length * 0.45], center = true);
            cube([pelvic_outer_width * 0.35, 360, pelvic_plate_length * 0.35], center = true);
            
            for (z_offset = [-200, 0, 200]) {
                translate([(pelvic_outer_width * 0.15 - armor_skin_thickness + capacitor_pocket_depth/2), 0, z_offset])
                    cube([capacitor_pocket_depth, capacitor_pocket_width, 140], center = true);
            }
            
            cube([harness_conduit_width, 360, pelvic_plate_length], center = true);
        }
    }
}

// Render Master Assembly to Parameter Workspace
Runner_G_Pelvic_Anchor_Forge();
