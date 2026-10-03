// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - LOWER AIRFRAME PROTECTION
// COMPONENT VAULT: BANDAI CAST RUNNER F - HIP SHROUDS F15 & F16
// PACKAGING RE-ARCHITECTURE: SUB-ARMOR CAPACITOR RECESSED BANK INTEGRATION
// CONFIG METRIC: SCALED TITANIUM CASTS (1:1 ACTUAL METRIC UP-SCALE)
// ============================================================================

$fn = 100; // Circular segment rendering resolution count

// Structural Constants Scaled 1:1 for a 16.7-Meter Airframe Scale (mm)
hip_shroud_length = 1350;                // Total longitudinal vertical height (mm)
hip_outer_diameter = 740;               // Transverse pelvic shell casing width (mm)
armor_skin_thickness = 50;              // Solid TiAl protective plating wall (mm)
harness_conduit_width = 80;             // Cast-in 4oz copper logic trace track (mm)
capacitor_pocket_depth = 15;            // Sub-armor recessed housing pocket depth (mm)
capacitor_pocket_width = 140;           // Transverse MLCC array pocket width (mm)

module Runner_F_Hip_Shroud_Forge() {
    // Central Supply Injection Runner Axis (Molten Feed Line from Siphon Forge)
    color([0.24, 0.24, 0.26]) {
        cylinder(h = hip_shroud_length * 1.5, d = 42, center = true);
        // Direct injection gates tracking straight into the part mold cavities
        translate() rotate() cylinder(h = 450, d = 22);
        translate([0, 300, -400]) rotate() cylinder(h = 450, d = 22);
    }
    
    // Instantiate Scaled Skeutomorphic Part Molds Symmetrically (Left & Right)
    Cast_Outer_Hip_Armor();
}

module Cast_Outer_Hip_Armor() {
    // ---- PART F15: OUTER LEFT PROTECTIVE UPPER THIGH SHROUD ---- [Page 13, Step 6-1]
    translate([-500, 0, 450]) color([0.85, 0.85, 0.9]) { // Classic White Armor Spec
        difference() {
            // Main cylindrical contoured lower hip protective panel casing
            cylinder(h = hip_shroud_length * 0.45, d1 = hip_outer_diameter + 100, d2 = hip_outer_diameter, center = true);
            
            // Internal pocket excavation (Leaves the rigid 50mm protective boundary)
            cylinder(h = hip_shroud_length * 0.5, d1 = hip_outer_diameter + 100 - (armor_skin_thickness*2), d2 = hip_outer_diameter - (armor_skin_thickness*2), center = true);
            
            // SUB-ARMOR RECESSED CAPACITOR POCKETS [Segmented rows cut inside the armor inner wall]
            for (z_offset = [-200, 0, 200]) {
                translate([0, (hip_outer_diameter/2 - armor_skin_thickness + capacitor_pocket_depth/2), z_offset])
                    cube([capacitor_pocket_width, capacitor_pocket_depth, 140], center = true);
            }
            
            // Continuous cast-in routing track for the 4oz solid-state wiring rails
            cube([harness_conduit_width, hip_outer_diameter + 120, hip_shroud_length], center = true);
            
            // Slicing profile tool to generate an asymmetrical half-shell part component
            translate([0, -hip_outer_diameter, 0])
                cube([hip_outer_diameter * 2, hip_outer_diameter * 2, hip_shroud_length * 2], center = true);
        }
    }
    
    // ---- PART F16: OUTER RIGHT PROTECTIVE UPPER THIGH SHROUD ---- [Page 13, Step 6-1]
    translate([500, 0, -450]) rotate() color([0.85, 0.85, 0.9]) {
        difference() {
            cylinder(h = hip_shroud_length * 0.45, d1 = hip_outer_diameter + 100, d2 = hip_outer_diameter, center = true);
            cylinder(h = hip_shroud_length * 0.5, d1 = hip_outer_diameter + 100 - (armor_skin_thickness*2), d2 = hip_outer_diameter - (armor_skin_thickness*2), center = true);
            
            for (z_offset = [-200, 0, 200]) {
                translate([0, (hip_outer_diameter/2 - armor_skin_thickness + capacitor_pocket_depth/2), z_offset])
                    cube([capacitor_pocket_width, capacitor_pocket_depth, 140], center = true);
            }
            
            cube([harness_conduit_width, hip_outer_diameter + 120, hip_shroud_length], center = true);
            translate([0, -hip_outer_diameter, 0])
                cube([hip_outer_diameter * 2, hip_outer_diameter * 2, hip_shroud_length * 2], center = true);
        }
    }
}

// Render Master Assembly to Parameter Workspace
Runner_F_Hip_Shroud_Forge();
