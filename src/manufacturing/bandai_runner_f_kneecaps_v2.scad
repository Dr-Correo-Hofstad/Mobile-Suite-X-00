// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - LOWER AIRFRAME DEFENSE MATRIX
// COMPONENT VAULT: BANDAI CAST RUNNER F - KNEE SHIELDS F9 & F10
// PACKAGING RE-ARCHITECTURE: SUB-ARMOR CAPACITOR RECESSED BANK INTEGRATION
// CONFIG METRIC: SCALED TITANIUM CASTS (1:1 ACTUAL METRIC UP-SCALE)
// ============================================================================

$fn = 100; // Circular segment rendering resolution count

// Structural Constants Scaled 1:1 for a 16.7-Meter Airframe Scale (mm)
kneecap_total_length = 740;              // Total longitudinal vertical height (mm)
kneecap_outer_width = 520;               // Transverse lower leg shell envelope width (mm)
armor_skin_thickness = 50;              // Solid TiAl protective plating wall (mm)
harness_conduit_width = 80;             // Cast-in 4oz copper logic trace track (mm)
capacitor_pocket_depth = 15;            // Sub-armor recessed housing pocket depth (mm)
capacitor_pocket_width = 140;           // Transverse MLCC array pocket width (mm)

module Runner_F_Kneecap_Forge() {
    // Central Supply Injection Runner Axis (Molten Feed Line from Siphon Forge)
    color([0.24, 0.24, 0.26]) {
        cylinder(h = kneecap_total_length * 1.8, d = 42, center = true);
        // Direct injection gates tracking straight into the part mold cavities
        translate() rotate() cylinder(h = 450, d = 22);
        translate([0, 300, -350]) rotate() cylinder(h = 450, d = 22);
    }
    
    // Instantiate Scaled Skeutomorphic Part Molds Symmetrically (Left & Right)
    Cast_Outer_Kneecap_Armor();
}

module Cast_Outer_Kneecap_Armor() {
    // ---- PART F9 MODIFIED: OUTER LEFT PROTECTIVE KNEE SHIELD CAP ---- [Page 7, Step 5 / Page 7, Step 08-2]
    translate([-500, 0, 350]) color([0.85, 0.85, 0.9]) { // Classic White Armor Spec
        difference() {
            // Main cylindrical contoured knee protective panel casing
            cylinder(h = kneecap_total_length * 0.45, d1 = kneecap_outer_width + 80, d2 = kneecap_outer_width, center = true);
            
            // Internal pocket excavation (Leaves the rigid 50mm protective boundary)
            cylinder(h = kneecap_total_length * 0.5, d1 = kneecap_outer_width + 80 - (armor_skin_thickness*2), d2 = kneecap_outer_width - (armor_skin_thickness*2), center = true);
            
            // SUB-ARMOR RECESSED CAPACITOR POCKETS [Segmented rows cut inside the armor inner wall]
            for (z_offset = [-100, 0, 120]) {
                translate([0, (kneecap_outer_width/2 - armor_skin_thickness + capacitor_pocket_depth/2), z_offset])
                    cube([capacitor_pocket_width, capacitor_pocket_depth, 90], center = true);
            }
            
            // Continuous cast-in routing track for the 4oz solid-state wiring rails
            cube([harness_conduit_width, kneecap_outer_width + 100, kneecap_total_length], center = true);
            
            // Slicing profile tool to generate an asymmetrical half-shell part component
            translate([0, -kneecap_outer_width, 0])
                cube([kneecap_outer_width * 2, kneecap_outer_width * 2, kneecap_total_length * 2], center = true);
        }
    }
    
    // ---- PART F10 MODIFIED: OUTER RIGHT PROTECTIVE KNEE SHIELD CAP ---- [Page 7, Step 5 / Page 7, Step 08-2]
    translate([500, 0, -350]) rotate() color([0.85, 0.85, 0.9]) {
        difference() {
            cylinder(h = kneecap_total_length * 0.45, d1 = kneecap_outer_width + 80, d2 = kneecap_outer_width, center = true);
            cylinder(h = kneecap_total_length * 0.5, d1 = kneecap_outer_width + 80 - (armor_skin_thickness*2), d2 = kneecap_outer_width - (armor_skin_thickness*2), center = true);
            
            for (z_offset = [-100, 0, 120]) {
                translate([0, (kneecap_outer_width/2 - armor_skin_thickness + capacitor_pocket_depth/2), z_offset])
                    cube([capacitor_pocket_width, capacitor_pocket_depth, 90], center = true);
            }
            
            cube([harness_conduit_width, kneecap_outer_width + 100, kneecap_total_length], center = true);
            translate([0, -kneecap_outer_width, 0])
                cube([kneecap_outer_width * 2, kneecap_outer_width * 2, kneecap_total_length * 2], center = true);
        }
    }
}

// Render Master Assembly to Parameter Workspace
Runner_F_Kneecap_Forge();
