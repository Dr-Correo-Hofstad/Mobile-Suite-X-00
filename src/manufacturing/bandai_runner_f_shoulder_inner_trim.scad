// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - UPPER AIRFRAME EXTRACTIONS
// COMPONENT VAULT: BANDAI CAST RUNNER F - SHOULDER INNER TRIM F29 & F30
// PACKAGING RE-ARCHITECTURE: SUB-ARMOR CAPACITOR RECESSED BANK INTEGRATION
// CONFIG METRIC: SCALED TITANIUM CASTS (1:1 ACTUAL METRIC UP-SCALE)
// ============================================================================

$fn = 100; // Circular segment rendering resolution count

// Structural Constants Scaled 1:1 for a 16.7-Meter Airframe Scale (mm)
trim_total_length = 920;                 // Total longitudinal vertical height (mm)
trim_outer_diameter = 540;               // Transverse shoulder joint sleeve width (mm)
armor_skin_thickness = 50;              // Solid TiAl protective plating wall (mm)
harness_conduit_width = 80;             // Cast-in 4oz copper logic trace track (mm)
capacitor_pocket_depth = 15;            // Sub-armor recessed housing pocket depth (mm)
capacitor_pocket_width = 140;           // Transverse MLCC array pocket width (mm)

module Runner_F_Shoulder_Inner_Trim_Forge() {
    // Central Supply Injection Runner Axis (Molten Feed Line from Siphon Forge)
    color([0.24, 0.24, 0.26]) {
        cylinder(h = trim_total_length * 1.5, d = 42, center = true);
        // Direct injection gates tracking straight into the part mold cavities
        translate() rotate() cylinder(h = 450, d = 22);
        translate([0, 300, -400]) rotate() cylinder(h = 450, d = 22);
    }
    
    // Instantiate Scaled Skeutomorphic Part Molds Symmetrically (Left & Right)
    Cast_Outer_Shoulder_Inner_Trim();
}

module Cast_Outer_Shoulder_Inner_Trim() {
    // ---- PART F29: OUTER LEFT PROTECTIVE SHOULDER INNER TRIM BRACE ---- [Page 4, Step 05-2]
    translate([-500, 0, 450]) color([0.85, 0.85, 0.9]) { // Classic White Armor Spec
        difference() {
            // Main cylindrical contoured joint protective panel casing
            cylinder(h = trim_total_length * 0.45, d1 = trim_outer_diameter + 80, d2 = trim_outer_diameter, center = true);
            
            // Internal pocket excavation (Leaves the rigid 50mm protective boundary)
            cylinder(h = trim_total_length * 0.5, d1 = trim_outer_diameter + 80 - (armor_skin_thickness*2), d2 = trim_outer_diameter - (armor_skin_thickness*2), center = true);
            
            // SUB-ARMOR RECESSED CAPACITOR POCKETS [Segmented rows cut inside the armor inner wall]
            for (z_offset = [-120, 0, 120]) {
                translate([0, (trim_outer_diameter/2 - armor_skin_thickness + capacitor_pocket_depth/2), z_offset])
                    cube([capacitor_pocket_width, capacitor_pocket_depth, 100], center = true);
            }
            
            // Continuous cast-in routing track for the 4oz solid-state wiring rails
            cube([harness_conduit_width, trim_outer_diameter + 100, trim_total_length], center = true);
            
            // Slicing profile tool to generate an asymmetrical half-shell part component
            translate([0, -trim_outer_diameter, 0])
                cube([trim_outer_diameter * 2, trim_outer_diameter * 2, trim_total_length * 2], center = true);
        }
    }
    
    // ---- PART F30: OUTER RIGHT PROTECTIVE SHOULDER INNER TRIM BRACE ---- [Page 4, Step 05-2]
    translate([500, 0, -450]) rotate() color([0.85, 0.85, 0.9]) {
        difference() {
            cylinder(h = trim_total_length * 0.45, d1 = trim_outer_diameter + 80, d2 = trim_outer_diameter, center = true);
            cylinder(h = trim_total_length * 0.5, d1 = trim_outer_diameter + 80 - (armor_skin_thickness*2), d2 = trim_outer_diameter - (armor_skin_thickness*2), center = true);
            
            for (z_offset = [-120, 0, 120]) {
                translate([0, (trim_outer_diameter/2 - armor_skin_thickness + capacitor_pocket_depth/2), z_offset])
                    cube([capacitor_pocket_width, capacitor_pocket_depth, 100], center = true);
            }
            
            cube([harness_conduit_width, trim_outer_diameter + 100, trim_total_length], center = true);
            translate([0, -trim_outer_diameter, 0])
                cube([trim_outer_diameter * 2, trim_outer_diameter * 2, trim_total_length * 2], center = true);
        }
    }
}

// Render Master Assembly to Parameter Workspace
Runner_F_Shoulder_Inner_Trim_Forge();
