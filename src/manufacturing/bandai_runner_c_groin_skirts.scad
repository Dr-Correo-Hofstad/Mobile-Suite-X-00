// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - LOWER AIRFRAME PROTECTION
// COMPONENT VAULT: BANDAI CAST RUNNER C - GROIN SKIRTS C13 & C14
// PACKAGING RE-ARCHITECTURE: SUB-ARMOR CAPACITOR RECESSED BANK INTEGRATION
// DESIGN STYLE: NVIDIA FOUNDERS EDITION AGGRESSIVE PLANAR GEOMETRIC MATRIX
// CONFIG METRIC: SCALED TITANIUM CASTS (1:1 ACTUAL METRIC UP-SCALE)
// ============================================================================

$fn = 100; // Circular segment rendering resolution count

// Structural Constants Scaled 1:1 for a 16.7-Meter Airframe Scale (mm)
skirt_total_length = 1150;               // Total longitudinal vertical height (mm)
skirt_outer_width = 720;                // Transverse pelvic armor shell width (mm)
armor_skin_thickness = 50;              // Solid TiAl protective plating wall (mm)
harness_conduit_width = 80;             // Cast-in 4oz copper logic trace track (mm)
capacitor_pocket_depth = 15;            // Sub-armor recessed housing pocket depth (mm)
capacitor_pocket_width = 140;           // Transverse MLCC array pocket width (mm)

module Runner_C_Groin_Skirt_Forge() {
    // Central Supply Injection Runner Axis (Molten Feed Line from Siphon Forge)
    color([0.22, 0.22, 0.24]) {
        cylinder(h = skirt_total_length * 1.5, d = 42, center = true);
        // Direct injection gates tracking straight into the part mold cavities
        translate() rotate() cylinder(h = 450, d = 22);
        translate([0, 300, -400]) rotate() cylinder(h = 450, d = 22);
    }
    
    // Instantiate Scaled NVIDIA-Faceted Part Molds Symmetrically (Left & Right)
    Cast_Outer_Groin_Skirts();
}

module Cast_Outer_Groin_Skirts() {
    // ---- PART C13: OUTER LEFT PROTECTIVE FRONT GROIN SKIRT PLATE ---- [Page 18, Step 09-2]
    translate([-350, 0, 350]) color([0.2, 0.4, 0.8]) { // Cobalt Blue Accent Spec
        difference() {
            // Main weapon body extruded with complex faceted polygon profile
            // Replicates the sharp planar clean-breaks of modern high-performance GPU shrouds
            linear_extrude(height = skirt_total_length * 0.45, center = true, scale = [0.8, 1.0])
                polygon(points = [, 
                    [skirt_outer_width, 60], 
                    [skirt_outer_width - 50, 25],   -- 45-Degree Diamond Cut Bevel Step
                    [skirt_outer_width, -60]
                ]);
            
            // Core structural cutout for internal mechanical stabilization hinge alignment
            cylinder(h = skirt_total_length, d = skirt_outer_width * 0.4, center = true);
            
            // SUB-ARMOR RECESSED CAPACITOR POCKETS [Segmented rows cut inside the armor inner wall]
            for (z_offset = [-150, 0, 150]) {
                translate([(skirt_outer_width * 0.5 - armor_skin_thickness + capacitor_pocket_depth/2), 0, z_offset])
                    cube([capacitor_pocket_depth, capacitor_pocket_width, 100], center = true);
            }
            
            // Continuous cast-in routing track for the 4oz solid-state wiring rails
            cube([harness_conduit_width, skirt_outer_width, skirt_total_length], center = true);
            
            // Slicing profile tool to generate an asymmetrical half-shell part component
            translate([0, -skirt_outer_width, 0])
                cube([skirt_outer_width * 2, skirt_outer_width * 2, skirt_total_length * 2], center = true);
        }
    }
    
    // ---- PART C14: OUTER RIGHT PROTECTIVE FRONT GROIN SKIRT PLATE ---- [Page 18, Step 09-2]
    translate([350, 0, -350]) rotate() color([0.2, 0.4, 0.8]) {
        difference() {
            linear_extrude(height = skirt_total_length * 0.45, center = true, scale = [0.8, 1.0])
                polygon(points = [[0, 0], [skirt_outer_width, 60], [skirt_outer_width - 50, 25], [skirt_outer_width, -60]]);
            
            cylinder(h = skirt_total_length, d = skirt_outer_width * 0.4, center = true);
            
            for (z_offset = [-150, 0, 150]) {
                translate([(skirt_outer_width * 0.5 - armor_skin_thickness + capacitor_pocket_depth/2), 0, z_offset])
                    cube([capacitor_pocket_depth, capacitor_pocket_width, 100], center = true);
            }
            
            cube([harness_conduit_width, skirt_outer_width, skirt_total_length], center = true);
            translate([0, -skirt_outer_width, 0])
                cube([skirt_outer_width * 2, skirt_outer_width * 2, skirt_total_length * 2], center = true);
        }
    }
}

// Render Master Assembly to Parameter Workspace
Runner_C_Groin_Skirt_Forge();
