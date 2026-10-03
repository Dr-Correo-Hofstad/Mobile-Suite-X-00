// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - LIMB DEFENSE CORES
// COMPONENT VAULT: BANDAI CAST RUNNER F - THRUSTER HOUSINGS F13 & F14
// PACKAGING RE-ARCHITECTURE: SUB-ARMOR CAPACITOR RECESSED BANK INTEGRATION
// DESIGN STYLE: NVIDIA FOUNDERS EDITION AGGRESSIVE PLANAR GEOMETRIC MATRIX
// CONFIG METRIC: SCALED TITANIUM CASTS (1:1 ACTUAL METRIC UP-SCALE)
// ============================================================================

$fn = 100; // High-precision circular resolution segment count

// Structural Constants Scaled 1:1 for a 16.7-Meter Airframe Scale (mm)
housing_total_length = 760;              // Total longitudinal vertical height (mm)
housing_outer_width = 480;               // Transverse shoulder armor shell envelope width (mm)
armor_skin_thickness = 50;              // Solid TiAl protective plating wall (mm)
harness_conduit_width = 80;             // Cast-in 4oz copper logic trace track (mm)
capacitor_pocket_depth = 15;            // Sub-armor recessed housing pocket depth (mm)
capacitor_pocket_width = 140;           // Transverse MLCC array pocket width (mm)

module Runner_F_Thruster_Housing_Forge() {
    // Central Supply Injection Runner Axis (Molten Feed Line from Siphon Forge)
    color([0.25, 0.25, 0.28]) {
        cylinder(h = housing_total_length * 1.5, d = 42, center = true);
        // Direct injection gates tracking straight into the part mold cavities
        translate() rotate() cylinder(h = 350, d = 22);
        translate([0, -200, -300]) rotate() cylinder(h = 350, d = 22);
    }
    
    // Instantiate Scaled NVIDIA-Faceted Part Molds Symmetrically (Left & Right)
    Cast_Outer_Thruster_Housings();
}

module Cast_Outer_Thruster_Housings() {
    // ---- PART F13: OUTER LEFT PROTECTIVE UPPER SHOULDER THRUSTER HOUSING ----
    translate([-500, 0, 350]) color([0.85, 0.85, 0.9]) { // Classic Pure White Plating Spec
        difference() {
            // Main cowl body extruded with complex faceted polygon profile
            // Replicates the sharp planar clean-breaks of modern high-performance GPU shrouds
            linear_extrude(height = housing_total_length * 0.45, center = true, scale = [0.85, 1.0])
                polygon(points = [, 
                    [housing_outer_width, 60], 
                    [housing_outer_width - 50, 25],   // 45-Degree Diamond Cut Bevel Step
                    [housing_outer_width, -60], 
                    [0, -25]
                ]);
            
            // Internal channel boring (Fits securely over the main flight rocket nozzle bells)
            cylinder(h = housing_total_length * 0.5, d = housing_outer_width - 30, center = true);
            
            // SUB-ARMOR CYLINDRICAL BARREL CAPACITOR BAYS [Segmented rows cut inside the armor inner wall]
            for (z_offset = [-120, 0, 120]) {
                translate([(housing_outer_width * 0.5 - armor_skin_thickness + capacitor_pocket_depth/2 - 20), 0, z_offset])
                    cube([capacitor_pocket_depth, capacitor_pocket_width, 80], center = true);
            }
            
            // Continuous cast-in routing track for the 4oz solid-state wiring rails
            cube([harness_conduit_width, housing_outer_width, housing_total_length], center = true);
            
            // Slicing profile tool to generate an asymmetrical half-shell part component
            translate([0, -housing_outer_width, 0])
                cube([housing_outer_width * 2, housing_outer_width * 2, housing_total_length * 2], center = true);
        }
    }
    
    // ---- PART F14: OUTER RIGHT PROTECTIVE UPPER SHOULDER THRUSTER HOUSING ----
    translate([500, 0, -350]) rotate([0, 180, 0]) color([0.85, 0.85, 0.9]) {
        difference() {
            linear_extrude(height = housing_total_length * 0.45, center = true, scale = [0.85, 1.0])
                polygon(points = [[0, 30], [housing_outer_width, 60], [housing_outer_width - 50, 25], [housing_outer_width, -60], [0, -25]]);
            
            cylinder(h = housing_total_length * 0.5, d = housing_outer_width - 30, center = true);
            
            for (z_offset = [-120, 0, 120]) {
                translate([(housing_outer_width * 0.5 - armor_skin_thickness + capacitor_pocket_depth/2 - 20), 0, z_offset])
                    cube([capacitor_pocket_width, capacitor_pocket_depth, 80], center = true);
            }
            
            cube([harness_conduit_width, housing_outer_width, housing_total_length], center = true);
            translate([0, -housing_outer_width, 0])
                cube([housing_outer_width * 2, housing_outer_width * 2, housing_total_length * 2], center = true);
        }
    }
}

// Render Master Assembly to Parameter Workspace
Runner_F_Thruster_Housing_Forge();
