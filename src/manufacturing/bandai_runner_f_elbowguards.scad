// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - MID-ARM ARTICULATION DEFENSE
// COMPONENT VAULT: BANDAI CAST RUNNER F - ELBOW GUARDS F23 & F24
// PACKAGING RE-ARCHITECTURE: SUB-ARMOR CAPACITOR RECESSED BANK INTEGRATION
// CONFIG METRIC: SCALED TITANIUM CASTS (1:1 ACTUAL METRIC UP-SCALE)
// ============================================================================

$fn = 100; // Circular segment rendering resolution count

// Structural Constants Scaled 1:1 for a 16.7-Meter Airframe Scale (mm)
elbow_guard_length = 720;               // Total longitudinal vertical height (mm)
elbow_outer_diameter = 440;             // Transverse arm joint shell casing width (mm)
armor_skin_thickness = 50;              // Solid TiAl protective plating wall (mm)
harness_conduit_width = 80;             // Cast-in 4oz copper logic trace track (mm)
capacitor_pocket_depth = 15;            // Sub-armor recessed housing pocket depth (mm)
capacitor_pocket_width = 140;           // Transverse MLCC array pocket width (mm)

module Runner_F_Elbow_Guard_Forge() {
    // Central Supply Injection Runner Axis (Molten Feed Line from Siphon Forge)
    color([0.24, 0.24, 0.26]) {
        cylinder(h = elbow_guard_length * 1.8, d = 42, center = true);
        // Direct injection gates tracking straight into the part mold cavities
        translate() rotate() cylinder(h = 400, d = 22);
        translate([0, 250, -300]) rotate() cylinder(h = 400, d = 22);
    }
    
    // Instantiate Scaled Skeutomorphic Part Molds Symmetrically (Left & Right)
    Cast_Outer_Elbow_Armor();
}

module Cast_Outer_Elbow_Armor() {
    // ---- PART F23: REAR LEFT PROTECTIVE FOREARM ELBOW GUARD ---- [Page 6, Step 4]
    translate([-450, 0, 350]) color([0.85, 0.85, 0.9]) { // Classic White Armor Spec
        difference() {
            // Main cylindrical contoured elbow protective panel casing
            cylinder(h = elbow_guard_length * 0.45, d1 = elbow_outer_diameter + 80, d2 = elbow_outer_diameter, center = true);
            
            // Internal pocket excavation (Leaves the rigid 50mm protective boundary)
            cylinder(h = elbow_guard_length * 0.5, d1 = elbow_outer_diameter + 80 - (armor_skin_thickness*2), d2 = elbow_outer_diameter - (armor_skin_thickness*2), center = true);
            
            // SUB-ARMOR RECESSED CAPACITOR POCKETS [Segmented rows cut inside the armor inner wall]
            for (z_offset = [-120, 0, 120]) {
                translate([0, (elbow_outer_diameter/2 - armor_skin_thickness + capacitor_pocket_depth/2), z_offset])
                    cube([capacitor_pocket_width, capacitor_pocket_depth, 90], center = true);
            }
            
            // Continuous cast-in routing track for the 4oz solid-state wiring rails
            cube([harness_conduit_width, elbow_outer_diameter + 100, elbow_guard_length], center = true);
            
            // Slicing profile tool to generate an asymmetrical half-shell part component
            translate([0, -elbow_outer_diameter, 0])
                cube([elbow_outer_diameter * 2, elbow_outer_diameter * 2, elbow_guard_length * 2], center = true);
        }
    }
    
    // ---- PART F24: REAR RIGHT PROTECTIVE FOREARM ELBOW GUARD ---- [Page 6, Step 3]
    translate([450, 0, -350]) rotate() color([0.85, 0.85, 0.9]) {
        difference() {
            cylinder(h = elbow_guard_length * 0.45, d1 = elbow_outer_diameter + 80, d2 = elbow_outer_diameter, center = true);
            cylinder(h = elbow_guard_length * 0.5, d1 = elbow_outer_diameter + 80 - (armor_skin_thickness*2), d2 = elbow_outer_diameter - (armor_skin_thickness*2), center = true);
            
            for (z_offset = [-120, 0, 120]) {
                translate([0, (elbow_outer_diameter/2 - armor_skin_thickness + capacitor_pocket_depth/2), z_offset])
                    cube([capacitor_pocket_width, capacitor_pocket_depth, 90], center = true);
            }
            
            cube([harness_conduit_width, elbow_outer_diameter + 100, elbow_guard_length], center = true);
            translate([0, -elbow_outer_diameter, 0])
                cube([elbow_outer_diameter * 2, elbow_outer_diameter * 2, elbow_guard_length * 2], center = true);
        }
    }
}

// Render Master Assembly to Parameter Workspace
Runner_F_Elbow_Guard_Forge();
