// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - COCKPIT COUPLER RETROFIT
// ARCHITECTURE BASELINE: MERCURY-REDSTONE ESCAPE & TRAJECTORY MODULE
// MANUFACTURING PARITY: SOLID-STATE INTEGRATED ELECTRICAL HARNESSING
// COMPATIBILITY: ELECTROACOUSTIC PROPULSION JUNCTIONS & PLASMA VORTEX CORES
// ============================================================================

$fn = 100; // Circular segment resolution count

// Dimensional Variables (1:1 Metrics for a 16.7-Meter Airframe Scale)
shaft_section_length = 3400;             // Total longitudinal forward module axis (mm)
modular_neck_diameter = 580;            // Inner structural shaft clearance width (mm)
titanium_armor_wall = 45;               // Zoned TiAl outer protective shielding (mm)
solid_state_bus_width = 80;             // 4oz Copper harness tracking track width (mm)
wave_driver_bore = 180;                 // Internal cymatics resonance chamber (mm)

module Runner_A_Redstone_Forge() {
    // Master Material Feed Runner (Feeds Molten Alloy from Siphon Forge)
    color([0.3, 0.3, 0.34]) {
        cylinder(h = shaft_section_length + 600, d = 40, center = true);
        // Direct feed gates tracking straight to the mold perimeters
        translate([0, 0, 1000]) rotate([0, 90, 0]) cylinder(h = 450, d = 20);
        translate([0, 0, -1000]) rotate([0, 90, 0]) cylinder(h = 450, d = 20);
    }
    
    // Instantiate Scaled Part Cavities
    Cast_Redstone_Trajectory_Components();
}

module Cast_Redstone_Trajectory_Components() {
    // ---- PART A17: FORWARD MODULAR SHAFT HULL (LEFT HALF-SHELL) ---- [From Page 9, Step 12]
    translate([450, 0, 600]) color([0.8, 0.8, 0.85]) {
        difference() {
            // Main cylindrical trajectory outer column casing
            cylinder(h = shaft_section_length * 0.45, d = modular_neck_diameter + (titanium_armor_wall * 2), center = true);
            // Internal cavity boring to minimize dead structural weight
            cylinder(h = shaft_section_length * 0.5, d = modular_neck_diameter, center = true);
            // Continuous cast-in groove for the 4oz copper logic rail harness
            cube([solid_state_bus_width, 800, shaft_section_length], center = true);
            // Slice mold profile to form an asymmetrical mating part
            translate([0, -modular_neck_diameter, 0])
                cube([modular_neck_diameter * 2, modular_neck_diameter * 2, shaft_section_length], center = true);
        }
    }
    
    // ---- PART A18: FORWARD MODULAR SHAFT HULL (RIGHT HALF-SHELL) ---- [From Page 9, Step 12]
    translate([450, 0, -600]) rotate([0, 180, 0]) color([0.8, 0.8, 0.85]) {
        difference() {
            cylinder(h = shaft_section_length * 0.45, d = modular_neck_diameter + (titanium_armor_wall * 2), center = true);
            cylinder(h = shaft_section_length * 0.5, d = modular_neck_diameter, center = true);
            cube([solid_state_bus_width, 800, shaft_section_length], center = true);
            translate([0, -modular_neck_diameter, 0])
                cube([modular_neck_diameter * 2, modular_neck_diameter * 2, shaft_section_length], center = true);
        }
    }

    // ---- PART A19: INTERNAL ELECTROACOUSTIC RESONANCE CHAMBER ---- [From Page 9, Step 12]
    translate([1200, 0, 0]) color([0.4, 0.4, 0.42]) {
        difference() {
            // High-pressure acoustic waveguide tuning pipe block
            cylinder(h = shaft_section_length * 0.35, d = modular_neck_diameter - 20, center = true);
            // Core wave driver chamber bore (Isolates gas during sound excitation loops)
            cylinder(h = shaft_section_length * 0.4, d = wave_driver_bore, center = true);
            // Transverse frequency calibration key slots for the tuning cartridges
            rotate([90, 0, 0])
                cylinder(h = 600, d = 75, center = true);
        }
    }
}

// Render Finished Module Workspace Framework
Runner_A_Redstone_Forge();
