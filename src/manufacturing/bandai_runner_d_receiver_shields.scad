// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - WEAPON MANIFEST DEFENSE
// COMPONENT VAULT: BANDAI CAST RUNNER D - RECEIVER SHIELDS D21 & D22
// PACKAGING RE-ARCHITECTURE: SUB-ARMOR CAPACITOR RECESSED BANK INTEGRATION
// DESIGN STYLE: NVIDIA FOUNDERS EDITION AGGRESSIVE PLANAR GEOMETRY MATRIX
// CONFIG METRIC: SCALED TITANIUM CASTS (1:1 ACTUAL METRIC UP-SCALE)
// ============================================================================

$fn = 100; // Circular segment rendering resolution count

// Structural Constants Scaled 1:1 for a 16.7-Meter Airframe Scale (mm)
shield_total_length = 740;               // Total longitudinal vertical height (mm)
shield_outer_diameter = 360;             // Transverse receiver joint sleeve width (mm)
armor_skin_thickness = 50;              // Solid TiAl protective plating wall (mm)
harness_conduit_width = 80;             // Cast-in 4oz copper logic trace track (mm)
capacitor_pocket_depth = 15;            // Sub-armor recessed housing pocket depth (mm)
capacitor_pocket_width = 140;           // Transverse MLCC array pocket width (mm)

module Runner_D_Receiver_Shield_Forge() {
    // Central Supply Injection Runner Axis (Molten Feed Line from Siphon Forge)
    color([0.25, 0.25, 0.28]) {
        cylinder(h = shield_total_length * 1.5, d = 42, center = true);
        // Direct injection gates tracking straight into the part mold cavities
        translate() rotate() cylinder(h = 450, d = 22);
        translate([0, 300, -400]) rotate() cylinder(h = 450, d = 22);
    }
    
    // Instantiate Scaled Skeutomorphic Part Molds Symmetrically (Left & Right)
    Cast_Outer_Receiver_Shields();
}

module Cast_Outer_Receiver_Shields() {
    // ---- PART D21: OUTER LEFT PROTECTIVE WEAPON RECEIVER SHIELD ---- [Page 23, Step 14-4]
    translate([-450, 0, 350]) color([0.5, 0.5, 0.55]) { // Weapon Metallic Casing Spec
        difference() {
            // Main weapon body extruded with complex faceted polygon profile
            // Replicates the sharp planar clean-breaks of modern high-performance GPU shrouds
            linear_extrude(height = shield_total_length * 0.45, center = true, scale = [0.85, 1.0])
                polygon(points = [, 
                    [shield_outer_diameter, 50], 
                    [shield_outer_diameter - 50, 25],   // 45-Degree Diamond Cut Bevel Step
                    [shield_outer_diameter, -50], 
                    [0, -25]
                ]);
            
            // Internal channel boring (Fits securely over the receiver latches block)
            cylinder(h = shield_total_length * 0.5, d = shield_outer_diameter - 20, center = true);
            
            // SUB-ARMOR CYLINDRICAL BARREL CAPACITOR BAYS [Milled inside the flat rear block face]
            for (z_offset = [-100, 0, 100]) {
                translate([(shield_outer_diameter - armor_skin_thickness - 20), 0, z_offset])
                    cube([capacitor_pocket_depth, capacitor_pocket_width, 80], center = true);
            }
            
            // Continuous cast-in routing track for the 4oz solid-state wiring rails
            translate([shield_outer_diameter - 40, 0, 0])
                cube([harness_conduit_width, 80, shield_total_length], center = true);
                
            // Slicing profile tool to generate an asymmetrical half-shell part component
            translate([0, -shield_outer_diameter, 0])
                cube([shield_outer_diameter * 2, shield_outer_diameter * 2, shield_total_length * 2], center = true);
        }
    }
    
    // ---- PART D22: OUTER RIGHT PROTECTIVE WEAPON RECEIVER SHIELD ---- [Page 23, Step 14-4]
    translate([450, 0, -350]) rotate() color([0.5, 0.5, 0.55]) {
        difference() {
            linear_extrude(height = shield_total_length * 0.45, center = true, scale = [0.85, 1.0])
                polygon(points = [[0, 0], [shield_outer_diameter, 50], [shield_outer_diameter - 50, 25], [shield_outer_diameter, -50], [0, -25]]);
            
            cylinder(h = shield_total_length * 0.5, d = shield_outer_diameter - 20, center = true);
            
            for (z_offset = [-100, 0, 100]) {
                translate([(shield_outer_diameter - armor_skin_thickness - 20), 0, z_offset])
                    cube([capacitor_pocket_depth, capacitor_pocket_width, 80], center = true);
            }
            
            translate([shield_outer_diameter - 40, 0, 0])
                cube([harness_conduit_width, 80, shield_total_length], center = true);
                
            translate([0, -shield_outer_diameter, 0])
                cube([shield_outer_diameter * 2, shield_outer_diameter * 2, shield_total_length * 2], center = true);
        }
    }
}

// Render Master Assembly to Parameter Workspace
Runner_D_Receiver_Shield_Forge();
