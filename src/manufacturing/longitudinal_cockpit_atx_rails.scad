// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - PILOT LIFE LINE INFRA
// COMPONENT: LONGITUDINAL ATX COMPUTATION MAINBOARD MOUNTING RAILS
// LAYOUT INTEGRATION: HORIZONTAL CONFIGURATION ABOVE CAPSULE MIDSECTION LINE
// CONFIG METRIC: SCALED PORCELAIN-ISOLATED PEGBOARD POSTS (1:1 ACTUAL METRIC)
// ============================================================================

$fn = 80; // High-precision circular resolution profile count

// Structural Capsule Constraints (mm Actual Metric Scale)
cylinder_id = 2310;                     // Orion clear internal diameter boundary (mm)
craft_segment_length = 1500;            // Length of modeled horizontal cockpit sector (mm)
atx_length = 305;                       // Standard ATX Motherboard vertical height specification (mm)
atx_width = 244;                        // Standard ATX Motherboard horizontal width specification (mm)
rail_protrusion = 40;                   // Distance rail extends from inner shell face (mm)
midsection_height_offset = 150;         // Vertical alignment height positioned above center line (mm)

module Cockpit_Horizontal_ATX_Rails() {
    // 1. Longitudinal Cross-Section of the Porcelain-Insulated Core Cylinder
    difference() {
        color([0.2, 0.2, 0.22]) rotate([90, 0, 0])
            cylinder(h = craft_segment_length, d = cylinder_id + 40, center = true);
        color([0.1, 0.1, 0.12]) rotate([90, 0, 0])
            cylinder(h = craft_segment_length + 10, d = cylinder_id, center = true);
        
        // Slice the cylinder model in half transversely to provide an open workstation view
        translate([0, cylinder_id/2, 0])
            cube([cylinder_id * 2, cylinder_id, craft_segment_length * 2], center = true);
    }

    // 2. LEFT HORIZONTAL MOUNTING RAIL (Positioned longitudinally above the left midsection line)
    color([0.3, 0.3, 0.35]) translate([-cylinder_id/2 + rail_protrusion/2, 0, midsection_height_offset])
        cube([rail_protrusion, craft_segment_length, 30], center = true);

    // 3. RIGHT HORIZONTAL MOUNTING RAIL (Positioned longitudinally above the right midsection line)
    color([0.3, 0.3, 0.35]) translate([cylinder_id/2 - rail_protrusion/2, 0, midsection_height_offset])
        cube([rail_protrusion, craft_segment_length, 30], center = true);

    // 4. ATX Mainboard Mounting Tab Arrays (Sliding side-by-side posts positioned along rails)
    for (board_offset = [-atx_width * 0.7, atx_width * 0.7]) {
        // Left Side-by-Side Tab Blocks Array
        color([0.75, 0.75, 0.8]) translate([-cylinder_id/2 + rail_protrusion + 10, board_offset, midsection_height_offset]) {
            // Main flat structural compute platform chassis adapter plate
            cube([10, atx_width, atx_length], center = true);
            
            // Replicated Porcelain Isolation Post Pegs (Four corners corner configuration anchors)
            for (x_peg = [-atx_width/2 + 15, atx_width/2 - 15]) {
                for (z_peg = [-atx_length/2 + 15, atx_length/2 - 15]) {
                    translate([5, x_peg, z_peg]) rotate([0, 90, 0])
                        color([0.95, 0.95, 1.0]) cylinder(h = 15, d = 12, center = true);
                }
            }
        }
        
        // Right Side-by-Side Tab Blocks Array
        color([0.75, 0.75, 0.8]) translate([cylinder_id/2 - rail_protrusion - 10, board_offset, midsection_height_offset]) {
            cube([10, atx_width, atx_length], center = true);
            
            for (x_peg = [-atx_width/2 + 15, atx_width/2 - 15]) {
                for (z_peg = [-atx_length/2 + 15, atx_length/2 - 15]) {
                    translate([-5, x_peg, z_peg]) rotate([0, 90, 0])
                        color([0.95, 0.95, 1.0]) cylinder(h = 15, d = 12, center = true);
                }
            }
        }
    }
}

// Render Master Instrumentation Assembly to Parameter Workspace Workspace
Cockpit_Horizontal_ATX_Rails();
