// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - LOWER TORSO skeleton
// COMPONENTS: RUNNER F (THIGH SHIELDS) & RUNNER G (WAIST BRACKETS)
// CIRCUIT CONFIG: SOLID-STATE CAST-IN POWER RAILS FOR SQUARE-WAVE BUS
// REAL-WORLD ADAPTATION: SCALED TITANIUM CASTS (1:1 ACTUAL METRIC UP-SCALE)
// ============================================================================

$fn = 100; // Circular segment resolution calculation count

// Sizing Constants Scaled 1:1 for a 16.7-Meter Airframe Scale (mm)
waist_ring_diameter = 1420;             // Abdominal core outer ring width (mm)
thigh_armor_length = 2850;              // Total longitudinal upper leg height (mm)
thigh_outer_diameter = 740;             // External thigh casing thickness (mm)
armor_skin_thickness = 50;              // Solid TiAl defensive protective wall (mm)
harness_conduit_width = 80;             // Cast-in 4oz copper logic trace track (mm)

module Master_Hip_Thigh_Junction() {
    // Central Supply Injection Runner Axis (Molten Feed Line from Siphon Forge)
    color([0.22, 0.22, 0.24]) {
        cylinder(h = thigh_armor_length * 1.5, d = 45, center = true);
        // Direct injection gates tracking straight into the part mold cavities
        translate([0, 0, 800]) rotate([0, 90, 0]) cylinder(h = 500, d = 22);
        translate([0, 0, -800]) rotate([0, 90, 0]) cylinder(h = 500, d = 22);
    }
    
    // Instantiate Scaled Structural Molds Symmetrically
    Build_Runner_G_Waist();
    Build_Runner_F_Thighs();
}

module Build_Runner_G_Waist() {
    // ---- PARTS G11 & G12: LOWER ABDOMINAL WAIST CONNECTOR BARS ---- [Page 4, Step 05-1]
    color([0.35, 0.35, 0.38]) { // Inner Frame Gunmetal Spec
        // Left Waist Alignment Link (G11)
        translate([-350, 0, 1000])
            difference() {
                cylinder(h = 240, d = waist_ring_diameter * 0.4, center = true);
                cylinder(h = 260, d = waist_ring_diameter * 0.4 - 100, center = true);
                cube([harness_conduit_width, waist_ring_diameter, 300], center = true);
            }
            
        // Right Waist Alignment Link (G12)
        translate([350, 0, 1000]) rotate([0, 0, 180])
            difference() {
                cylinder(h = 240, d = waist_ring_diameter * 0.4, center = true);
                cylinder(h = 260, d = waist_ring_diameter * 0.4 - 100, center = true);
                cube([harness_conduit_width, waist_ring_diameter, 300], center = true);
            }
    }
}

module Build_Runner_F_Thighs() {
    // ---- PART F3: OUTER LEFT PROTECTIVE THIGH ARMOR SHELL ---- [Page 6, Step 2]
    translate([-500, 0, -400]) color([0.85, 0.85, 0.9]) { // Classic White Armor Spec
        difference() {
            // Main tapered external protective upper leg shield panel
            cylinder(h = thigh_armor_length * 0.45, d1 = thigh_outer_diameter + 100, d2 = thigh_outer_diameter, center = true);
            
            // Internal pocket excavation (Leaves the rigid 50mm protective wall)
            cylinder(h = thigh_armor_length * 0.5, d1 = thigh_outer_diameter + 100 - (armor_skin_thickness*2), d2 = thigh_outer_diameter - (armor_skin_thickness*2), center = true);
            
            // Continuous cast-in routing track for the 4oz solid-state wiring rails
            cube([harness_conduit_width, thigh_outer_diameter + 200, thigh_armor_length], center = true);
            
            // Slicing profile tool to generate an asymmetrical half-shell part component
            translate([0, -thigh_outer_diameter, 0])
                cube([thigh_outer_diameter * 2, thigh_outer_diameter * 2, thigh_armor_length * 2], center = true);
        }
    }
    
    // ---- PART F4: OUTER RIGHT PROTECTIVE THIGH ARMOR SHELL ---- [Page 6, Step 1]
    translate([500, 0, -400]) rotate([0, 0, 180]) color([0.85, 0.85, 0.9]) {
        difference() {
            cylinder(h = thigh_armor_length * 0.45, d1 = thigh_outer_diameter + 100, d2 = thigh_outer_diameter, center = true);
            cylinder(h = thigh_armor_length * 0.5, d1 = thigh_outer_diameter + 100 - (armor_skin_thickness*2), d2 = thigh_outer_diameter - (armor_skin_thickness*2), center = true);
            cube([harness_conduit_width, thigh_outer_diameter + 200, thigh_armor_length], center = true);
            translate([0, -thigh_outer_diameter, 0])
                cube([thigh_outer_diameter * 2, thigh_outer_diameter * 2, thigh_armor_length * 2], center = true);
        }
    }
}

// Render Finished Core Frame Node for Workspace Verification
Master_Hip_Thigh_Junction();
