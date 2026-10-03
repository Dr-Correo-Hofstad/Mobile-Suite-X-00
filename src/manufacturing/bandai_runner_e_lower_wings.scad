// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - FLIGHT SURFACE INFRA
// COMPONENT VAULT: BANDAI CAST RUNNER E - LOWER WINGS E11 & E12
// PACKAGING RE-ARCHITECTURE: SUB-ARMOR CAPACITOR RECESSED BANK INTEGRATION
// DESIGN STYLE: NVIDIA FOUNDERS EDITION AGGRESSIVE PLANAR GEOMETRY MATRIX
// CONFIG METRIC: SCALED TITANIUM CASTS (1:1 ACTUAL METRIC UP-SCALE)
// ============================================================================

$fn = 100; // Circular segment rendering resolution count

// Structural Constants Scaled 1:1 for a 16.7-Meter Airframe Scale (mm)
shield_total_length = 1480;              // Total longitudinal vertical height (mm)
shield_outer_width = 540;                // Transverse lower wing shell envelope width (mm)
armor_skin_thickness = 50;              // Solid TiAl protective plating wall (mm)
harness_conduit_width = 80;             // Cast-in 4oz copper logic trace track (mm)
capacitor_pocket_depth = 15;            // Sub-armor recessed housing pocket depth (mm)
capacitor_pocket_width = 140;           // Transverse MLCC array pocket width (mm)

module Runner_E_Lower_Wing_Forge() {
    // Central Supply Injection Runner Axis (Molten Feed Line from Siphon Forge)
    color([0.22, 0.22, 0.25]) {
        cylinder(h = shield_total_length * 1.5, d = 42, center = true);
        // Direct injection gates tracking straight into the part mold cavities
        translate() rotate() cylinder(h = 450, d = 22);
        translate([0, 300, -400]) rotate() cylinder(h = 450, d = 22);
    }
    
    // Instantiate Scaled NVIDIA-Faceted Part Molds Symmetrically (Left & Right)
    Cast_Outer_Lower_Wing_Shields();
}

module Cast_Outer_Lower_Wing_Shields() {
    // ---- PART E11: OUTER LEFT PROTECTIVE LOWER FLIGHT WING STABILIZER ---- [Page 19, Step 11-4]
    translate([-500, 0, 450]) color([0.85, 0.85, 0.9]) { // Classic White Armor Spec
        difference() {
            // Main weapon body extruded with complex faceted polygon profile
            // Replicates the sharp planar clean-breaks of modern high-performance GPU shrouds
            linear_extrude(height = shield_total_length * 0.45, center = true, scale = [0.8, 1.0])
                polygon(points = [, 
                    [shield_outer_width, 60], 
                    [shield_outer_width - 50, 25],   // 45-Degree Diamond Cut Bevel Step
                    [shield_outer_width, -60]
                ]);
            
            // Internal pocket excavation (Fits securely over the wing folding actuator linkages)
            cylinder(h = shield_total_length * 0.5, d = shield_outer_width - 40, center = true);
            
            // SUB-ARMOR CYLINDRICAL BARREL CAPACITOR BAYS [Segmented rows cut inside the armor inner wall]
            for (z_offset = [-200, 0, 200]) {
                translate([(shield_outer_width * 0.5 - armor_skin_thickness + capacitor_pocket_depth/2), 0, z_offset])
                    cube([capacitor_pocket_depth, capacitor_pocket_width, 100], center = true);
            }
            
            // Continuous cast-in routing track for the 4oz solid-state wiring rails
            cube([harness_conduit_width, shield_outer_width, shield_total_length], center = true);
            
            // Slicing profile tool to generate an asymmetrical half-shell part component
            translate([0, -shield_outer_width, 0])
                cube([shield_outer_width * 2, shield_outer_width * 2, shield_total_length * 2], center = true);
        }
    }
    
    // ---- PART E12: OUTER RIGHT PROTECTIVE LOWER FLIGHT WING STABILIZER ---- [Page 19, Step 11-4]
    translate([500, 0, -450]) rotate() color([0.85, 0.85, 0.9]) {
        difference() {
            linear_extrude(height = shield_total_length * 0.45, center = true, scale = [0.8, 1.0])
                polygon(points = [, [shield_outer_width, 80], [shield_outer_width - 50, 25], [shield_outer_width, -80]]);
            
            cylinder(h = shield_total_length * 0.5, d = shield_outer_width - 40, center = true);
            
            for (z_offset = [-200, 0, 200]) {
                translate([(shield_outer_width * 0.5 - armor_skin_thickness + capacitor_pocket_depth/2), 0, z_offset])
                    cube([capacitor_pocket_width, capacitor_pocket_depth, 100], center = true);
            }
            
            cube([harness_conduit_width, shield_outer_width, shield_total_length], center = true);
            translate([0, -shield_outer_width, 0])
                cube([shield_outer_width * 2, shield_outer_width * 2, shield_total_length * 2], center = true);
        }
    }
}

// Render Master Assembly to Parameter Workspace
Runner_E_Lower_Wing_Shield_Forge();
