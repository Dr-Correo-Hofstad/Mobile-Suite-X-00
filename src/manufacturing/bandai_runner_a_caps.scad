// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - LOWER TORSO REBALANCING MATRIX
// COMPONENT VAULT: BANDAI CAST RUNNER A - PELVIC JOINT CAPS A3 & A4
// REBALANCING SPEC: TORSIONAL SUPPORT FOR INTENSE HIGH-SPEED ARM MOVEMENTS
// PARITY INTERFACE: SOLID-STATE TERMINAL SOCKETS FOR SQUARE-WAVE RETROFITTING
// ============================================================================

$fn = 100; // Circular segment resolution calculation count

// Sizing Constants Scaled 1:1 for a 16.7-Meter Airframe Scale (mm)
pelvic_cap_diameter = 1380;             // Total horizontal width of cap housing (mm)
pelvic_cap_height = 450;                // Vertical longitudinal thickness (mm)
armor_shield_wall = 85;                 // Thick TiAl reinforcing plate thickness (mm)
harness_conduit_width = 80;             // Cast-in 4oz copper logic trace track (mm)
terminal_socket_width = 240;            // Solid-state multi-mux junction box (mm)

module Runner_A_Cap_Forge() {
    // Central Supply Injection Runner Axis (Molten Feed Line from Siphon Forge)
    color([0.22, 0.22, 0.25]) {
        cylinder(h = pelvic_cap_height * 2.5, d = 42, center = true);
        // Direct feed gates tracking straight into the part mold cavities
        translate([0, 350, 200]) rotate([0, 90, 0]) cylinder(h = 300, d = 22);
        translate([0, 350, -200]) rotate([0, 90, 0]) cylinder(h = 300, d = 22);
    }
    
    // Instantiate Scaled Skeutomorphic Part Molds Symmetrically (Left & Right)
    Cast_Pelvic_Cap_Components();
}

module Cast_Pelvic_Cap_Components() {
    // ---- PART A3: LOWER TORSO PELVIC JOINT CAP (LEFT COMPONENT) ---- [Page 6, Step 1]
    translate([-400, 0, 300]) color([0.7, 0.7, 0.74]) {
        difference() {
            // Main high-strength structural cap ring quadrant
            cylinder(h = pelvic_cap_height, d = pelvic_cap_diameter, center = true);
            
            // Internal pocket clearance (Bores out weight while leaving 85mm walls)
            cylinder(h = pelvic_cap_height + 20, d = pelvic_cap_diameter - (armor_shield_wall * 2), center = true);
            
            // Integrated Solid-State Wire Harness Terminal Socket Pocket
            translate([0, -(pelvic_cap_diameter/4), 0])
                cube([terminal_socket_width, terminal_socket_width, pelvic_cap_height + 10], center = true);
                
            // Continuous cast-in guide track for the 4oz copper logic rail bus
            cube([harness_conduit_width, pelvic_cap_diameter + 10, pelvic_cap_height + 20], center = true);
            
            // Slicing tool to generate an asymmetrical half-shell mating part
            translate([pelvic_cap_diameter/2, 0, 0])
                cube([pelvic_cap_diameter, pelvic_cap_diameter * 2, pelvic_cap_height * 2], center = true);
        }
    }
    
    // ---- PART A4: LOWER TORSO PELVIC JOINT CAP (RIGHT COMPONENT) ---- [Page 6, Step 1]
    translate([400, 0, -300]) rotate([0, 180, 0]) color([0.7, 0.7, 0.74]) {
        difference() {
            cylinder(h = pelvic_cap_height, d = pelvic_cap_diameter, center = true);
            cylinder(h = pelvic_cap_height + 20, d = pelvic_cap_diameter - (armor_shield_wall * 2), center = true);
            translate([0, -(pelvic_cap_diameter/4), 0])
                cube([terminal_socket_width, terminal_socket_width, pelvic_cap_height + 10], center = true);
            cube([harness_conduit_width, pelvic_cap_diameter + 10, pelvic_cap_height + 20], center = true);
            translate([pelvic_cap_diameter/2, 0, 0])
                cube([pelvic_cap_diameter, pelvic_cap_diameter * 2, pelvic_cap_height * 2], center = true);
        }
    }
}

// Render Master Assembly to Parameter Workspace
Runner_A_Cap_Forge();
