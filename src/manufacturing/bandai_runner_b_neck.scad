// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - HEAD ARTICULATION MATRIX
// COMPONENT VAULT: BANDAI CAST RUNNER B - CHEEK GUARDS B22 & NECK LINKS B23
// MANUFACTURING METRICS: SCALED DIECAST REINFORCED CORES (1:1 ACTUATOR UP-SCALE)
// ELECTRICAL PARITY: WIRELESS INDUCTIVE POWER HARNESS CONDUIT PLUGS
// ============================================================================

$fn = 100; // Circular segment resolution segment count

// Structural Constants Scaled 1:1 for a 16.7-Meter Airframe Scale (mm)
neck_joint_height = 480;                // Total vertical clearance of neck spline (mm)
neck_bearing_diameter = 260;            // Micro-cycloidal tracking core bore (mm)
armor_skin_thickness = 35;              // Solid TiAl defensive armor wall (mm)
harness_conduit_width = 40;             // Embedded 4oz copper logic trace track (mm)
cheek_guard_length = 520;               // Total vertical height of side armor (mm)

module Runner_B_Neck_Forge() {
    // Central Supply Injection Runner Axis (Molten Feed Line from Siphon Forge)
    color([0.22, 0.22, 0.24]) {
        cylinder(h = cheek_guard_length * 2.2, d = 38, center = true);
        // Direct injection gates tracking straight into the part mold cavities
        translate([0, 0, 350]) rotate([0, 90, 0]) cylinder(h = 400, d = 18);
        translate([0, 0, -350]) rotate([0, 90, 0]) cylinder(h = 400, d = 18);
    }
    
    // Instantiate Scaled Structural Molds Symmetrically
    Cast_Internal_Neck_Splines();
    Cast_External_Cheek_Armor();
}

module Cast_Internal_Neck_Splines() {
    // ---- PART B23: DUAL-AXIS UNIVERSAL NECK PIVOT SPLINE ---- [Page 7, Step 7]
    // Employs a pre-loaded cycloidal pin wheel loop to eliminate mechanical slack
    translate([0, 0, 350]) color([0.4, 0.4, 0.42]) { // Inner Frame Dark Spec
        difference() {
            // High-tensile universal cross block element
            cube([220, 220, neck_joint_height * 0.5], center = true);
            
            // Core Internal Boring for the micro-cycloidal rotational gears
            cylinder(h = 300, d = neck_bearing_diameter, center = true);
            rotate([90, 0, 0])
                cylinder(h = 300, d = neck_bearing_diameter * 0.8, center = true);
                
            // Internal conduit track for the cast-in solid-state electrical bus
            cube([harness_conduit_width, 240, neck_joint_height], center = true);
        }
    }
}

module Cast_External_Cheek_Armor() {
    // ---- PART B22: CHEEK PROTECTIVE ARMOR SHIELD (LEFT & RIGHT PAIR) ---- [Page 7, Step 7]
    color([0.85, 0.85, 0.9]) { // Classic White Armor Spec
        // Left Cheek Armor Plate
        translate([-400, 0, -350])
            difference() {
                // Tapered parabolic side shield panel component
                scale([1.0, 0.35, 1.0])
                    cylinder(h = cheek_guard_length, r1 = 240, r2 = 120, center = true);
                
                // Internal pocket milling (Leaves the rigid 35mm protective wall)
                scale([1.0, 0.35, 1.0])
                    cylinder(h = cheek_guard_length + 10, r1 = 240 - armor_skin_thickness, r2 = 120 - armor_skin_thickness, center = true);
                    
                // Clean splitting cut to generate an asymmetrical outer panel face
                translate([0, -300, 0])
                    cube([600, 600, cheek_guard_length * 2], center = true);
            }
            
        // Right Cheek Armor Plate
        translate([400, 0, -350]) rotate([0, 0, 180])
            difference() {
                scale([1.0, 0.35, 1.0])
                    cylinder(h = cheek_guard_length, r1 = 240, r2 = 120, center = true);
                scale([1.0, 0.35, 1.0])
                    cylinder(h = cheek_guard_length + 10, r1 = 240 - armor_skin_thickness, r2 = 120 - armor_skin_thickness, center = true);
                translate([0, -300, 0])
                    cube([600, 600, cheek_guard_length * 2], center = true);
            }
    }
}

// Render Master Assembly to Parameter Workspace
Runner_B_Neck_Forge();
