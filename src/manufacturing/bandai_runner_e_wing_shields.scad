// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - FLIGHT SURFACE INFRA
// COMPONENT VAULT: BANDAI CAST RUNNER E - WING SHIELDS E3 & E4
// PACKAGING RE-ARCHITECTURE: SUB-ARMOR CAPACITOR RECESSED BANK INTEGRATION
// DESIGN STYLE: NVIDIA FOUNDERS EDITION AGGRESSIVE PLANAR GEOMETRIC MATRIX
// CONFIG METRIC: SCALED TITANIUM CASTS (1:1 ACTUAL METRIC UP-SCALE)
// ============================================================================

$fn = 100; // Circular segment rendering resolution count

// Structural Constants Scaled 1:1 for a 16.7-Meter Airframe Scale (mm)
shield_total_length = 1850;              // Total longitudinal vertical height (mm)
shield_outer_width = 680;                // Transverse upper wing shell envelope width (mm)
armor_skin_thickness = 50;              // Solid TiAl protective plating wall (mm)
harness_conduit_width = 80;             // Cast-in 4oz copper logic trace track (mm)
capacitor_pocket_depth = 15;            // Sub-armor recessed housing pocket depth (mm)
capacitor_pocket_width = 140;           // Transverse MLCC array pocket width (mm)

module Runner_E_Wing_Shield_Forge() {
    // Central Supply Injection Runner Axis (Molten Feed Line from Siphon Forge)
    color([0.22, 0.22, 0.25]) {
        cylinder(h = shield_total_length * 1.5, d = 42, center = true);
        // Direct injection gates tracking straight into the part mold cavities
        translate() rotate() cylinder(h = 450, d = 22);
        translate([0, 300, -400]) rotate() cylinder(h = 450, d = 22);
    }
    
    // Instantiate Scaled NVIDIA-Faceted Part Molds Symmetrically (Left & Right)
    Cast_Outer_Wing_Shields();
}

module Cast_Outer_Wing_Shields() {
    // ---- PART E3: OUTER LEFT PROTECTIVE UPPER FLIGHT WING ARMOR SHELL ---- [Page 19, Step 11-2]
    translate([-500, 0, 450]) color([0.85, 0.85, 0.9]) { // Classic White Armor Spec
        difference() {
            // Main weapon body extruded with complex faceted polygon profile
            // Replicates the sharp planar clean-breaks of modern high-performance GPU shrouds
            linear_extrude(height = shield_total_length * 0.45, center = true, scale = [0.8, 1.0])
                polygon(points = [, 
                    [shield_outer_width, 80], 
                    [shield_outer_width - 60, 40],   // 45-Degree Diamond Cut Bevel Step
                    [shield_outer_width, -80]
                ]);
            
            // Internal pocket excavation (Fits securely over the internal wing bone anchors)
            cylinder(h = shield_total_length * 0.5, d = shield_outer_width - 40, center = true);
            
            // SUB-ARMOR CYLINDRICAL BARREL CAPACITOR BAYS [Segmented rows cut inside the armor inner wall]
            for (z_offset = [-300, 0, 300]) {
                translate([(shield_outer_width * 0.5 - armor_skin_thickness + capacitor_pocket_depth/2), 0, z_offset])
                    cube([capacitor_pocket_depth, capacitor_pocket_width, 140], center = true);
            }
            
            // Continuous cast-in routing track for the 4oz solid-state wiring rails
            cube([harness_conduit_width, shield_outer_width, shield_total_length], center = true);
            
            // Slicing profile tool to generate an asymmetrical half-shell part component
            translate([0, -shield_outer_width, 0])
                cube([shield_outer_width * 2, shield_outer_width * 2, shield_total_length * 2], center = true);
        }
    }
    
    // ---- PART E4: OUTER RIGHT PROTECTIVE UPPER FLIGHT WING ARMOR SHELL ---- [Page 19, Step 11-2]
    translate([500, 0, -450]) rotate() color([0.85, 0.85, 0.9]) {
        difference() {
            linear_extrude(height = shield_total_length * 0.45, center = true, scale = [0.8, 1.0])
                polygon(points = [[0, 0], [shield_outer_width, 80], [shield_outer_width - 60, 40], [shield_outer_width, -80]]);
            
            cylinder(h = shield_total_length * 0.5, d = shield_outer_width - 40, center = true);
            
            for (z_offset = [-300, 0, 300]) {
                translate([(shield_outer_width * 0.5 - armor_skin_thickness + capacitor_pocket_depth/2), 0, z_offset])
                    cube([capacitor_pocket_width, capacitor_pocket_depth, 140], center = true);
            }
            
            cube([harness_conduit_width, shield_outer_width, shield_total_length], center = true);
            translate([0, -shield_outer_width, 0])
                cube([shield_outer_width * 2, shield_outer_width * 2, shield_total_length * 2], center = true);
        }
    }
}

// Render Master Assembly to Parameter Workspace
Runner_E_Wing_Shield_Forge();
