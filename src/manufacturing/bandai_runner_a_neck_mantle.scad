// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - AIRFRAME VISUAL OVERHAUL
// COMPONENT VAULT: BANDAI CAST RUNNER A - HYBRID NECK SHIKORO A17 & A18
// DESIGN STYLE: NVIDIA FOUNDERS EDITION AGGRESSIVE PLANAR GEOMETRIC MESH
// DEFENSE SPEC: SAMURAI-VADER HYBRID FLARING CERVICAL PLATING
// ============================================================================

$fn = 100; // High-precision circular segment resolution count

// Structural Constants Scaled 1:1 for a 16.7-Meter Airframe Scale (mm)
mantle_total_length = 620;               // Total longitudinal vertical depth (mm)
mantle_outer_diameter = 860;             // Flaring sweep bounding width (mm)
armor_skin_thickness = 50;              // Solid TiAl protective plating wall (mm)
harness_conduit_width = 80;             // Cast-in 4oz copper logic trace track (mm)
capacitor_pocket_depth = 15;            // Sub-armor recessed housing pocket depth (mm)
capacitor_pocket_width = 140;           // Transverse MLCC array pocket width (mm)

module Runner_A_Neck_Mantle_Forge() {
    // Central Supply Injection Runner Axis (Molten Feed Line from Siphon Forge)
    color([0.22, 0.22, 0.25]) {
        cylinder(h = mantle_total_length * 1.8, d = 42, center = true);
        // Direct injection gates tracking straight into the part mold cavities
        translate() rotate() cylinder(h = 350, d = 22);
        translate([0, 250, -300]) rotate() cylinder(h = 350, d = 22);
    }
    
    // Instantiate Scaled NVIDIA-Faceted Neck Mantes Symmetrically (Left & Right)
    Cast_Faceted_Neck_Shikoro();
}

module Cast_Faceted_Neck_Shikoro() {
    // ---- PART A17: LEFT HALF FACETED SAMURAI-VADER NECK SHROUD ----
    translate([-400, 0, 300]) color([0.2, 0.2, 0.22]) { // Shadow Black Plating Spec
        difference() {
            // Main shroud member extruded with an aggressive faceted polygon profile
            // Replicates the sharp planar breaks and flaring mantle lines of a hybrid helmet
            linear_extrude(height = mantle_total_length * 0.45, center = true, scale = [1.2, 1.3])
                polygon(points = [, 
                    [mantle_outer_diameter * 0.5, 90], 
                    [mantle_outer_diameter * 0.4, 45],   // 45-Degree Diamond Cut Bevel Step
                    [mantle_outer_diameter * 0.5, -90]
                ]);
            
            // Core internal channel excavation (Fits securely over the central neck guides frame)
            cylinder(h = mantle_total_length, d = mantle_outer_diameter * 0.4, center = true);
            
            // SUB-ARMOR CYLINDRICAL BARREL CAPACITOR BAYS [Milled inside the flared rear wall]
            for (z_offset = [-100, 0, 100]) {
                translate([(mantle_outer_diameter * 0.25 - armor_skin_thickness + capacitor_pocket_depth/2), 0, z_offset])
                    cube([capacitor_pocket_depth, capacitor_pocket_width, 80], center = true);
            }
            
            // Continuous cast-in routing track for the 4oz solid-state wiring rails
            cube([harness_conduit_width, mantle_outer_diameter, mantle_total_length], center = true);
            
            // Slicing profile tool to generate an asymmetrical half-shell part component
            translate([0, -mantle_outer_diameter, 0])
                cube([mantle_outer_diameter * 2, mantle_outer_diameter * 2, mantle_total_length * 2], center = true);
        }
    }
    
    // ---- PART A18: RIGHT HALF FACETED SAMURAI-VADER NECK SHROUD ----
    translate([400, 0, -300]) rotate() color([0.2, 0.2, 0.22]) {
        difference() {
            linear_extrude(height = mantle_total_length * 0.45, center = true, scale = [1.2, 1.3])
                polygon(points = [, [mantle_outer_diameter * 0.5, 90], [mantle_outer_width * 0.4, 45], [mantle_outer_diameter * 0.5, -90]]);
            
            cylinder(h = mantle_total_length, d = mantle_outer_diameter * 0.4, center = true);
            
            for (z_offset = [-100, 0, 100]) {
                translate([(mantle_outer_diameter * 0.25 - armor_skin_thickness + capacitor_pocket_depth/2), 0, z_offset])
                    cube([capacitor_pocket_width, capacitor_pocket_depth, 80], center = true);
            }
            
            cube([harness_conduit_width, mantle_outer_diameter, mantle_total_length], center = true);
            translate([0, -mantle_outer_diameter, 0])
                cube([mantle_outer_diameter * 2, mantle_outer_diameter * 2, mantle_total_length * 2], center = true);
        }
    }
}

// Render Master Component to Parameter Workspace
Runner_A_Neck_Mantle_Forge();
