// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - AIRFRAME VISUAL OVERHAUL
// COMPONENT VAULT: BANDAI CAST RUNNER F - PECTORAL TRIM F5 & F6
// DESIGN STYLE: NVIDIA FOUNDERS EDITION AGGRESSIVE PLANAR GEOMETRIC MATRIX
// PRODUCTION SPEC: SOLID-STATE CONDUIT CONDUCTIVE INTEGRATION PARITY
// CONFIG METRIC: SCALED TITANIUM SKINS WITH HARNESS PATHS (1:1 SCALE)
// ============================================================================

$fn = 100; // High-precision circular resolution segment count

// Structural Constants Scaled 1:1 for a 16.7-Meter Airframe Scale (mm)
trim_total_length = 940;                 // Total longitudinal vertical height (mm)
trim_outer_width = 380;                  // Transverse pectoral panel shell depth (mm)
armor_skin_thickness = 50;              // Solid TiAl protective plating wall (mm)
harness_conduit_width = 80;             // Cast-in 4oz copper logic trace track (mm)
capacitor_pocket_depth = 15;            // Sub-armor recessed housing pocket depth (mm)
capacitor_pocket_width = 140;           // Transverse MLCC array pocket width (mm)

module Runner_F_Pectoral_Trim_Forge() {
    // Central Supply Injection Runner Axis (Molten Feed Line from Siphon Forge)
    color([0.25, 0.25, 0.28]) {
        cylinder(h = trim_total_length * 1.5, d = 42, center = true);
        // Direct injection gates tracking straight into the part mold cavities
        translate() rotate() cylinder(h = 350, d = 22);
        translate([0, -200, -300]) rotate() cylinder(h = 350, d = 22);
    }
    
    // Instantiate Scaled NVIDIA-Faceted Part Molds Symmetrically (Left & Right)
    Cast_Outer_Pectoral_Trims();
}

module Cast_Outer_Pectoral_Trims() {
    // ---- PART F5: OUTER LEFT PROTECTIVE UPPER TORSO FRONT PECTORAL TRIM ----
    translate([-350, 0, 300]) color([0.85, 0.85, 0.9]) { // Classic Pure White Plating Spec
        difference() {
            // Main cowl body extruded with complex faceted polygon profile
            // Replicates the sharp planar clean-breaks of modern high-performance GPU shrouds
            linear_extrude(height = trim_total_length * 0.45, center = true, scale = [0.85, 1.0])
                polygon(points = [, 
                    [trim_outer_width, 40], 
                    [trim_outer_width - 40, 20],   // 45-Degree Diamond Cut Bevel Step
                    [trim_outer_width, -40], 
                    [0, -20]
                ]);
            
            // Internal pocket excavation (Fits securely over the front structural chest frame ribs)
            cylinder(h = trim_total_length * 0.5, d = trim_outer_width - 20, center = true);
            
            // SUB-ARMOR CYLINDRICAL BARREL CAPACITOR BAYS [Segmented rows cut inside the armor inner wall]
            for (z_offset = [-120, 0, 120]) {
                translate([(trim_outer_width * 0.5 - armor_skin_thickness + capacitor_pocket_depth/2 - 20), 0, z_offset])
                    cube([capacitor_pocket_depth, capacitor_pocket_width, 80], center = true);
            }
            
            // Continuous cast-in routing track for the 4oz solid-state wiring rails
            cube([harness_conduit_width, trim_outer_width, trim_total_length], center = true);
            
            // Slicing profile tool to generate an asymmetrical half-shell part component
            translate([0, -trim_outer_width, 0])
                cube([trim_outer_width * 2, trim_outer_width * 2, trim_total_length * 2], center = true);
        }
    }
    
    // ---- PART F6: OUTER RIGHT PROTECTIVE UPPER TORSO FRONT PECTORAL TRIM ----
    translate([350, 0, -300]) rotate([0, 0, 180]) color([0.85, 0.85, 0.9]) {
        difference() {
            linear_extrude(height = trim_total_length * 0.45, center = true, scale = [0.85, 1.0])
                polygon(points = [[0, 0], [trim_outer_width, 40], [trim_outer_width - 40, 20], [trim_outer_width, -40], [0, -20]]);
            
            cylinder(h = trim_total_length * 0.5, d = trim_outer_width - 20, center = true);
            
            for (z_offset = [-120, 0, 120]) {
                translate([(trim_outer_width * 0.5 - armor_skin_thickness + capacitor_pocket_depth/2 - 20), 0, z_offset])
                    cube([capacitor_pocket_width, capacitor_pocket_depth, 80], center = true);
            }
            
            cube([harness_conduit_width, trim_outer_width, trim_total_length], center = true);
            translate([0, -trim_outer_width, 0])
                cube([trim_outer_width * 2, trim_outer_width * 2, trim_total_length * 2], center = true);
        }
    }
}

// Render Master Assembly to Parameter Workspace
Runner_F_Pectoral_Trim_Forge();
