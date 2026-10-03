// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - LOWER TORSO DEFENSE MATRIX
// COMPONENT VAULT: BANDAI CAST RUNNER C - BREASTPLATE FLAPS C3 & C4
// PACKAGING RE-ARCHITECTURE: SUB-ARMOR CAPACITOR RECESSED BANK INTEGRATION
// CONFIG METRIC: SCALED TITANIUM CASTS (1:1 ACTUAL METRIC UP-SCALE)
// ============================================================================

$fn = 100; // Circular segment rendering resolution count

// Structural Constants Scaled 1:1 for a 16.7-Meter Airframe Scale (mm)
breastplate_total_length = 1250;         // Total longitudinal vertical height (mm)
breastplate_outer_width = 980;          // Transverse armor plate envelope depth (mm)
armor_skin_thickness = 50;              // Solid TiAl protective plating wall (mm)
harness_conduit_width = 80;             // Cast-in 4oz copper logic trace track (mm)
capacitor_pocket_depth = 15;            // Sub-armor recessed housing pocket depth (mm)
capacitor_pocket_width = 140;           // Transverse MLCC array pocket width (mm)

module Runner_C_Breastplate_Forge() {
    // Central Supply Injection Runner Axis (Molten Feed Line from Siphon Forge)
    color([0.22, 0.22, 0.24]) {
        cylinder(h = breastplate_total_length * 1.5, d = 42, center = true);
        // Direct injection gates tracking straight into the part mold cavities
        translate() rotate() cylinder(h = 450, d = 22);
        translate([0, 300, -400]) rotate() cylinder(h = 450, d = 22);
    }
    
    // Instantiate Scaled Skeutomorphic Part Molds Symmetrically (Left & Right)
    Cast_Outer_Breastplates();
}

module Cast_Outer_Breastplates() {
    // ---- PART C3: OUTER LEFT PROTECTIVE LOWER BREASTPLATE FLAP ---- [Page 5, Step 02-2]
    translate([-500, 0, 450]) color([0.2, 0.4, 0.8]) { // Cobalt Blue Accent Spec
        difference() {
            // Main solid contoured external protective chest armor block
            scale([1.0, 0.5, 1.0])
                cylinder(h = breastplate_total_length * 0.45, r1 = breastplate_outer_width * 0.5, r2 = breastplate_outer_width * 0.35, center = true);
            
            // Internal pocket excavation (Leaves the rigid 50mm protective wall)
            scale([1.0, 0.5, 1.0])
                cylinder(h = breastplate_total_length * 0.5, r1 = (breastplate_outer_width * 0.5) - armor_skin_thickness, r2 = (breastplate_outer_width * 0.35) - armor_skin_thickness, center = true);
            
            // SUB-ARMOR RECESSED CAPACITOR POCKETS [Segmented rows cut inside the armor inner wall]
            for (z_offset = [-150, 0, 150]) {
                translate([0, (breastplate_outer_width * 0.25 - armor_skin_thickness + capacitor_pocket_depth/2), z_offset])
                    cube([capacitor_pocket_width, capacitor_pocket_depth, 100], center = true);
            }
            
            // Continuous cast-in routing track for the 4oz solid-state wiring rails
            cube([harness_conduit_width, breastplate_outer_width * 2, breastplate_total_length], center = true);
            
            // Slicing profile tool to generate an asymmetrical half-shell part component
            translate([0, -breastplate_outer_width, 0])
                cube([breastplate_outer_width * 2, breastplate_outer_width * 2, breastplate_total_length * 2], center = true);
        }
    }
    
    // ---- PART C4: OUTER RIGHT PROTECTIVE LOWER BREASTPLATE FLAP ---- [Page 5, Step 02-2]
    translate([500, 0, -450]) rotate() color([0.2, 0.4, 0.8]) {
        difference() {
            scale([1.0, 0.5, 1.0])
                cylinder(h = breastplate_total_length * 0.45, r1 = breastplate_outer_width * 0.5, r2 = breastplate_outer_width * 0.35, center = true);
            scale([1.0, 0.5, 1.0])
                cylinder(h = breastplate_total_length * 0.5, r1 = (breastplate_outer_width * 0.5) - armor_skin_thickness, r2 = (breastplate_outer_width * 0.35) - armor_skin_thickness, center = true);
            
            for (z_offset = [-150, 0, 150]) {
                translate([0, (breastplate_outer_width * 0.25 - armor_skin_thickness + capacitor_pocket_depth/2), z_offset])
                    cube([capacitor_pocket_width, capacitor_pocket_depth, 100], center = true);
            }
            
            cube([harness_conduit_width, breastplate_outer_width * 2, breastplate_total_length], center = true);
            translate([0, -breastplate_outer_width, 0])
                cube([breastplate_outer_width * 2, breastplate_outer_width * 2, breastplate_total_length * 2], center = true);
        }
    }
}

// Render Master Assembly to Parameter Workspace
Runner_C_Breastplate_Forge();
