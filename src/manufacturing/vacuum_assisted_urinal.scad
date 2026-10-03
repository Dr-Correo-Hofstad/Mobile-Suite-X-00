// ============================================================================
// PROJECT: BIO-WASTE INFRASTRUCTURE & FLUID DYNAMICS VAULT
// COMPONENT: VACUUM-ASSISTED RESERVOIR TANK & EXTRACTION INTERFACE
// ARCHITECTURE SPEC: LEAK-FREE MANUAL GRADIENT VACUUM PUMP MANIFOLD
// ============================================================================

$fn = 80; // High-precision circular resolution profile count

// Design Variables (mm Actual Metric Scale)
tank_height = 240;                       // Vertical height of reservoir (mm)
tank_diameter = 140;                     // Total outer diameter of reservoir (mm)
wall_thickness = 5;                      // Heavy-walled high-density polymer wall (mm)
tube_port_diameter = 18;                 // Extraction conduit suction inlet width (mm)
cup_diameter_female = 90;                // Ergonomic female interface cup width (mm)

module Vacuum_Urinal_Assembly() {
    // 1. Primary Closed Fluid Containment Reservoir
    color([0.9, 0.9, 0.95]) {
        difference() {
            // Main tank body casting
            cylinder(h = tank_height, d = tank_diameter, center = true);
            // Core internal liquid capacity excavation
            cylinder(h = tank_height - (wall_thickness * 2), d = tank_diameter - (wall_thickness * 2), center = true);
            
            // Upper screw threads boundary cutout for the pump cap manifold
            translate([0, 0, tank_height/2 - 10])
                cylinder(h = 30, d = tank_diameter + 5, center = true);
        }
    }
    
    // 2. High-Pressure Vacuum Cap Manifold with Integrated Hand Pump Mounting Ring
    color([0.2, 0.2, 0.25]) translate([0, 0, tank_height/2 + 5]) {
        difference() {
            // Solid manifold seal block
            cylinder(h = 30, d = tank_diameter - 2, center = true);
            
            // Port A: Manual diaphragm hand pump air evacuation channel
            translate([-30, 0, 0]) cylinder(h = 40, d = 12, center = true);
            
            // Port B: High-draw linear tube extraction intake nozzle
            translate([30, 0, 0]) cylinder(h = 40, d = tube_port_diameter, center = true);
        }
    }
    
    // 3. Interchangeable Anatomical Collection Cup Component Layout
    color([0.15, 0.55, 0.85]) translate([tank_diameter + 60, 0, -tank_height/2 + 50]) {
        difference() {
            // Flanged outer defensive vacuum cup envelope
            cylinder(h = 100, d1 = tube_port_diameter, d2 = cup_diameter_female, center = false);
            // Contoured inner collection funnel excavation
            translate([0, 0, wall_thickness])
                cylinder(h = 105, d1 = tube_port_diameter - 4, d2 = cup_diameter_female - (wall_thickness * 2), center = false);
        }
    }
}

// Instantiate complete component footprint to design chamber space
Vacuum_Urinal_Assembly();
