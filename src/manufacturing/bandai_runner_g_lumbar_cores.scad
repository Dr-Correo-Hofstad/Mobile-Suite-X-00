// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - TORSO INNER BACKBONE INFRA
// COMPONENT VAULT: BANDAI CAST RUNNER G - LUMBAR CORES G13 & G14
// PACKAGING RE-ARCHITECTURE: SUB-ARMOR CAPACITOR RECESSED BANK INTEGRATION
// DESIGN STYLE: NVIDIA FOUNDERS EDITION AGGRESSIVE PLANAR GEOMETRY MATRIX
// CONFIG METRIC: SCALED TITANIUM CASTS WITH GYRO CAVITIES (1:1 ACTUAL METRIC)
// ============================================================================

$fn = 100; // High-precision circular resolution segment count

// Structural Constraints Scaled 1:1 for a 16.7-Meter Airframe Scale (mm)
spine_total_length = 960;                // Total longitudinal vertical spine height (mm)
gyro_cavity_diameter = 320;              // Internal gyroscopic stabilization core width (mm)
armor_skin_thickness = 65;              // Solid TiAl protective plating wall (mm)
harness_conduit_width = 80;             // Cast-in 4oz copper logic trace track (mm)
capacitor_pocket_depth = 15;            // Sub-armor recessed housing pocket depth (mm)
capacitor_pocket_width = 140;           // Transverse MLCC array pocket width (mm)

module Runner_G_Lumbar_Core_Forge() {
    // Central Supply Injection Runner Axis (Molten Feed Line from Siphon Forge)
    color([0.22, 0.22, 0.25]) {
        cylinder(h = spine_total_length * 1.5, d = 42, center = true);
        // Direct injection gates tracking straight into the part mold cavities
        translate() rotate() cylinder(h = 450, d = 22);
        translate([0, -300, -400]) rotate() cylinder(h = 450, d = 22);
    }
    
    // Instantiate Scaled Skeutomorphic Part Molds Symmetrically (Left & Right)
    Cast_Internal_Lumbar_Cores();
}

module Cast_Internal_Lumbar_Cores() {
    // ---- PART G13: INTERNAL LEFT LOWER LUMBAR SPINE LINKAGE CORE ----
    translate([-380, 0, 350]) color([0.35, 0.35, 0.38]) { // Inner Frame Dark Spec
        difference() {
            // Main solid heavy-duty interlocking spinal vertebrae structure block
            cube([460, 320, spine_total_length * 0.45], center = true);
            
            // INTERNAL GYROSCOPIC CORE CAVITY [Bored out for snap-circuit gyro alignment]
            cylinder(h = spine_total_length * 0.5, d = gyro_cavity_diameter, center = true);
            
            // SUB-ARMOR RECESSED CAPACITOR POCKETS [Segmented rows cut inside the vertebrae walls]
            for (z_offset = [-120, 0, 120]) {
                translate([(460/2 - armor_skin_thickness + capacitor_pocket_depth/2), 0, z_offset])
                    cube([capacitor_pocket_depth, capacitor_pocket_width, 80], center = true);
            }
            
            // Continuous cast-in routing track for the 4oz solid-state wiring rails
            cube([harness_conduit_width, 340, spine_total_length], center = true);
            
            // Slicing profile tool to generate an asymmetrical half-shell part component
            translate()
                cube([460, 400, spine_total_length * 2], center = true);
        }
    }
    
    // ---- PART G14: INTERNAL RIGHT LOWER LUMBAR SPINE LINKAGE CORE ----
    translate([380, 0, -350]) rotate() color([0.35, 0.35, 0.38]) {
        difference() {
            cube([460, 320, spine_total_length * 0.45], center = true);
            cylinder(h = spine_total_length * 0.5, d = gyro_cavity_diameter, center = true);
            
            for (z_offset = [-120, 0, 120]) {
                translate([(460/2 - armor_skin_thickness + capacitor_pocket_depth/2), 0, z_offset])
                    cube([capacitor_pocket_depth, capacitor_pocket_width, 80], center = true);
            }
            
            cube([harness_conduit_width, 340, spine_total_length], center = true);
            translate()
                cube([460, 400, spine_total_length * 2], center = true);
        }
    }
}

// Render Master Assembly to Parameter Workspace
Runner_G_Lumbar_Core_Forge();
