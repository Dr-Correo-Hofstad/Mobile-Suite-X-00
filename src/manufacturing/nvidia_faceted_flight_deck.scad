// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - PILOT INTERFACE CORES
// MODULE: NVIDIA-FACETED FLIGHT DECK (NVIDIA_FACETED_FLIGHT_DECK.SCAD)
// DESIGN STYLE: NVIDIA FOUNDERS EDITION AGGRESSIVE PLANAR GEOMETRIC MESH
// ERGONOMICS PARITY: ADJUSTABLE HOTAS PLATFORMS & FLIP-UP KEYBOARD SLIDERS
// ============================================================================

$fn = 80; // High-precision rendering circular segment resolution count

// Structural Cockpit Constraints (1:1 Metric Airframe Scale - mm)
inner_diameter = 2310;                  // Orion clear internal ceiling diameter (mm)
chair_arm_thickness = 90;               // Heavy load-bearing structural yoke width (mm)
hotas_plate_width = 340;                // Peripherals mounting pad thickness (mm)
bolt_hole_diameter = 6;                 // Standard M6 industrial bolt sizing (mm)
bolt_grid_spacing = 20;                 // Mounting grid spacing interval (mm)

module Master_NVIDIA_Flight_Deck_Forge() {
    // 1. Render Symmetrical Left Structural Armature (Houses Keyboard Slider)
    translate([-600, 200, 0]) color([0.15, 0.15, 0.17]) { // Anodized Dark Metal Spec
        Build_Faceted_Armature_Left();
    }
    
    // 2. Render Symmetrical Right Structural Armature (Houses Pure HOTAS Plate)
    translate([600, 200, 0]) color([0.15, 0.15, 0.17]) {
        Build_Faceted_Armature_Right();
    }
}

module Build_Faceted_Armature_Left() {
    // Aggressive planar structural arm frame branching from the seat tracks
    difference() {
        // Main structural member built using geometric low-poly extrusion lines
        linear_extrude(height = 480, center = true, scale = [0.8, 0.9])
            polygon(points = [[0,0], [120,40], [180,-20], [240,120], [0,80]]);
        
        // Recessed slide track cutout for the flip-up keyboard mechanism
        translate([80, 20, 0])
            cube([30, 140, 500], center = true);
    }
    
    // Faceted Keyboard Tray Panel - Rendered in flipped-up, stowed configuration
    translate([100, 40, 150]) color([0.85, 0.85, 0.9]) { // Pure White High-Albedo Spec
        rotate([90, 0, 15])
            linear_extrude(height = 15, center = true, scale = [0.9, 0.95])
                polygon(points = [[0,0], [450,0], [410,280], [40,280]]);
    }
    
    // Upper HOTAS Mount Extension with Multi-Hole Bolt Matrix
    translate([200, 100, 240]) Build_Universal_Bolt_Matrix();
}

module Build_Faceted_Armature_Right() {
    // Symmetrical right-hand side outrigger yoke tracking the main bed frame
    linear_extrude(height = 480, center = true, scale = [0.8, 0.9])
        polygon(points = [[0,0], [-120,40], [-180,-20], [-240,120], [0,80]]);
        
    // Upper right-hand side HOTAS mounting yoke pad
    translate([-200, 100, 240]) Build_Universal_Bolt_Matrix();
}

module Build_Universal_Bolt_Matrix() {
    // Generates the universal multi-hole peripheral configuration plate
    color([0.25, 0.25, 0.28]) {
        difference() {
            // Main angular flat mounting pad face block
            cube([hotas_plate_width, hotas_plate_width, 35], center = true);
            
            // Universal Industrial Bolt Hole Matrix (Iterates array passes for M6 bolts)
            for (x_pos = [-hotas_plate_width/2 + 30 : bolt_grid_spacing : hotas_plate_width/2 - 30]) {
                for (y_pos = [-hotas_plate_width/2 + 30 : bolt_grid_spacing : hotas_plate_width/2 - 30]) {
                    translate([x_pos, y_pos, 0])
                        cylinder(h = 50, d = bolt_hole_diameter, center = true);
                }
            }
        }
    }
}

// Render Finished Mechanical Mesh Assembly to Workspace
Master_NVIDIA_Flight_Deck_Forge();
