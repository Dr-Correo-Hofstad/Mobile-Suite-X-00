// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - WEAPON INTERACTION INFRA
// COMPONENT VAULT: BANDAI CAST RUNNER D - HANDLE CLAMPS D15 & D16
// PACKAGING RE-ARCHITECTURE: SUB-ARMOR CAPACITOR RECESSED BANK INTEGRATION
// CONFIG METRIC: SCALED TITANIUM CASTS (1:1 ACTUAL METRIC UP-SCALE)
// ============================================================================

$fn = 100; // Circular segment rendering resolution count

// Structural Constants Scaled 1:1 for a 16.7-Meter Airframe Scale (mm)
clamp_total_length = 580;                // Total longitudinal vertical height (mm)
clamp_outer_diameter = 220;              // Transverse weapon grip bounding width (mm)
armor_skin_thickness = 50;              // Solid TiAl protective plating wall (mm)
harness_conduit_width = 40;             // Cast-in 4oz copper logic trace track (mm)
capacitor_pocket_depth = 15;            // Sub-armor recessed housing pocket depth (mm)
capacitor_pocket_width = 110;           // Transverse MLCC array pocket width (mm)

module Runner_D_Handle_Clamp_Forge() {
    // Central Supply Injection Runner Axis (Molten Feed Line from Siphon Forge)
    color([0.25, 0.25, 0.28]) {
        cylinder(h = clamp_total_length * 1.8, d = 35, center = true);
        // Direct injection gates tracking straight into the part mold cavities
        translate() rotate() cylinder(h = 350, d = 18);
        translate([0, 200, -250]) rotate() cylinder(h = 350, d = 18);
    }
    
    // Instantiate Scaled Skeutomorphic Part Molds Symmetrically (Left & Right)
    Cast_Internal_Handle_Clamps();
}

module Cast_Internal_Handle_Clamps() {
    // ---- PART D15: INTERNAL LEFT WEAPON HANDLE CLAMP FRAME ---- [Page 23, Step 14]
    translate([-300, 0, 300]) color([0.5, 0.5, 0.55]) { // Weapon Metallic Casing Spec
        difference() {
            // Main solid heavy-duty grip locking yoke block segment
            cube([clamp_outer_diameter, 180, clamp_total_length * 0.45], center = true);
            
            // Central interface slot cut out (Clears the main hand mating rail)
            cube([clamp_outer_diameter - (armor_skin_thickness * 2), 200, clamp_total_length * 0.5], center = true);
            
            // SUB-ARMOR RECESSED CAPACITOR POCKETS [Segmented rows cut inside the yokes]
            for (z_offset = [-100, 0, 100]) {
                translate([(clamp_outer_diameter/2 - armor_skin_thickness + capacitor_pocket_depth/2), 0, z_offset])
                    cube([capacitor_pocket_depth, capacitor_pocket_width, 80], center = true);
            }
            
            -- Continuous cast-in routing track for the 4oz solid-state wiring rails
            cube([harness_conduit_width, 200, clamp_total_length], center = true);
            
            -- Slicing profile tool to generate an asymmetrical half-shell part component
            translate([clamp_outer_diameter, 0, 0])
                cube([clamp_outer_diameter * 2, 400, clamp_total_length], center = true);
        }
    }
    
    // ---- PART D16: INTERNAL RIGHT WEAPON HANDLE CLAMP FRAME ---- [Page 23, Step 14]
    translate([300, 0, -300]) rotate() color([0.5, 0.5, 0.55]) {
        difference() {
            cube([clamp_outer_diameter, 180, clamp_total_length * 0.45], center = true);
            cube([clamp_outer_diameter - (armor_skin_thickness * 2), 200, clamp_total_length * 0.5], center = true);
            
            for (z_offset = [-100, 0, 100]) {
                translate([(clamp_outer_diameter/2 - armor_skin_thickness + capacitor_pocket_depth/2), 0, z_offset])
                    cube([capacitor_pocket_depth, capacitor_pocket_width, 80], center = true);
            }
            
            cube([harness_conduit_width, 200, clamp_total_length], center = true);
            translate([clamp_outer_diameter, 0, 0])
                cube([clamp_outer_diameter * 2, 400, clamp_total_length], center = true);
        }
    }
}

// Render Master Assembly to Parameter Workspace
Runner_D_Handle_Clamp_Forge();
