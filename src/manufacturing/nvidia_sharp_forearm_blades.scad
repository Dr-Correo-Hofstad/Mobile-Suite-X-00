// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - MANIPULATOR VISUAL RETROFIT
// COMPONENT VAULT: BANDAI CAST RUNNER C - FACETED FOREARM BLADES C5 & C6
// DESIGN STYLE: NVIDIA FOUNDERS EDITION AGGRESSIVE PLANAR GEOMETRY MATRIX
// WEAPON SPEC: MOLECULAR RAZOR EDGE TAPERING (0.05mm LOW-POLY POINT PARITY)
// ============================================================================

$fn = 120; // High-fidelity circular resolution segment count

// Structural Constants Scaled 1:1 for a 16.7-Meter Airframe Scale (mm)
blade_total_length = 1450;               // Total vertical height of cutting blade (mm)
blade_base_width = 380;                 // Maximum width of base armor panel (mm)
armor_skin_thickness = 50;              // Solid TiAl protective base wall (mm)
harness_conduit_width = 80;             // Cast-in 4oz copper logic trace track (mm)
capacitor_pocket_depth = 15;            // Sub-armor recessed housing pocket depth (mm)
capacitor_pocket_width = 140;           // Transverse MLCC array pocket width (mm)

module Runner_C_NVIDIA_Blade_Forge() {
    // Central Supply Injection Runner Axis (Molten Feed Line from Siphon Forge)
    color([0.22, 0.22, 0.24]) {
        cylinder(h = blade_total_length * 1.5, d = 42, center = true);
        translate() rotate() cylinder(h = 450, d = 22);
        translate([0, 300, -400]) rotate() cylinder(h = 450, d = 22);
    }
    
    // Instantiate Scaled NVIDIA-Faceted Part Molds Symmetrically
    Cast_NVIDIA_Sharp_Blades();
}

module Cast_NVIDIA_Sharp_Blades() {
    // ---- PART C5: MODIFIED LEFT FACETED FOREARM BLADE SHIELD ----
    translate([-450, 0, 450]) color([0.2, 0.4, 0.8]) { // Cobalt Blue Accent Spec
        difference() {
            // Main weapon body extruded with complex faceted polygon profile
            // Replicates the sharp planar clean-breaks of modern high-performance GPU shrouds
            linear_extrude(height = blade_total_length * 0.45, center = true, scale = [0.75, 1.0])
                polygon(points = [, 
                    [blade_base_width, 80], 
                    [blade_base_width - 60, 40],   // 45-Degree Diamond Cut Bevel Step
                    [blade_base_width, -80], 
                    [0.05, 0]                       // 0.05mm low-poly razor convergence point
                ]);
            
            // SUB-ARMOR CYLINDRICAL BARREL CAPACITOR BAYS [Milled into the flat rear block face]
            for (z_offset = [-200, 0, 200]) {
                translate([(blade_base_width - armor_skin_thickness - 20), 0, z_offset])
                    cube([capacitor_pocket_depth, capacitor_pocket_width, 120], center = true);
            }
            
            // Continuous cast-in routing track for the 4oz solid-state wiring rails
            translate([blade_base_width - 40, 0, 0])
                cube([harness_conduit_width, 100, blade_total_length], center = true);
        }
    }
    
    // ---- PART C6: MODIFIED RIGHT FACETED FOREARM BLADE SHIELD ----
    translate([450, 0, -450]) rotate() color([0.2, 0.4, 0.8]) {
        difference() {
            linear_extrude(height = blade_total_length * 0.45, center = true, scale = [0.75, 1.0])
                polygon(points = [, [blade_base_width, 80], [blade_base_width - 60, 40], [blade_base_width, -80], [0.05, 0]]);
            
            for (z_offset = [-200, 0, 200]) {
                translate([(blade_base_width - armor_skin_thickness - 20), 0, z_offset])
                    cube([capacitor_pocket_depth, capacitor_pocket_width, 120], center = true);
            }
            
            translate([blade_base_width - 40, 0, 0])
                cube([harness_conduit_width, 100, blade_total_length], center = true);
        }
    }
}

// Render Master Assembly to Parameter Workspace
Runner_C_NVIDIA_Blade_Forge();
