// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - LOWER ARM DEFENSE ARCHITECTURE
// COMPONENT VAULT: BANDAI CAST RUNNER C - ELBOW CAPS C9 & C10
// PACKAGING RE-ARCHITECTURE: SUB-ARMOR CAPACITOR RECESSED BANK INTEGRATION
// DESIGN STYLE: NVIDIA FOUNDERS EDITION AGGRESSIVE PLANAR GEOMETRY MATRIX
// CONFIG METRIC: SCALED TITANIUM CASTS (1:1 ACTUAL METRIC UP-SCALE)
// ============================================================================

$fn = 100; // Circular segment rendering resolution count

// Structural Constants Scaled 1:1 for a 16.7-Meter Airframe Scale (mm)
cap_total_length = 720;                  // Total longitudinal vertical height (mm)
cap_outer_diameter = 430;                // Transverse elbow joint sleeve width (mm)
armor_skin_thickness = 50;              // Solid TiAl protective plating wall (mm)
harness_conduit_width = 80;             // Cast-in 4oz copper logic trace track (mm)
capacitor_pocket_depth = 15;            // Sub-armor recessed housing pocket depth (mm)
capacitor_pocket_width = 140;           // Transverse MLCC array pocket width (mm)

module Runner_C_Elbow_Cap_Forge() {
    // Central Supply Injection Runner Axis (Molten Feed Line from Siphon Forge)
    color([0.22, 0.22, 0.24]) {
        cylinder(h = cap_total_length * 1.5, d = 42, center = true);
        // Direct injection gates tracking straight into the part mold cavities
        translate() rotate() cylinder(h = 450, d = 22);
        translate([0, 300, -400]) rotate() cylinder(h = 450, d = 22);
    }
    
    // Instantiate Scaled Skeutomorphic Part Molds Symmetrically (Left & Right)
    Cast_Outer_Elbow_Caps();
}

module Cast_Outer_Elbow_Caps() {
    // ---- PART C9: OUTER LEFT PROTECTIVE UPPER FOREARM ELBOW SHIELDING CAP ---- [Page 5, Step 03-3]
    translate([-450, 0, 350]) color([0.2, 0.4, 0.8]) { // Cobalt Blue Accent Spec
        difference() {
            // Main weapon body extruded with complex faceted polygon profile
            // Replicates the sharp planar clean-breaks of modern high-performance GPU shrouds
            linear_extrude(height = cap_total_length * 0.45, center = true, scale = [0.85, 1.0])
                polygon(points = [, 
                    [cap_outer_diameter, 50], 
                    [cap_outer_diameter - 50, 25],   // 45-Degree Diamond Cut Bevel Step
                    [cap_outer_diameter, -50], 
                    [0, 0]
                ]);
            
            // SUB-ARMOR CYLINDRICAL BARREL CAPACITOR BAYS [Milled inside the flat rear block face]
            for (z_offset = [-100, 0, 100]) {
                translate([(cap_outer_diameter - armor_skin_thickness - 20), 0, z_offset])
                    cube([capacitor_pocket_depth, capacitor_pocket_width, 80], center = true);
            }
            
            // Continuous cast-in routing track for the 4oz solid-state wiring rails
            translate([cap_outer_diameter - 40, 0, 0])
                cube([harness_conduit_width, 80, cap_total_length], center = true);
        }
    }
    
    // ---- PART C10: OUTER RIGHT PROTECTIVE UPPER FOREARM ELBOW SHIELDING CAP ---- [Page 5, Step 03-3]
    translate([450, 0, -350]) rotate() color([0.2, 0.4, 0.8]) {
        difference() {
            linear_extrude(height = cap_total_length * 0.45, center = true, scale = [0.85, 1.0])
                polygon(points = [[0,0], [cap_outer_diameter, 50], [cap_outer_diameter - 50, 25], [cap_outer_diameter, -50], [0,0]]);
            
            for (z_offset = [-100, 0, 100]) {
                translate([(cap_outer_diameter - armor_skin_thickness - 20), 0, z_offset])
                    cube([capacitor_pocket_depth, capacitor_pocket_width, 80], center = true);
            }
            
            translate([cap_outer_diameter - 40, 0, 0])
                cube([harness_conduit_width, 80, cap_total_length], center = true);
        }
    }
}

// Render Master Assembly to Parameter Workspace
Runner_C_Elbow_Cap_Forge();
