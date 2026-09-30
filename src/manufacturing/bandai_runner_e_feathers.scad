// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - FLIGHT Surface EXTENSIONS
// COMPONENT VAULT: BANDAI CAST RUNNER E - TRAILING-EDGE SUB-FEATHERS 
// INTEGRATION PARITY: SOLID-STATE CONNECTOR MAPPING & VARIABLE PITCH CAMBERS
// REAL-WORLD REF: MASTER GRADE Ver.Ka MANUAL LAYOUTS (PAGES 9 & 11)
// ============================================================================

$fn = 60; // Optimized segment resolution for complex repetitive arrays

// Dimensional Parameters Scaled 1:1 for a 16.7-Meter Airframe (mm)
runner_backbone_diameter = 38;          // Central alloy casting runner shaft
feather_base_length = 1450;             // Primary structural extension length 
feather_thickness_wall = 15;            // Ultralight aerodynamic TiAl profile
harness_interlock_dim = 40;             // Solid-state connector coupling seat

module Runner_E_Feather_Forge() {
    // 1. Central Distribution Sprue (Feeds molten TiAl from Siphon Forge)
    color([0.3, 0.3, 0.35]) {
        cylinder(h = 3500, d = runner_backbone_diameter, center = true);
        
        // Horizontal injection gates mapping straight to parts seats
        for (z_offset = [-1000, -300, 400, 1100]) {
            translate([0, 0, z_offset]) rotate([0, 90, 0])
                cylinder(h = 450, d = runner_backbone_diameter * 0.6);
        }
    }
    
    // 2. Instantiate Cascading Feather Cavities (E10, E12, E14, E16)
    Cast_Cascading_Feather_Array();
}

module Cast_Cascading_Feather_Array() {
    // ---- PART E10: PROXIMAL UPPER COUPLING FEATHER ---- [Page 9, Step 11-1]
    translate([450, 0, 1100]) color([0.9, 0.9, 0.95]) {
        difference() {
            // Airfoil curved blade profile
            scale([1.0, 0.15, 1.0])
                cylinder(h = feather_base_length, r1 = 280, r2 = 90, center = true);
            // Embedded pocket for the solid-state harness coupling node
            translate([0, 0, -(feather_base_length/2 - 100)])
                cube([harness_interlock_dim, harness_interlock_dim, 80], center = true);
        }
    }
    
    // ---- PART E12: GRADUATED MID-WING TRANSVERSE FEATHER ---- [Page 9, Step 11-1]
    translate([450, 0, 400]) color([0.9, 0.9, 0.95]) {
        difference() {
            scale([1.0, 0.14, 1.0])
                cylinder(h = feather_base_length * 0.9, r1 = 260, r2 = 80, center = true);
            translate([0, 0, -(feather_base_length * 0.45 - 100)])
                cube([harness_interlock_dim, harness_interlock_dim, 80], center = true);
        }
    }

    // ---- PART E14: INNER FLIGHT BOUND DISTAL FEATHER ---- [Page 9, Step 11-2]
    translate([450, 0, -300]) color([0.9, 0.9, 0.95]) {
        difference() {
            scale([1.0, 0.13, 1.0])
                cylinder(h = feather_base_length * 0.8, r1 = 240, r2 = 70, center = true);
            translate([0, 0, -(feather_base_length * 0.4 - 100)])
                cube([harness_interlock_dim, harness_interlock_dim, 80], center = true);
        }
    }

    // ---- PART E16: STREAMLINED WING-TIP DEFLECTOR FEATHER ---- [Page 9, Step 11-2]
    translate([450, 0, -1000]) color([0.9, 0.9, 0.95]) {
        difference() {
            scale([1.0, 0.12, 1.0])
                cylinder(h = feather_base_length * 0.7, r1 = 220, r2 = 60, center = true);
            translate([0, 0, -(feather_base_length * 0.35 - 100)])
                cube([harness_interlock_dim, harness_interlock_dim, 80], center = true);
        }
    }
}

// Render Runner Matrix to Parametric Engineering Workspace
Runner_E_Feather_Forge();
