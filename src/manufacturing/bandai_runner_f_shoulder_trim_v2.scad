// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - LIMB DEFENSE CORES
// COMPONENT VAULT: BANDAI CAST RUNNER F - SHOULDER TRIM F29 & F30
// PACKAGING RE-ARCHITECTURE: SUB-ARMOR CAPACITOR RECESSED BANK INTEGRATION
// DESIGN STYLE: NVIDIA FOUNDERS EDITION AGGRESSIVE PLANAR GEOMETRY MATRIX
// CONFIG METRIC: SCALED TITANIUM CASTS (1:1 ACTUAL METRIC UP-SCALE)
// ============================================================================

$fn = 100; // High-precision circular resolution segment count

// Structural Constants Scaled 1:1 for a 16.7-Meter Airframe Scale (mm)
trim_total_length = 840;                 // Total longitudinal vertical height (mm)
trim_outer_width = 520;                  // Transverse shoulder armor shell depth (mm)
armor_skin_thickness = 50;              // Solid TiAl protective plating wall (mm)
harness_conduit_width = 80;             // Cast-in 4oz copper logic trace track (mm)
capacitor_pocket_depth = 15;            // Sub-armor recessed housing pocket depth (mm)
capacitor_pocket_width = 140;           // Transverse MLCC array pocket width (mm)

module Runner_F_Shoulder_Trim_Forge() {
    // Central Supply Injection Runner Axis (Molten Feed Line from Siphon Forge)
    color([0.25, 0.25, 0.28]) {
        cylinder(h = trim_total_length * 1.5, d = 42, center = true);
        // Direct injection gates tracking straight into the part mold cavities
        translate([0, 200, 300]) rotate([0, 90, 0]) cylinder(h = 350, d = 22);
        translate([0, -200, -300]) rotate([0, 90, 0]) cylinder(h = 350, d = 22);
    }
    
    // Instantiate Scaled NVIDIA-Faceted Part Molds Symmetrically (Left & Right)
    Cast_Outer_Shoulder_Trims();
}

module Cast_Outer_Shoulder_Trims() {
    // ---- PART F29: OUTER LEFT PROTECTIVE SHOULDER INNER TRIM PLATE ----
    translate([-450, 0, 350]) color([0.85, 0.85, 0.9]) { // Classic Pure White Plating Spec
        difference() {
            // Main cowl body extruded with complex faceted polygon profile
            // Replicates the sharp planar clean-breaks of modern high-performance GPU shrouds
            linear_extrude(height = trim_total_length * 0.45, center = true, scale = [0.85, 1.0])
                polygon(points = [,
                    [trim_outer_width, 60], 
                    [trim_outer_width - 50, 25],   // 45-Degree Diamond Cut Bevel Step
                    [trim_outer_width, -60], 
                    [0, -25]
                ]);
            
            // Internal channel boring (Fits securely over the shoulder articulation blocks)
            cylinder(h = trim_total_length * 0.5, d = trim_outer_width - 20, center = true);
            
            // SUB-ARMOR CYLINDRICAL BARREL CAPACITOR BAYS [Milled inside the flat rear block face]
            for (z_offset = [-120, 0, 120]) {
                translate([(trim_outer_width - armor_skin_thickness - 20), 0, z_offset])
                    cube([capacitor_pocket_depth, capacitor_pocket_width, 80], center = true);
            }
            
            // Continuous cast-in routing track for the 4oz solid-state wiring rails
            translate([trim_outer_width - 40, 0, 0])
                cube([harness_conduit_width, 80, trim_total_length], center = true);
                
            // Slicing profile tool to generate an asymmetrical half-shell part component
            translate([0, -trim_outer_width, 0])
                cube([trim_outer_width * 2, trim_outer_width * 2, trim_total_length * 2], center = true);
        }
    }
    
    // ---- PART F30: OUTER RIGHT PROTECTIVE SHOULDER INNER TRIM PLATE ----
    translate([450, 0, -350]) rotate([0, 0, 180]) color([0.85, 0.85, 0.9]) {
        difference() {
            linear_extrude(height = trim_total_length * 0.45, center = true, scale = [0.85, 1.0])
                polygon(points = [[0,0], [trim_outer_width, 60], [trim_outer_width - 50, 25], [trim_outer_width, -60], [0, -25]]);
            
            cylinder(h = trim_total_length * 0.5, d = trim_outer_width - 20, center = true);
            
            for (z_offset = [-120, 0, 120]) {
                translate([(trim_outer_width - armor_skin_thickness - 20), 0, z_offset])
                    cube([capacitor_pocket_depth, capacitor_pocket_width, 80], center = true);
            }
            
            translate([trim_outer_width - 40, 0, 0])
                cube([harness_conduit_width, 80, trim_total_length], center = true);
                
            translate([0, -trim_outer_width, 0])
                cube([trim_outer_width * 2, trim_outer_width * 2, trim_total_length * 2], center = true);
        }
    }
}

// Render Master Assembly to Parameter Workspace
Runner_F_Shoulder_Trim_Forge();
