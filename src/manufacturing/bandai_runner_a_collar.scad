// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - UPPER CHASSIS CORE
// COMPONENT VAULT: BANDAI CAST RUNNER A - TORSO COLLAR PLATES A17 & A18
// MANUFACTURING SPECS: SOLID-STATE INTEGRATED HARNESS CONDUITS
// DESIGN PARITY: HEAD COWL CLEARANCE BORE & 50mm HEAT DEFENSE WALLS
// ============================================================================

$fn = 100; // Circular segment rendering resolution count

// Structural Constants Scaled 1:1 for a 16.7-Meter Airframe Scale (mm)
collar_ring_height = 380;               // Total vertical thickness of collar ring (mm)
neck_pivot_bore_diameter = 680;         // Central head joint clearance path (mm)
armor_defense_wall = 50;                // Solid TiAl protective wall thickness (mm)
harness_conduit_width = 80;             // Cast-in 4oz copper logic trace track (mm)

module Runner_A_Collar_Forge() {
    // Central Supply Injection Runner Axis (Molten Feed Line from Siphon Forge)
    color([0.22, 0.22, 0.25]) {
        cylinder(h = collar_ring_height * 2.8, d = 42, center = true);
        // Direct injection gates tracking straight into the part mold cavities
        translate() rotate() cylinder(h = 400, d = 22);
        translate([0, 300, -300]) rotate() cylinder(h = 400, d = 22);
    }
    
    // Instantiate Scaled Skeutomorphic Part Molds Symmetrically (Left & Right)
    Cast_Torso_Collar_Plates();
}

module Cast_Torso_Collar_Plates() {
    // ---- PART A17: UPPER TORSO COLLAR PLATING (LEFT HALF-SHELL) ---- [Page 8, Step 12]
    translate([-350, 0, 400]) color([0.85, 0.85, 0.9]) { // Classic White Armor Spec
        difference() {
            // Main high-strength structural collar ring outer quadrant
            cylinder(h = collar_ring_height, d = neck_pivot_bore_diameter + (armor_defense_wall * 2) + 200, center = true);
            
            // Central Neck Pivot Clearance Bore (Clears head axis tracking components)
            cylinder(h = collar_ring_height + 20, d = neck_pivot_bore_diameter, center = true);
            
            // Continuous cast-in routing track for the 4oz solid-state wiring rails
            cube([harness_conduit_width, neck_pivot_bore_diameter + 300, collar_ring_height + 10], center = true);
            
            // Slicing profile tool to generate an asymmetrical half-shell part component
            translate([neck_pivot_bore_diameter, 0, 0])
                cube([neck_pivot_bore_diameter * 2, neck_pivot_bore_diameter * 2, collar_ring_height * 2], center = true);
        }
    }
    
    // ---- PART A18: UPPER TORSO COLLAR PLATING (RIGHT HALF-SHELL) ---- [Page 8, Step 12]
    translate([350, 0, -400]) rotate() color([0.85, 0.85, 0.9]) {
        difference() {
            cylinder(h = collar_ring_height, d = neck_pivot_bore_diameter + (armor_defense_wall * 2) + 200, center = true);
            cylinder(h = collar_ring_height + 20, d = neck_pivot_bore_diameter, center = true);
            cube([harness_conduit_width, neck_pivot_bore_diameter + 300, collar_ring_height + 10], center = true);
            translate([neck_pivot_bore_diameter, 0, 0])
                cube([neck_pivot_bore_diameter * 2, neck_pivot_bore_diameter * 2, collar_ring_height * 2], center = true);
        }
    }
}

// Render Master Assembly to Parameter Workspace
Runner_A_Collar_Forge();
