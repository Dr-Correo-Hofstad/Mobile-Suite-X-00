// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - PURE MECHANICAL SUITE
// COMPONENT: ELECTRONIC-FREE ORION LOW-PROFILE CONTAINER & INSERTION CUPS
// ARCHITECTURE SPEC: ZERO SOFTWARE - MANUAL VACUUM PRESSURE ENCLOSURE
// CONFIG METRIC: HIGH-DENSITY CAST-IN SOLID CORINGS (1:1 ACTUAL METRIC SCALE)
// ============================================================================

$fn = 100; // High-precision circular resolution segment count

// Rigid Fluid Dimensions (mm Actual Scale)
tank_width = 380;                        // Horizontal flat span across the wall panel (mm)
tank_depth = 90;                         // Flush low-profile wall depth footprint (mm)
tank_height = 280;                       // Total structural reservoir vertical height (mm)
wall_thickness = 6;                      // Reinforced polymer non-conductive armor face (mm)
conduit_diameter = 18;                   // Intake and drain fluid nozzle diameter (mm)

module Pure_Mechanical_Waste_System() {
    // 1. Heavy-Duty 1,200 mL Non-Electronic Fluid Reservoir
    color([0.25, 0.25, 0.27]) { // Raw Titanium Industrial Core Spec
        difference() {
            // Main solid exterior envelope block
            cube([tank_width, tank_depth, tank_height], center = true);
            
            // Internal fluid containment capacity volume cavity
            cube([tank_width - (wall_thickness * 2), tank_depth - (wall_thickness * 2), tank_height - (wall_thickness * 2)], center = true);
            
            // Port A Layout: Upper mechanical suction intake nozzle seat
            translate([-120, 0, tank_height/2 - 12])
                cylinder(h = 45, d = conduit_diameter + 8, center = true);
                
            // Port B Layout: Upper manual air-evacuation bellows adapter ring
            translate([0, 0, tank_height/2 - 12])
                cylinder(h = 45, d = 60, center = true);
                
            // Port C Layout: Lower gravity outbound drain down nozzle seat
            translate([120, 0, -tank_height/2 + 12])
                cylinder(h = 45, d = conduit_diameter + 8, center = true);
        }
    }
    
    // 2. Extended Female Nozzle Intra-Introitus Insertion Cup (No telemetry slots)
    translate([-240, 0, -50]) color([0.8, 0.8, 0.85]) { // Opaque Pliable Silicone
        difference() {
            union() {
                // Wide flanged anatomical contact cup body
                cylinder(h = 50, d1 = conduit_diameter, d2 = 90, center = false);
                // Soft 25 mm intra-cup extension suction guide nozzle tip
                translate([0, 0, 50])
                    cylinder(h = 25, d = conduit_diameter, center = false);
            }
            // Continuous internal fluid flow lumen channel
            cylinder(h = 80, d = 12, center = false);
            // Lower seat pocket designed for mechanical spring check valve insertion
            translate([0, 0, 5])
                cylinder(h = 12, d = conduit_diameter - 2, center = true);
        }
    }
}

// Render Master Mechanical Assembly Component to Parameter Workspace
Pure_Mechanical_Waste_System();
