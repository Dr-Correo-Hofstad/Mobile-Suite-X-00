// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - UPPER CHASSIS MATRIX
// COMPONENT VAULT: BANDAI CAST RUNNER A - UPPER TORSO & CANNON SLIDES
// REBALANCING VARIABLE: RETRACTABLE WEAPONS ENCLOSURE & COCKPIT MOUNTS
// SCALE FACTOR: 1:1 SCALE UP FOR AN 16.7-METER CHASSIS AIRFRAME
// ============================================================================

$fn = 100; // Geometry segment resolution

// Upper Torso Physical Constraints (Scaled to official MG Ver.Ka metrics)
breastplate_thickness = 120;            // Max TiAl thermal re-entry shielding (mm)
torso_core_width = 3800;                 // Total transverse shoulder-to-shoulder span (mm)
cannon_bore_diameter = 240;             // Machine cannon clearance tube (mm)
hatch_opening_radius = 450;             // Central lens viewport ingestion radius (mm)

module Runner_A_Chest_Casts() {
    // Structural Sprue Supply Line (Feeds Molten Magma from Siphon Forge)
    color([0.3, 0.3, 0.32]) {
        cylinder(h = torso_core_width * 0.8, d = 50, center = true);
        // Casting Gates attaching directly to the component perimeters
        translate([0, 400, 500]) rotate([90, 0, 0]) cylinder(h = 600, d = 25);
        translate([0, 400, -500]) rotate([90, 0, 0]) cylinder(h = 600, d = 25);
    }
    
    // Instantiate Scaled Upper Body Cast Cavities
    Cast_Torso_Shield_Arrays();
}

module Cast_Torso_Shield_Arrays() {
    // ---- PART A14: UPPER LEFT FRONTAL BREASTPLATE SHIELD ---- [From Page 7, Step 5]
    translate([-900, 600, 200]) color([0.2, 0.4, 0.8]) {
        difference() {
            // Heavy-duty contoured exterior shell block
            cube([1200, 1400, 600], center = true);
            // Inward armor-wall relief sweep
            translate([0, 50, -breastplate_thickness])
                cube([1210, 1410, 600], center = true);
            // Integrated slider slot for the left retractable machine cannon cover
            translate([200, 0, 0])
                cylinder(h = 700, d = cannon_bore_diameter, center = true);
        }
    }
    
    // ---- PART A15: UPPER RIGHT FRONTAL BREASTPLATE SHIELD ---- [From Page 7, Step 5]
    translate([900, 600, 200]) rotate([0, 0, 180]) color([0.2, 0.4, 0.8]) {
        difference() {
            cube([1200, 1400, 600], center = true);
            translate([0, 50, -breastplate_thickness])
                cube([1210, 1410, 600], center = true);
            translate([200, 0, 0])
                cylinder(h = 700, d = cannon_bore_diameter, center = true);
        }
    }

    // ---- PART A16: CENTRAL ZERO SYSTEM DISPLAY COLLAR ---- [From Page 7, Step 12]
    translate([0, 800, -400]) color([0.8, 0.1, 0.1]) {
        difference() {
            // Triangular center armor chest cowl piece
            cylinder(h = 450, r1 = hatch_opening_radius + breastplate_thickness, r2 = hatch_opening_radius, center = true);
            // Core boolean subtraction cutout to pass the green clear cockpit shield
            cylinder(h = 460, r = hatch_opening_radius, center = true);
        }
    }
}

// Render Upper Torso Runner Group to Workspace
Runner_A_Chest_Casts();
