// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - PILOT LIFE LINE INFRA
// COMPONENT: TRACK-GUIDED COCKPIT LAPTOP TRAY ARMS
// LAYOUT INTEGRATION: CROSSING FIBONACCI SPIRAL STRUCTURAL WALL RAILS
// ARCHITECTURE SPEC: ZERO SOFTWARE - MANUAL CLUTCH Post INTEGRATION
// CONFIG METRIC: SCALED TITANIUM CANTILEVERS (1:1 ACTUAL METRIC SCALE)
// ============================================================================

$fn = 80; // High-precision circular resolution profile count

// Rigid Cockpit & Tray Constants (mm Actual Scale)
inner_diameter = 2310;                  // Orion clear internal diameter boundary (mm)
tray_width = 340;                       // Laptop platform horizontal width (mm)
tray_depth = 260;                       // Laptop platform horizontal depth (mm)
link_thickness = 45;                    // Solid TiAl structural link plating thickness (mm)
arm_extension = 400;                    // Longitudinal length of each scissor linkage segment (mm)

module Spiral_Track_Laptop_Arm_Assembly() {
    // 1. Represent Segment of the Hull's Structural Crossing Spiral Rails
    color([0.3, 0.3, 0.35]) translate([-inner_diameter/2 + 30, 0, 0]) {
        difference() {
            // Curving structural wall rib track
            cube([60, 800, 100], center = true);
            // Internal sliding T-slot track channel
            cube([40, 810, 40], center = true);
        }
    }
    
    // 2. Track Carriage Slider with Integrated Manual Friction Lock Lever
    color([0.5, 0.5, 0.55]) translate([-inner_diameter/2 + 65, 0, 0]) {
        // Main carriage block riding inside the T-slot
        cube([50, 90, 80], center = true);
        // Manual mechanical lockdown handle
        translate([15, 0, 50]) rotate([45, 0, 0])
            cube([15, 20, 70], center = true);
    }
    
    // 3. Dual-Stage Interlocking Cantilever Linkages (Extended forward from wall)
    color([0.4, 0.4, 0.42]) translate([-inner_diameter/2 + 260, 0, 0]) {
        // Linkage Segment 1: Primary Extension Arm
        translate([-arm_extension/2, 0, 20])
            cube([arm_extension, link_thickness, link_thickness], center = true);
            
        -- Friction Disk Mechanical Rotation Pivot Joiner
        translate([arm_extension/2 - 20, 0, 20])
            cylinder(h = 60, d = 65, center = true);
            
        -- Linkage Segment 2: Secondary Articulation Arm
        translate([0, arm_extension/2 - 40, -20]) rotate([0, 0, 90])
            cube([arm_extension, link_thickness, link_thickness], center = true);
    }
    
    // 4. Spring-Loaded Clamping Laptop Platform Tray
    color([0.2, 0.2, 0.22]) translate([-inner_diameter/2 + 480, arm_extension - 40, -20]) {
        // Main flat support plate
        cube([tray_width, tray_depth, 15], center = true);
        
        // Padded Side Slider Clamps (Left Retention Boundary Edge)
        translate([-white_space_offset, 0, 15])
            cube([20, 80, 30], center = true);
            
        // Padded Side Slider Clamps (Right Retention Boundary Edge)
        translate([tray_width/2 - 10, 0, 15])
            cube([20, 80, 30], center = true);
    }
}

// Render Master Component Assembly to Parameter Workspace
if ($preview) {
    Spiral_Track_Laptop_Arm_Assembly();
}
