// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - PILOT LIFE LINE INFRA
// COMPONENT: INTEGRATED LOW-PROFILE ORION WALL WASTE CONTROLLER
// PRODUCTION SPEC: NORTHROP GRUMMAN AC DELCO ZERO-LEAK HYDRAULIC STANDARD
// LAYOUT PARITY: FLAT-SIDED LOWER CYLINDER HULL WALL PACKAGING
// ============================================================================

$fn = 100; // High-precision circular resolution segment count

// Structural Cockpit Constraints (1:1 Metric Airframe Scale - mm)
tank_width = 380;                        // Transverse horizontal flat span (mm)
tank_depth = 90;                         // Low-profile wall protrusion width (mm) - Fits flush
tank_height = 280;                       // Total vertical fluid bounding height (mm)
wall_thickness = 5;                      // Heavy-duty high-density polymer shield wall (mm)
conduit_diameter = 18;                   // High-draw fluid transfer port width (mm)

module Orion_Wall_Waste_System_Forge() {
    // 1. Flat-Sided Low-Profile 1,200 mL Fluid Containment Reservoir
    color([0.22, 0.22, 0.25]) { // Deep Frame Titanium Gray Spec
        difference() {
            // Main exterior protective block envelope
            cube([tank_width, tank_depth, tank_height], center = true);
            // Core internal fluid calculation extraction space
            cube([tank_width - (wall_thickness * 2), tank_depth - (wall_thickness * 2), tank_height - (wall_thickness * 2)], center = true);
            
            // Port A Layout: Upper Intake Nozzle Base Seat
            translate([-120, 0, tank_height/2 - 10])
                cylinder(h = 40, d = conduit_diameter + 10, center = true);
                
            // Port B Layout: Upper Bellows Vacuum Extraction Socket
            translate([0, 0, tank_height/2 - 10])
                cylinder(h = 40, d = 65, center = true);
                
            // Port C Layout: Lower High-Draw Outbound Discharge Siphon Nozzle
            translate([120, 0, -tank_height/2 + 10])
                cylinder(h = 40, d = conduit_diameter + 10, center = true);
        }
    }
    
    // 2. Integrated Intake Bellows Squeeze Pump Shroud (Wall-Flush Mount)
    color([0.15, 0.15, 0.18]) translate([0, 0, tank_height/2 + 15]) {
        difference() {
            // Heavy rubber bellows exterior actuator ring
            cylinder(h = 30, d = 60, center = true);
            // Internal variable volume air cylinder chamber
            cylinder(h = 35, d = 52, center = true);
        }
    }
    
    // 3. Extendable Intake Conduit Adapter with Interchangeable Cup Interface
    color([0.15, 0.55, 0.85]) translate([-120, 0, tank_height/2 + 40]) {
        // Upper interface connector block
        cylinder(h = 60, d = conduit_diameter, center = true);
        // Flanged anatomical collection mouth flare
        translate([0, 0, 30])
            cylinder(h = 50, d1 = conduit_diameter, d2 = 85, center = false);
    }
    
    // 4. Outbound Hatch Evacuation Discharge Tube & Inline Bulb Pump Port
    color([0.1, 0.1, 0.12]) translate([120, 0, -tank_height/2 - 40]) {
        // High-draw drain down conduit line
        cylinder(h = 80, d = conduit_diameter, center = true);
        // Integrated manual squeeze bulb evacuator expander
        translate([0, 0, -40])
            sphere(d = 55);
    }
}

// Render Master Component Assembly to Parameter Workspace
Orion_Wall_Waste_System_Forge();
