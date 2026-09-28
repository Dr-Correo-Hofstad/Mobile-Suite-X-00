// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO - ENDLESS WALTZ CHASSIS SPECIFICATION
// CORPORATE PARTNERS: BANDAI MODEL ENGINEERING & FOX ROTHSCHILD LLP (IP VAULT)
// SUB-MODULE: RUNNER A CASTING ASSEMBLY - CORE COCKPIT & ATX COMPUTATIONAL MOUNTS
// DESIGN RULES: SCALED TITANIUM CASTS (1:1 ACTUAL METRIC UP-SCALE FOR 16.7M MECHA)
// ============================================================================

\$fn = 80; // High-precision circular rendering segment count

// Master Runner Frame Geometry Constants
runner_bar_diameter = 40;               // Core structural feed channel width (mm)
runner_length = 3000;                   // Full manufacturing tray length axis (mm)
gate_feed_width = 15;                   // Injection entry point thickness (mm)
titanium_cast_thickness = 70;           // Base zoned defensive plate wall (mm)

module Runner_A_Master_Frame() {
    // 1. Central Distribution Runner Axis (Feeds Molten Magma from Siphon Forge)
    color([0.3, 0.3, 0.35]) {
        cylinder(h = runner_length, d = runner_bar_diameter, center = true);
        
        // Lateral Feed Crossbars (Gates connecting straight to part cavities)
        translate([0, 0, 800]) rotate([90, 0, 0])
            cylinder(h = 600, d = runner_bar_diameter * 0.75, center = true);
        translate([0, 0, -800]) rotate([90, 0, 0])
            cylinder(h = 600, d = runner_bar_diameter * 0.75, center = true);
    }
    
    // 2. Part Ingestion Arrays (Positioned exactly to mirror manual sprues)
    Translate_And_Cast_Parts();
}

module Translate_And_Cast_Parts() {
    // ---- PART A1: FRONT HEADLIGHT COWL / GLASS GREEN COCKPIT SHIELD ----
    translate([0, 300, 800]) color([0.1, 0.8, 0.2, 0.6]) {
        difference() {
            // Spherical outer hull lens element
            sphere(r = 450);
            sphere(r = 450 - titanium_cast_thickness);
            translate([0, 0, -500]) cube([1000, 1000, 1000], center = true);
        }
    }
    
    // ---- PART A2: COCKPIT ATX MOUNT BASE PLUG ----
    translate([0, -300, 800]) color([0.5, 0.5, 0.5]) {
        difference() {
            cube([600, 500, titanium_cast_thickness], center = true);
            // Pre-cast bolt channels for GM-powered shock absorber stems
            translate([-200, 0, 0]) cylinder(h = 200, d = 30, center = true);
            translate([200, 0, 0]) cylinder(h = 200, d = 30, center = true);
        }
    }
    
    // ---- PART A3: PELVIC ELLIPTICAL CAVITY PORT COMPONENT (LEFT) ----
    translate([0, 350, -800]) color([0.7, 0.7, 0.72]) {
        difference() {
            // Thick titanium structural bone block
            cube([300, 400, 500], center = true);
            // Parametric drive tunnel cutout to clear variable-reluctance shafts
            rotate([0, 90, 0]) cylinder(h = 400, d = 160, center = true);
        }
    }
    
    // ---- PART A4: PELVIC ELLIPTICAL CAVITY PORT COMPONENT (RIGHT) ----
    translate([0, -350, -800]) color([0.7, 0.7, 0.72]) {
        difference() {
            cube([300, 400, 500], center = true);
            rotate([0, 90, 0]) cylinder(h = 400, d = 160, center = true);
        }
    }
}

// Render Master Sprue Component for Verification
Runner_A_Master_Frame();
