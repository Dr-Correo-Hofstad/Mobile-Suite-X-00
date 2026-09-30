// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO - LOWER LIMB ACTUATION MATRIX
// COMPONENT VAULT: BANDAI CAST RUNNER D - HIGH-GRADE COMPLIANT RETROFIT
// REBALANCING VARIABLE: HIGH-AMPERAGE SQUARE-WAVE DRIVELINE COMPATIBILITY
// SCALE FACTOR: 1:1 SCALE UP FOR AN 16.7-METER BI-PEDAL AIRFRAME
// ============================================================================

$fn = 100; // Circular segment resolution

// Leg Mechanical Constraints & Geometric Variables
shin_armor_wall = 50;                  // Zoned Titanium-Aluminide skin thickness (mm)
calf_cavity_length = 4200;              // Full lower leg internal axis height (mm)
knee_joint_bore = 540;                  // Cycloidal reduction gear housing diameter (mm)
solid_state_bus_width = 80;             // Internal 4oz copper harness guide path (mm)

module Runner_D_Leg_Casts() {
    // Master Sprue Supply Bar (Feeds Molten Alloy from Siphon Forge)
    color([0.25, 0.25, 0.3]) {
        cylinder(h = calf_cavity_length + 600, d = 45, center = true);
        // Feeding Gates linking directly to the mold cavities
        translate([0, 0, 1000]) rotate([0, 90, 0]) cylinder(h = 500, d = 20);
        translate([0, 0, -1000]) rotate([0, 90, 0]) cylinder(h = 500, d = 20);
    }
    
    // Instantiate Scaled Part Cavities
    Cast_Lower_Limb_Sections();
}

module Cast_Lower_Limb_Sections() {
    // ---- PART D1: KNEE ARRESTED CYCLOIDAL JOINT SHIELD ----
    translate([350, 0, 1000]) color([0.75, 0.75, 0.8]) {
        difference() {
            // High-strength thick protective joint cap
            cylinder(h = 600, d = knee_joint_bore + (shin_armor_wall * 2), center = true);
            // Core cavity for the pre-loaded dual-axis roller cluster
            cylinder(h = 610, d = knee_joint_bore, center = true);
        }
    }
    
    // ---- PART D2: FRONT LOWER SHIN ARMOR PANEL ----
    translate([450, 0, -500]) color([0.8, 0.8, 0.85]) {
        difference() {
            // Tapered external protective shield panel
            cylinder(h = calf_cavity_length * 0.5, r1 = 650, r2 = 400, center = true);
            cylinder(h = calf_cavity_length * 0.6, r1 = 650 - shin_armor_wall, r2 = 400 - shin_armor_wall, center = true);
            // Slice mold to form a clean half-shell curved frontal breastplate
            translate([0, -1000, 0]) cube([2000, 2000, calf_cavity_length], center = true);
        }
    }
    
    // ---- PART D3: LOWER LIMB SOLID-STATE FRAME skeleton (INTERNAL BONE) ----
    translate([850, 0, 0]) color([0.4, 0.4, 0.45]) {
        difference() {
            // Solid internal structural backbone strut
            cube([380, 380, calf_cavity_length * 0.9], center = true);
            // Continuous cast-in channel for the 4oz electrical wiring grid
            cube([solid_state_bus_width, 400, calf_cavity_length], center = true);
        }
    }
}

// Render Runner Group to Parametric Workspace
Runner_D_Leg_Casts();
