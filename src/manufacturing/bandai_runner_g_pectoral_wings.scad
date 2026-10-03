// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - TORSO INNER BACKBONE INFRA
// COMPONENT VAULT: BANDAI CAST RUNNER G - PECTORAL WINGS G7 & G8
// PACKAGING RE-ARCHITECTURE: SUB-ARMOR CAPACITOR RECESSED BANK INTEGRATION
// DESIGN STYLE: NVIDIA FOUNDERS EDITION AGGRESSIVE PLANAR GEOMETRIC MATRIX
// CONFIG METRIC: SCALED TITANIUM CASTS WITH ENTRY SLOTS (1:1 ACTUAL METRIC)
// ============================================================================

$fn = 100; // High-precision circular resolution segment count

// Structural Constants Scaled 1:1 for a 16.7-Meter Airframe Scale (mm)
wing_total_length = 1140;                // Total longitudinal vertical height (mm)
wing_outer_width = 680;                  // Transverse pectoral armor shell depth (mm)
armor_skin_thickness = 50;              // Solid TiAl protective plating wall (mm)
harness_conduit_width = 80;             // Cast-in 4oz copper logic trace track (mm)
capacitor_pocket_depth = 15;            // Sub-armor recessed housing pocket depth (mm)
capacitor_pocket_width = 140;           // Transverse MLCC array pocket width (mm)

module Runner_G_Pectoral_Wing_Forge() {
    // Central Supply Injection Runner Axis (Molten Feed Line from Siphon Forge)
    color([0.22, 0.22, 0.25]) {
        cylinder(h = wing_total_length * 1.5, d = 42, center = true);
        // Direct injection gates tracking straight into the part mold cavities
        translate() rotate() cylinder(h = 450, d = 22);
        translate([0, -300, -400]) rotate() cylinder(h = 450, d = 22);
    }
    
    // Instantiate Scaled NVIDIA-Faceted Part Molds Symmetrically (Left & Right)
    Cast_Outer_Pectoral_Wings();
}

module Cast_Outer_Pectoral_Wings() {
    // ---- PART G7: OUTER LEFT PROTECTIVE UPPER TORSO PECTORAL CHEST WING ----
    translate([-550, 0, 400]) color([0.85, 0.85, 0.9]) { // Classic Pure White Plating Spec
        difference() {
            // Main cowl body extruded with complex faceted polygon profile
            // Replicates the sharp planar clean-breaks of modern high-performance GPU shrouds
            linear_extrude(height = wing_total_length * 0.45, center = true, scale = [0.85, 1.0])
                polygon(points = [, 
                    [wing_outer_width, 70], 
                    [wing_outer_width - 60, 35],   // 45-Degree Diamond Cut Bevel Step
                    [wing_outer_width, -70], 
                    [0, -30]
                ]);
            
            // Internal channel boring (Fits securely over the front cockpit capsule dome)
            cylinder(h = wing_total_length * 0.5, d = wing_outer_width - 30, center = true);
            
            // SUB-ARMOR CYLINDRICAL BARREL CAPACITOR BAYS [Segmented rows cut inside the armor inner wall]
            for (z_offset = [-150, 0, 150]) {
                translate([(wing_outer_width * 0.5 - armor_skin_thickness + capacitor_pocket_depth/2 - 20), 0, z_offset])
                    cube([capacitor_pocket_depth, capacitor_pocket_width, 100], center = true);
            }
            
            // Continuous cast-in routing track for the 4oz solid-state wiring rails
            cube([harness_conduit_width, wing_outer_width, wing_total_length], center = true);
            
            // Slicing profile tool to generate an asymmetrical half-shell part component
            translate([0, -wing_outer_width, 0])
                cube([wing_outer_width * 2, wing_outer_width * 2, wing_total_length * 2], center = true);
        }
    }
    
    // ---- PART G8: OUTER RIGHT PROTECTIVE UPPER TORSO PECTORAL CHEST WING ----
    translate([550, 0, -400]) rotate() color([0.85, 0.85, 0.9]) {
        difference() {
            linear_extrude(height = wing_total_length * 0.45, center = true, scale = [0.85, 1.0])
                polygon(points = [, [wing_outer_width, 70], [wing_outer_width - 60, 35], [wing_outer_width, -70], [0, -30]]);
            
            cylinder(h = wing_total_length * 0.5, d = wing_outer_width - 30, center = true);
            
            for (z_offset = [-150, 0, 150]) {
                translate([(wing_outer_width * 0.5 - armor_skin_thickness + capacitor_pocket_depth/2 - 20), 0, z_offset])
                    cube([capacitor_pocket_width, capacitor_pocket_depth, 100], center = true);
            }
            
            cube([harness_conduit_width, wing_outer_width, wing_total_length], center = true);
            translate([0, -wing_outer_width, 0])
                cube([wing_outer_width * 2, wing_outer_width * 2, wing_total_length * 2], center = true);
        }
    }
}

// Render Master Assembly to Parameter Workspace
Runner_G_Pectoral_Wing_Forge();
