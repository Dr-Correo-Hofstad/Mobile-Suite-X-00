// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - PILOT LIFE SUPPORT MATRIX
// COMPONENT: ORION-CLASS CYLINDRICAL COCKPIT CAPSULE (LGM FORM-FACTOR)
// MANUFACTURING SPEC: CONTINUOUS DOUBLE-RESISTANCE SEAM WELDING
// INTERFACE: REAR MOLEX-STYLE INTERLOCK WITH MECHANICAL GUIDE FINS
// ============================================================================

$fn = 120; // High-fidelity circular resolution segment count

// Structural Constants Scaled 1:1 for a 17.3 m³ Habitable Footprint (mm)
capsule_total_length = 2850;            // Longitudinal cylinder length path (mm)
capsule_outer_diameter = 2400;          // Structural hull metric diameter (mm)
armor_skin_thickness = 45;              // Welded TiAl pressure vessel wall (mm)
guide_fin_span = 320;                   // Transverse Molex-alignment fin width (mm)
rail_stroke_height = 80;                // Hardened slider rail height index (mm)

module Orion_Cylindrical_Cockpit_Forge() {
    // Main Core Cylinder Assembly 
    difference() {
        // Outer Armored Shell Base
        rotate([0, 90, 0])
            cylinder(h = capsule_total_length, d = capsule_outer_diameter, center = true);
        
        // Internal Pressurized Habitable Chamber (17.3 Cubic Meters Volume)
        rotate([0, 90, 0])
            cylinder(h = capsule_total_length - (armor_skin_thickness * 2), 
                     d = capsule_outer_diameter - (armor_skin_thickness * 2), center = true);
        
        // Forward Window Boring (Mills out the entire front wall face for view screen)
        translate([capsule_total_length/2 - 10, 0, 0])
            rotate([0, 90, 0])
                cylinder(h = 100, d = capsule_outer_diameter - 200, center = true);
                
        // Rear Interlocking Escape Hatch Cutout Opening
        translate([-(capsule_total_length/2 + 10), 0, 0])
            cube([100, 980, 1200], center = true);
    }
    
    // Forward Panoramic Bubbled Viewing Window
    translate([capsule_total_length/2 - armor_skin_thickness, 0, 0])
        color([0.3, 0.7, 0.9, 0.4]) { // Transparent Polycarbonate Spec
            difference() {
                sphere(d = capsule_outer_diameter - 200);
                sphere(d = capsule_outer_diameter - 240);
                // Cut back hemisphere to seal flush over the cylinder tip
                translate([-capsule_outer_diameter/2, 0, 0])
                    cube([capsule_outer_diameter, capsule_outer_diameter * 1.5, capsule_outer_diameter * 1.5], center = true);
            }
        }
        
    // External Structural Chassis Sliding Rails & Molex Guide Fins
    Build_Chassis_Sliding_Rails();
    Build_Rear_Molex_Guide_Fins();
}

module Build_Chassis_Sliding_Rails() {
    // Longitudinal mounting rails to slide the vehicle into the upper torso cage
    color([0.3, 0.3, 0.32]) {
        // Left Structural Sliding Tracker
        translate([0, -(capsule_outer_diameter/2 + rail_stroke_height/2), 0])
            cube([capsule_total_length * 0.9, rail_stroke_height, 120], center = true);
        // Right Structural Sliding Tracker
        translate([0, (capsule_outer_diameter/2 + rail_stroke_height/2), 0])
            cube([capsule_total_length * 0.9, rail_stroke_height, 120], center = true);
    }
}

module Build_Rear_Molex_Guide_Fins() {
    // Angled metal guides to center the capsule into the main Molex connector
    color([0.5, 0.5, 0.55]) {
        // Left Centering Fin Profile
        translate([-(capsule_total_length/2 - 80), -(980/2 + guide_fin_span/4), 0])
            rotate([0, 0, 30]) cube([300, guide_fin_span, 1200], center = true);
        // Right Centering Fin Profile
        translate([-(capsule_total_length/2 - 80), (980/2 + guide_fin_span/4), 0])
            rotate([0, 0, -30]) cube([300, guide_fin_span, 1200], center = true);
    }
}

// Render Master Module to Workspace
Orion_Cylindrical_Cockpit_Forge();
