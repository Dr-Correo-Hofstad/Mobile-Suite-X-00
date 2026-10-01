// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - LOWER ARM DEFENSE MATRIX
// COMPONENT VAULT: BANDAI CAST RUNNER C - FOREARM SHELLS C6 & C7
// MANUFACTURING SPEC: SOLID-STATE CONDUIT INFRASTRUCTURE Retros
// MECHANICAL GIMMICK: SLIDING ARMOR TRACKS TO EXPOSE J14 RIFLE MOUNTS
// ============================================================================

$fn = 100; // Circular segment rendering resolution count

// Structural Constants Scaled 1:1 for a 16.7-Meter Airframe Scale (mm)
forearm_armor_length = 1450;            // Total longitudinal vertical height (mm)
forearm_outer_diameter = 420;          // Transverse lower arm shell envelope (mm)
armor_skin_thickness = 35;              // Solid TiAl protective plating wall (mm)
harness_conduit_width = 80;             // Embedded 4oz copper logic trace track (mm)
coupling_window_width = 160;            // Open slot width to expose J14 couplers (mm)

module Runner_C_Forearm_Forge() {
    // Central Supply Injection Runner Axis (Molten Feed Line from Siphon Forge)
    color([0.22, 0.22, 0.24]) {
        cylinder(h = forearm_armor_length * 1.5, d = 42, center = true);
        // Direct injection gates tracking straight into the part mold cavities
        translate([0, 250, 400]) rotate([0, 90, 0]) cylinder(h = 300, d = 22);
        translate([0, 250, -400]) rotate([0, 90, 0]) cylinder(h = 300, d = 22);
    }
    
    // Instantiate Scaled Protective Armor Molds Symmetrically
    Cast_Forearm_Shield_Shells();
}

module Cast_Forearm_Shield_Shells() {
    // ---- PART C6: OUTER LEFT FOREARM ARMOR PROTECTION SHELL ---- [Page 6, Step 3]
    translate([-450, 0, 450]) color([0.2, 0.4, 0.8]) { // Cobalt Blue Armor Spec
        difference() {
            // Main solid tapered cylindrical lower arm panel casing
            cylinder(h = forearm_armor_length * 0.45, d1 = forearm_outer_diameter + 80, d2 = forearm_outer_diameter, center = true);
            
            // Internal pocket excavation (Leaves the rigid 35mm defensive wall thickness)
            cylinder(h = forearm_armor_length * 0.5, d1 = forearm_outer_diameter + 80 - (armor_skin_thickness*2), d2 = forearm_outer_diameter - (armor_skin_thickness*2), center = true);
            
            // Slotted Window Cutout for the sliding Rifle Locking Plates
            translate([0, (forearm_outer_diameter/2), 0])
                cube([coupling_window_width, 200, forearm_armor_length * 0.25], center = true);
                
            // Continuous cast-in routing track for the 4oz solid-state wiring rails
            cube([harness_conduit_width, forearm_outer_diameter + 100, forearm_armor_length], center = true);
            
            // Slicing tool to generate an asymmetrical half-shell part component
            translate([0, -forearm_outer_diameter, 0])
                cube([forearm_outer_diameter * 2, forearm_outer_diameter * 2, forearm_armor_length * 2], center = true);
        }
    }
    
    // ---- PART C7: OUTER RIGHT FOREARM ARMOR PROTECTION SHELL ---- [Page 6, Step 3]
    translate([450, 0, -450]) rotate([0, 0, 180]) color([0.2, 0.4, 0.8]) {
        difference() {
            cylinder(h = forearm_armor_length * 0.45, d1 = forearm_outer_diameter + 80, d2 = forearm_outer_diameter, center = true);
            cylinder(h = forearm_armor_length * 0.5, d1 = forearm_outer_diameter + 80 - (armor_skin_thickness*2), d2 = forearm_outer_diameter - (armor_skin_thickness*2), center = true);
            translate([0, (forearm_outer_diameter/2), 0])
                cube([coupling_window_width, 200, forearm_armor_length * 0.25], center = true);
            cube([harness_conduit_width, forearm_outer_diameter + 100, forearm_armor_length], center = true);
            translate([0, -forearm_outer_diameter, 0])
                cube([forearm_outer_diameter * 2, forearm_outer_diameter * 2, forearm_armor_length * 2], center = true);
        }
    }
}

// Render Master Assembly to Parameter Workspace
Runner_C_Forearm_Forge();
