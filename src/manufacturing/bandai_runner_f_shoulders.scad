// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - UPPER AIRFRAME PROTECTION
// COMPONENT VAULT: BANDAI CAST RUNNER F - SHOULDER CAPS F18 & F19
// ENCLOSURE COMPATIBILITY: GUNDAM 00 MECHANICS HEAVY BRACKET CLEARANCE
// ELECTRICAL PARITY: WIRELESS INDUCTIVE POWER HARNESS CONDUITS
// ============================================================================

$fn = 100; // Circular segment rendering resolution count

// Structural Constants Scaled 1:1 for a 16.7-Meter Airframe Scale (mm)
shoulder_cap_length = 1850;             // Total longitudinal vertical span (mm)
shoulder_cap_width = 1100;              // Transverse outer panel width (mm)
armor_skin_thickness = 50;              // Solid TiAl defensive armor wall (mm)
harness_conduit_width = 80;             // Cast-in 4oz copper logic trace track (mm)
bracket_clearance_depth = 120;          // Internal relief for 00-Mechanics brace (mm)

module Runner_F_Shoulder_Cap_Forge() {
    // Central Supply Injection Runner Axis (Molten Feed Line from Siphon Forge)
    color([0.24, 0.24, 0.26]) {
        cylinder(h = shoulder_cap_length * 1.5, d = 42, center = true);
        // Direct injection gates tracking straight into the part mold cavities
        translate([0, 300, 400]) rotate([0, 90, 0]) cylinder(h = 450, d = 22);
        translate([0, 300, -400]) rotate([0, 90, 0]) cylinder(h = 450, d = 22);
    }
    
    // Instantiate Scaled Skeutomorphic Part Molds Symmetrically
    Cast_Outer_Shoulder_Armor();
}

module Cast_Outer_Shoulder_Armor() {
    // ---- PART F18: LEFT OUTER SHOULDER PROTECTION CAP ---- [Page 4, Step 05-2]
    translate([-600, 0, 450]) color([0.85, 0.85, 0.9]) { // Classic White Armor Spec
        difference() {
            // Main tapered outer armor cowling block
            scale([1.0, 0.45, 1.0])
                cylinder(h = shoulder_cap_length * 0.45, r1 = shoulder_cap_width * 0.5, r2 = shoulder_cap_width * 0.4, center = true);
            
            // Internal pocket excavation (Leaves the rigid 50mm protective boundary)
            scale([1.0, 0.45, 1.0])
                cylinder(h = shoulder_cap_length * 0.5, r1 = (shoulder_cap_width * 0.5) - armor_skin_thickness, r2 = (shoulder_cap_width * 0.4) - armor_skin_thickness, center = true);
            
            // Internal relief cavity to clear the heavy external Gundam 00 Mechanics support braces
            translate([-(shoulder_cap_width * 0.25), 0, 0])
                cube([bracket_clearance_depth, 450, shoulder_cap_length * 0.4], center = true);
                
            // Continuous cast-in routing track for the 4oz solid-state wiring rails
            cube([harness_conduit_width, shoulder_cap_width, shoulder_cap_length], center = true);
            
            // Slicing profile tool to generate an asymmetrical half-shell part component
            translate([0, -shoulder_cap_width, 0])
                cube([shoulder_cap_width * 2, shoulder_cap_width * 2, shoulder_cap_length * 2], center = true);
        }
    }
    
    // ---- PART F19: RIGHT OUTER SHOULDER PROTECTION CAP ---- [Page 4, Step 05-2]
    translate([600, 0, -450]) rotate([0, 0, 180]) color([0.85, 0.85, 0.9]) {
        difference() {
            scale([1.0, 0.45, 1.0])
                cylinder(h = shoulder_cap_length * 0.45, r1 = shoulder_cap_width * 0.5, r2 = shoulder_cap_width * 0.4, center = true);
            scale([1.0, 0.45, 1.0])
                cylinder(h = shoulder_cap_length * 0.5, r1 = (shoulder_cap_width * 0.5) - armor_skin_thickness, r2 = (shoulder_cap_width * 0.4) - armor_skin_thickness, center = true);
            translate([-(shoulder_cap_width * 0.25), 0, 0])
                cube([bracket_clearance_depth, 450, shoulder_cap_length * 0.4], center = true);
            cube([harness_conduit_width, shoulder_cap_width, shoulder_cap_length], center = true);
            translate([0, -shoulder_cap_width, 0])
                cube([shoulder_cap_width * 2, shoulder_cap_width * 2, shoulder_cap_length * 2], center = true);
        }
    }
}

// Render Master Assembly to Parameter Workspace
Runner_F_Shoulder_Cap_Forge();
