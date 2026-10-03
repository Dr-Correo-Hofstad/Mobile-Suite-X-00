// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - PHYSICAL PROPULSION CORE
// MODULE SOURCE: GUNDAM-ROBOTICS-SYSTEMS / REGEN-SHOCKS & GM-EV-POWERTRAIN
// MANUFACTURING SPEC: INTEGRATED DRIVE CASINGS FOR 1:1 METRIC AIRFRAME
// ENGINEERING SPECS: RESISTOR-FREE KICKSTART CAPACITOR RETROFIT CHANNELS
// ============================================================================

$fn = 120; // High-precision rendering circular resolution segment count

// Global Mechanical Constraints (1:1 Metrics for 16.7m Airframe Scale)
piston_casing_height = 1850;            // Net longitudinal leg shock tracking length (mm)
piston_outer_diameter = 480;            // Silverado/Chevy fluid housing width (mm)
motor_stator_diameter = 820;            // GM high-performance axial-flux casing (mm)
harness_conduit_width = 80;             // Cast-in 4oz copper logic rail track (mm)
barrel_cell_bore = 95;                  // Modular barrel capacitor cavity width (mm)

module Master_Bipedal_Powertrain_Forge() {
    // Central Supply Injection Runner Axis (Molten Feed Line from Siphon Forge)
    color([0.22, 0.22, 0.24]) {
        cylinder(h = piston_casing_height * 2.2, d = 45, center = true);
        translate() rotate() cylinder(h = 600, d = 22);
        translate([0, 0, -600]) rotate() cylinder(h = 600, d = 22);
    }
    
    // Instantiate Connected Powertrain Elements Symmetrically (Left & Right Leg Nodes)
    Cast_Kickstart_Pistons();
    Cast_GM_Motor_Stators();
}

module Cast_Kickstart_Pistons() {
    // ---- KICKSTART REGENERATIVE SHOCK ABSORBER HULL (LEFT & RIGHT) ----
    color([0.5, 0.5, 0.55]) { // Metallic Hardware Steel Spec
        // Left Leg Regen Shock (Mounts inside Shin Bones B11/B12)
        translate([-650, 0, 600])
            difference() {
                cylinder(h = piston_casing_height * 0.45, d = piston_outer_diameter, center = true);
                // Internal cylinder bore where magnet passes through copper coil lines
                cylinder(h = piston_casing_height * 0.5, d = piston_outer_diameter - 80, center = true);
                
                // Integrated sub-armor slots to fit the quick-release barrel capacitors
                for (angle =) {
                    rotate([0, 0, angle]) translate([piston_outer_diameter/2 - 20, 0, 0])
                        cylinder(h = piston_casing_height * 0.3, d = barrel_cell_bore, center = true);
                }
                cube([harness_conduit_width, piston_outer_diameter + 20, piston_casing_height], center = true);
            }
            
        // Right Leg Regen Shock (Mounts inside Shin Bones B11/B12)
        translate() rotate()
            difference() {
                cylinder(h = piston_casing_height * 0.45, d = piston_outer_diameter, center = true);
                cylinder(h = piston_casing_height * 0.5, d = piston_outer_diameter - 80, center = true);
                for (angle =) {
                    rotate([0, 0, angle]) translate([piston_outer_diameter/2 - 20, 0, 0])
                        cylinder(h = piston_casing_height * 0.3, d = barrel_cell_bore, center = true);
                }
                cube([harness_conduit_width, piston_outer_diameter + 20, piston_casing_height], center = true);
            }
    }
}

module Cast_GM_Motor_Stators() {
    // ---- GM HIGH-PERFORMANCE AXIAL-FLUX PROPULSION MOTOR HOUSING ----
    color([0.35, 0.35, 0.38]) { // Inner Frame Dark Gunmetal Spec
        // Left Hip/Ankle Drive Stator (Mounts to H14/H15 Swivels)
        translate([-650, 0, -600])
            difference() {
                // Ultra-dense high-torque density stator casing plate
                cylinder(h = 380, d = motor_stator_diameter, center = true);
                // Central driveshaft core bore tracking to the cycloidal reduction rings
                cylinder(h = 400, d = motor_stator_diameter * 0.4, center = true);
                cube([harness_conduit_width, motor_stator_diameter + 20, 400], center = true);
            }
            
        // Right Hip/Ankle Drive Stator (Mounts to H14/H15 Swivels)
        translate([650, 0, -600]) rotate()
            difference() {
                cylinder(h = 380, d = motor_stator_diameter, center = true);
                cylinder(h = 400, d = motor_stator_diameter * 0.4, center = true);
                cube([harness_conduit_width, motor_stator_diameter + 20, 400], center = true);
            }
    }
}

// Render Master Assembly Node to Workspace Parametric Window
Master_Bipedal_Powertrain_Forge();
