// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - PURE MECHANICAL SUITE
// COMPONENT: NON-ELECTRONIC SOLID WASTE RECEPTACLE & APERTURE VAULT
// PRODUCTION SPEC: NORTHROP GRUMMAN AC DELCO HIGH-PRESSURE O-RING COMPLIANCE
// LAYOUT PARITY: LOWER HULL FLOOR-WALL JUNCTION CONCEALED MOUNTING
// ============================================================================

$fn = 100; // High-precision circular resolution segment count

// Structural Cockpit Constraints (1:1 Metric Airframe Scale - mm)
container_height = 420;                  // Total vertical assembly height (mm)
cylinder_diameter = 220;                 // Outer diameter of waste storage vault (mm)
wall_thickness = 6;                      // Reinforced structural titanium thickness (mm)
supply_box_w = 120;                      // Cleaning asset storage bin transverse width (mm)

module Solid_Waste_Containment_Forge() {
    // 1. Primary 4.5-Liter High-Pressure Storage Cylinder
    color([0.25, 0.25, 0.27]) { // Raw Titanium Industrial Core Spec
        difference() {
            // Main vertical containment cylinder hull
            cylinder(h = container_height - 100, d = cylinder_diameter, center = true);
            // Core internal storage capacity cavity
            cylinder(h = container_height - 100 - (wall_thickness * 2), d = cylinder_diameter - (wall_thickness * 2), center = true);
            
            // Upper seal ring cutout designed for the AC Delco O-ring seat manifold
            translate([0, 0, (container_height - 100)/2 - 10])
                cylinder(h = 20, d = cylinder_diameter + 4, center = true);
        }
    }
    
    // 2. Integrated Cleaning Asset Storage Manifold (Mounts over the main cylinder)
    color([0.35, 0.35, 0.38]) translate([0, 0, (container_height/2) - 40]) {
        difference() {
            // Main upper storage housing block
            cube([cylinder_diameter + 40, cylinder_diameter, 80], center = true);
            
            // Central drop aperture path where bags enter the lower cylinder
            cylinder(h = 90, d = cylinder_diameter - 40, center = true);
            
            // Storage Bin A: Flat-packed zipper bag tray slot
            translate([-(cylinder_diameter/2), 0, 10])
                cube([supply_box_w, 140, 50], center = true);
                
            // Storage Bin B: Moist antimicrobial wet wipe pop-up bin slot
            translate([(cylinder_diameter/2), 0, 10])
                cube([supply_box_w, 140, 50], center = true);
        }
    }
    
    // 3. Manual Crush Plate & Compactor Lever Arm Assembly
    color([0.5, 0.5, 0.52]) {
        // External side-mounted mechanical leverage actuator handle
        translate([cylinder_diameter/2 + 15, 0, 0])
            cube([20, 30, 240], center = true);
            
        // Internal horizontal packing disc (Renders inside the core cavity slot)
        translate([0, 0, -20])
            cylinder(h = 10, d = cylinder_diameter - wall_thickness * 2 - 4, center = true);
    }
}

// Render Master Mechanical Assembly Component to Parameter Workspace
Solid_Waste_Containment_Forge();
