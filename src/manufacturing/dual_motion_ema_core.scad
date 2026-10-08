// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - LIMB DEFENSE CORES
// COMPONENT VAULT: ELECTRONIC-FREE DUAL-MOTION ELECTROMAGNETIC ACTUATOR (EMA)
// REPOSITORY SOURCE: AGRICULTURE-PATHOLOGY-INSTITUTE/ELECTROMAGNETIC-ACTUATOR
// SPECIFICATION: ELIMINATION OF HYDRAULICS / INDEPENDENT LINEAR & ROTATIONAL COILS
// CONFIG METRIC: SCALED POWER-BY-WIRE DRIVE JUNCTIONS (1:1 ACTUAL METRIC SCALE)
// ============================================================================

$fn = 100; // High-precision circular resolution segment count

// Structural Component Constants (mm actual metric scale)
actuator_height = 860;                   // Total vertical length of the EMA cylinder housing (mm)
outer_housing_diameter = 280;            // Core exterior boundary envelope width (mm)
rod_diameter = 90;                       // 65mm solid TiAl core rod with protective casing (mm)
coil_layer_thickness = 35;               // High-density copper winding ring depth (mm)

module Dual_Motion_EMA_Core_Forge() {
    // 1. External Protective Solid Housing Shield
    color([0.22, 0.22, 0.25]) { // Deep Industrial Titanium Spec
        difference() {
            cylinder(h = actuator_height, d = outer_housing_diameter, center = true);
            // Core cavity for magnetic winding tracks and internal shaft clearance
            cylinder(h = actuator_height - 40, d = outer_housing_diameter - 20, center = true);
        }
    }
    
    // 2. High-Draw Axial Linear Coil Array (Controls Back-and-Forth Piston Vectoring)
    color([0.85, 0.45, 0.15]) { // Copper Winding Filament Parity
        translate([0, 0, actuator_height/4])
            difference() {
                cylinder(h = actuator_height * 0.35, d = outer_housing_diameter - 25, center = true);
                cylinder(h = actuator_height, d = outer_housing_diameter - 25 - (coil_layer_thickness * 2), center = true);
            }
    }
    
    // 3. Helical Rotational Coil Array (Controls Swivel Torque / Twisting Motion)
    color([0.75, 0.55, 0.15]) {
        translate([0, 0, -actuator_height/4])
            difference() {
                cylinder(h = actuator_height * 0.35, d = outer_housing_diameter - 25, center = true);
                cylinder(h = actuator_height, d = outer_housing_diameter - 25 - (coil_layer_thickness * 2), center = true);
                
                // Cut complex 45-degree diamond planar bevels to model helical winding tracks
                for (r = [0 : 45 : 360]) {
                    rotate([0, 45, r])
                        cube([40, outer_housing_diameter, 40], center = true);
                }
            }
    }
    
    // 4. Double-Motion Power-by-Wire Actuator Control Rod (Linear + Rotational Axis)
    color([0.7, 0.7, 0.72]) { // Polished Solid Titanium Core Shaft
        difference() {
            // Extended operational stroke shaft
            cylinder(h = actuator_height * 1.4, d = rod_diameter, center = true);
            // Internal conduit for cast-in solid state power traces
            cylinder(h = actuator_height * 2, d = rod_diameter - 30, center = true);
        }
    }
}

// Render Master Assembly Component to Parameter Workspace
Dual_Motion_EMA_Core_Forge();
