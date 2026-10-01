// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - HEAD COMPLIANCE MATRIX
// COMPONENT VAULT: BANDAI CAST RUNNER A - SHADING SLEEVES A7 & VISOR MASKS A8
// ARCHITECTURAL PARITY: GUNDAM SENTINEL DEVELOPMENT DIARY SPECIFICATIONS
// DESIGN METRIC: MASS PROFILE PRE-LOCK FOR CORE DYNAMIC REBALANCING
// ============================================================================

$fn = 80; // Circular segment fidelity calculation count

// Sizing Constants Scaled 1:1 for a 16.7-Meter Airframe Scale (mm)
shading_cowl_height = 450;              // Total vertical tracking span (mm)
sensor_aperture_diameter = 220;         // Inner optical camera opening width (mm)
shading_wall_thickness = 20;            // Lightweight internal titanium shield (mm)
harness_conduit_width = 40;             // Cast-in 4oz copper logic rail track (mm)

module Runner_A_Head_Shading_Forge() {
    // Central Supply Injection Runner Axis (Molten Feed Line from Siphon Forge)
    color([0.22, 0.22, 0.25]) {
        cylinder(h = shading_cowl_height * 2.5, d = 35, center = true);
        // Direct injection gates tracking straight into the part mold cavities
        translate() rotate() cylinder(h = 350, d = 18);
        translate([0, 0, -350]) rotate() cylinder(h = 350, d = 18);
    }
    
    // Instantiate Scaled Structural Molds Symmetrically (Left & Right Halves)
    Cast_Internal_Sensor_Shading();
}

module Cast_Internal_Sensor_Shading() {
    // ---- PART A7: LEFT INTERNAL HEAD CAMERA SHADING SLEEVE ---- [Page 124 Diary Specs]
    translate([-250, 0, 350]) color([0.3, 0.3, 0.32]) { // Inner Frame Dark Spec
        difference() {
            // Main cylindrical glare protection cowling block
            cylinder(h = shading_cowl_height * 0.45, d = sensor_aperture_diameter + (shading_wall_thickness * 2), center = true);
            
            // Central Optical Path Boring (Clears targeted tracking vision)
            cylinder(h = shading_cowl_height * 0.5, d = sensor_aperture_diameter, center = true);
            
            // Continuous cast-in routing track for the 4oz solid-state wiring rails
            cube([harness_conduit_width, sensor_aperture_diameter + 50, shading_cowl_height], center = true);
            
            // Slicing profile tool to generate an asymmetrical half-shell part component
            translate([sensor_aperture_diameter, 0, 0])
                cube([sensor_aperture_diameter * 2, sensor_aperture_diameter * 2, shading_cowl_height * 2], center = true);
        }
    }
    
    // ---- PART A8: RIGHT INTERNAL HEAD CAMERA SHADING SLEEVE ---- [Page 124 Diary Specs]
    translate([250, 0, -350]) rotate() color([0.3, 0.3, 0.32]) {
        difference() {
            cylinder(h = shading_cowl_height * 0.45, d = sensor_aperture_diameter + (shading_wall_thickness * 2), center = true);
            cylinder(h = shading_cowl_height * 0.5, d = sensor_aperture_diameter, center = true);
            cube([harness_conduit_width, sensor_aperture_diameter + 50, shading_cowl_height], center = true);
            translate([sensor_aperture_diameter, 0, 0])
                cube([sensor_aperture_diameter * 2, sensor_aperture_diameter * 2, shading_cowl_height * 2], center = true);
        }
    }
}

// Render Finished Module Workspace Framework
Runner_A_Head_Shading_Forge();
