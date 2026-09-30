// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - WEAPON REBALANCING MATRIX
// COMPONENT VAULT: BANDAI CAST RUNNER D - RIFLE STOCK GUARDS D3 & D4
// INGESTION COMPATIBILITY: FOREARM LOCK COUPLING AND POWER RAIL MATING
// DESIGN RULE: SCALED TITANIUM CASTS (1:1 ACTUAL METRIC UP-SCALE FOR 16.7M MECHA)
// ============================================================================

$fn = 100; // Circular segment resolution calculation count

// Sizing Variables Scaled 1:1 for a 16.7-Meter Airframe Scale (mm)
stock_guard_length = 1150;              // Total vertical height of stock block (mm)
interface_track_stroke = 640;           // Longitudinal sliding track travel path (mm)
power_rail_contact_width = 120;         // Sub-surface 4oz copper interface path (mm)
titanium_armor_wall = 50;               // Zoned TiAl protective outer casing (mm)

module Runner_D_Stock_Forge() {
    // Central Supply Injection Runner Axis (Molten Feed Line from Siphon Forge)
    color([0.24, 0.24, 0.26]) {
        cylinder(h = stock_guard_length * 2.2, d = 42, center = true);
        // Direct injection gates tracking straight into the part mold cavities
        translate([0, 0, 600]) rotate([0, 90, 0]) cylinder(h = 450, d = 22);
        translate([0, 0, -600]) rotate([0, 90, 0]) cylinder(h = 450, d = 22);
    }
    
    // Instantiate Scaled Part Molds Symmetrically (Left & Right Weapon Blips)
    Cast_Rifle_Mating_Components();
}

module Cast_Rifle_Mating_Components() {
    // ---- PART D3: TWIN BUSTER RIFLE STOCK SHIELD COWLING ---- [Page 8, Step 10]
    translate([-450, 0, 400]) color([0.5, 0.5, 0.55]) {
        difference() {
            // Main solid shock-absorbing rear shield block
            cube([380, 480, stock_guard_length], center = true);
            
            // Internal pocket clearance to fit around the inner receiver block
            translate([0, -titanium_armor_wall, 0])
                cube([380 - (titanium_armor_wall*2), 480, stock_guard_length + 10], center = true);
                
            // Continuous cast-in contact pad slots for the 4oz power bus links
            cube([power_rail_contact_width, 600, stock_guard_length * 0.8], center = true);
        }
    }
    
    // ---- PART D4: FOREARM LOCKING INTERFACE SLIDING TRACK ---- [Page 8, Step 10]
    translate([450, 0, -400]) color([0.3, 0.3, 0.35]) {
        difference() {
            // Rigid interface block that slots straight into J14 couplers
            cube([220, 360, interface_track_stroke + 200], center = true);
            
            // Precision T-slot guide track cutout to ensure absolute lock-up alignment
            translate([0, (360/2 - 40), 0])
                cube([140, 90, interface_track_stroke], center = true);
                
            // Sub-surface conduit track routing the telemetric logic links
            cube([power_rail_contact_width - 40, 400, interface_track_stroke * 1.2], center = true);
        }
    }
}

// Render Master Assembly to Parameter Workspace
Runner_D_Stock_Forge();
