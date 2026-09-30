// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - SOLID STATE MANUFACTURING VAULT
// SUB-MODULE: RUNNER B LOWER LEG CASTING & INTEGRATED IN-LINE AMMO FORGE
// SOURCE REFERENCE: 1/144 FIGHTING ACTION SPRUE ASSEMBLY MATRIX (PAGES 5-6)
// REAL-WORLD ADAPTATION: Ti-6Al-4V STRUCTURAL skeleton & PROJECTILE RECOVERY
// ============================================================================

$fn = 100; // Geometry segment resolution

// Global Dimensional Matrices (Scaled 1:1 Actual Metric for 16.7m Mecha)
runner_bar_diameter = 65;               // Solid thick outer supply track (mm)
runner_width_axis = 2400;               // Horizontal sprue framework span (mm)
gate_feed_nozzle = 22;                  // Molten injection inlet thickness (mm)
leg_armor_thickness = 50;               // Scaled calf/shin defensive plating (mm)
ammo_slug_length = 180;                 // Standard Maxwell Rifle sabot length (mm)

module Master_Runner_B_Forge() {
    // 1. Recoverable Ammo Frame Layout (The "Scrap" Tracks used as Bullet Cores)
    color([0.2, 0.2, 0.25]) {
        // Main Outer Vertical Supply Rails
        translate([-(runner_width_axis/2), 0, 0])
            cylinder(h = 3200, d = runner_bar_diameter, center = true);
        translate([runner_width_axis/2, 0, 0])
            cylinder(h = 3200, d = runner_bar_diameter, center = true);
            
        // Horizontal Cross-Feed Rails (The primary ammo cutting stock)
        translate([0, 0, 800]) rotate([0, 90, 0])
            cylinder(h = runner_width_axis, d = runner_bar_diameter, center = true);
        translate([0, 0, -800]) rotate([0, 90, 0])
            cylinder(h = runner_width_axis, d = runner_bar_diameter, center = true);
    }
    
    // 2. Active Part Castings (Positioned exactly to replicate manual sprues)
    Casting_Manual_Parts();
    
    // 3. Visualized Ammo Cut Segments (Shows how the scrap bars are chopped)
    Visualized_Ammunition_Chop();
}

module Casting_Manual_Parts() {
    // ---- PART B9: LEFT LOWER SHIN OUTBOARD SHELL ---- [From Page 6, Step 2]
    translate([-(runner_width_axis/2 - 400), 0, 800]) color([0.7, 0.7, 0.75]) {
        // Gate feed connection
        rotate([0, 90, 0]) cylinder(h = 350, d = gate_feed_nozzle);
        translate([350, 0, 0]) difference() {
            cylinder(h = 1200, d = 750, center = true);
            cylinder(h = 1210, d = 750 - (leg_armor_thickness * 2), center = true);
            translate([0, -500, 0]) cube([1000, 1000, 1300], center = true);
        }
    }
    
    // ---- PART B10: RIGHT LOWER SHIN OUTBOARD SHELL ---- [From Page 6, Step 1]
    translate([(runner_width_axis/2 - 400), 0, 800]) rotate([0, 0, 180]) color([0.7, 0.7, 0.75]) {
        rotate([0, 90, 0]) cylinder(h = 350, d = gate_feed_nozzle);
        translate([350, 0, 0]) difference() {
            cylinder(h = 1200, d = 750, center = true);
            cylinder(h = 1210, d = 750 - (leg_armor_thickness * 2), center = true);
            translate([0, -500, 0]) cube([1000, 1000, 1300], center = true);
        }
    }

    // ---- PART B15: LEFT THIGH CAVITY ADAPTER ---- [From Page 6, Step 2]
    translate([-(runner_width_axis/2 - 400), 0, -800]) color([0.4, 0.4, 0.45]) {
        rotate([0, 90, 0]) cylinder(h = 350, d = gate_feed_nozzle);
        translate([350, 0, 0]) cube([320, 580, 450], center = true);
    }

    // ---- PART B16: RIGHT THIGH CAVITY ADAPTER ---- [From Page 6, Step 1]
    translate([(runner_width_axis/2 - 400), 0, -800]) rotate([0, 0, 180]) color([0.4, 0.4, 0.45]) {
        rotate([0, 90, 0]) cylinder(h = 350, d = gate_feed_nozzle);
        translate([350, 0, 0]) cube([320, 580, 450], center = true);
    }
}

module Visualized_Ammunition_Chop() {
    // Highlights the exact laser-chopped ammo core sections along the scrap rails
    for (offset = [-600, -200, 200, 600]) {
        translate([offset, 0, 0]) {
            color([0.9, 0.1, 0.1, 0.7]) { // Laser Cutting Point Indicators
                cube([4, runner_bar_diameter + 10, 1800], center = true);
            }
            color([1.0, 0.8, 0.2]) { // Resulting Maxwell Rifle Sabot Bullet
                translate([ammo_slug_length/2, 0, -1100]) rotate([0, 90, 0])
                    cylinder(h = ammo_slug_length, d = runner_bar_diameter - 2, center = true);
            }
        }
    }
}

// Instantiate Global Sprue & Ammo Manufacturing Workspace
Master_Runner_B_Forge();
