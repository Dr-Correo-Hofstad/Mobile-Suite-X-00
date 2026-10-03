// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - COCKPIT INTERIOR LAYOUT
// MODULE: COCKPIT INTERNAL ARCHITECTURE (COCKPIT_INTERNAL_ARCHITECTURE.SCAD)
// DESIGN SPECS: ZONAL SEGREGATION BULKHEADS & UNIVERSAL ATX COMPUTE PEGBOARDS
// INTEGRATION PARITY: CROSS-DIAMOND DOUBLE-SPIRAL BACKBONE (1:1 SCALE)
// ============================================================================

$fn = 80; // Circular fragment rendering resolution count

// Structural Cockpit Constants (Enforcing 2,310 mm Inner Space Boundaries)
inner_diameter = 2310;                  // Clear internal cylinder diameter (mm)
inner_length = 2760;                    // Clear internal cabin length path (mm)
halfway_bulkhead_y = 0;                 // Centerline horizontal boundary splitting node
peg_hole_diameter = 4;                  // Universal micro-post hole sizing (mm)
peg_grid_spacing = 25;                  // Standardized 25mm spacing interval pattern

module Master_Cockpit_Interior_Forge() {
    // 1. Render the Structural Cross-Diamond Halfway Support Bulkhead
    color([0.45, 0.45, 0.48]) { // Deep Titanium Industrial Spec
        Build_Cross_Diamond_Spirals();
        Build_Dual_Chair_Tracks();
    }
    
    // 2. Render Upper Universal ATX Electronics Pegboard Walls
    color([0.3, 0.3, 0.32]) {
        Build_Upper_Universal_Pegboard();
    }
}

module Build_Cross_Diamond_Spirals() {
    // Generates the interlocking double-spiral titanium load-bearing trellis
    intersection() {
        cylinder(h = inner_length, d = inner_diameter, center = true);
        union() {
            // Forward Helical Spiral Spiral Splines
            for (step = [0 : 3]) {
                rotate([0, 0, step * 90])
                    linear_extrude(height = inner_length, center = true, twist = 360, slices = 100)
                        translate([inner_diameter/2 - 30, 0, 0]) square([60, 40], center = true);
            }
            // Reverse Interlocking Helical Spiral Splines (Forms the rigid diamond mesh)
            for (step = [0 : 3]) {
                rotate([0, 0, step * 90])
                    linear_extrude(height = inner_length, center = true, twist = -360, slices = 100)
                        translate([inner_diameter/2 - 30, 0, 0]) square([60, 40], center = true);
            }
        }
    }
}

module Build_Dual_Chair_Tracks() {
    // Dual tracking rails running continuously along the horizontal center line
    // Guides the transforming chair from the flat rear bulkhead all the way forward
    translate([0, -(inner_diameter/2 - 20), halfway_bulkhead_y])
        cube([inner_length, 40, 80], center = true);
    translate([0, (inner_diameter/2 - 20), halfway_bulkhead_y])
        cube([inner_length, 40, 80], center = true);
}

module Build_Upper_Universal_Pegboard() {
    // Generates a dense grid of holes across the upper hull side walls (Y > 0)
    // Circuit teams can mount full ATX down to micro/pi boards anywhere via posts
    difference() {
        // Upper half-shell containment backing plate panel
        intersection() {
            cylinder(h = inner_length * 0.95, d = inner_diameter - 10, center = true);
            translate([0, 0, inner_diameter/2]) 
                cube([inner_length, inner_diameter, inner_diameter], center = true);
        }
        
        // Universal Hole Matrix Punch (Iterates array tracking loops down the walls)
        for (z_pos = [-inner_length/2 + 100 : peg_grid_spacing : inner_length/2 - 100]) {
            for (angle = [15 : 5 : 165]) { // Restrained strictly to upper half of circle
                translate([z_pos, (inner_diameter/2 - 15) * cos(angle), (inner_diameter/2 - 15) * sin(angle)])
                    rotate([0, 90, angle])
                        cylinder(h = 60, d = peg_hole_diameter, center = true);
            }
        }
    }
}

// Render Master Component to Parameter Workspace
Master_Cockpit_Interior_Forge();
