// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - WEAPON FABRICATION CORES
// COMPONENT VAULT: BANDAI CAST RUNNER D - TWIN BUSTER RIFLE MODIFIED BARRELS
// ENGINE RE-ARCHITECTURE: CONTINUOUS OPEN-ENDED INDUCTION PLASMA BORE
// CIRCUIT SPECS: HIGH-VOLTAGE TELEMETRIC POWER INTEGRATION (ZERO SUCTION POP)
// ============================================================================

$fn = 100; // Circular segment rendering resolution count

// Global Tactical Sizing Metrics (1:1 Metrics for an 16.7-Meter Airframe)
rifle_total_length = 5900;              // Total longitudinal barrel weapon axis (mm)
open_bore_diameter = 420;               // Core 16.5-inch continuous venting path (mm)
armor_chassis_wall = 50;                // Thick TiAl protective shell casing (mm)
power_rail_track_width = 120;           // Sub-surface 4oz copper delivery rail (mm)

module Runner_D_Open_Rifle_Forge() {
    // Central Supply Injection Runner Axis (Molten Feed Line from Siphon Forge)
    color([0.25, 0.25, 0.28]) {
        cylinder(h = rifle_total_length * 0.6, d = 45, center = true);
        // Direct injection gates tracking straight into the part mold cavities
        translate() rotate() cylinder(h = 600, d = 25);
        translate([0, 0, -1200]) rotate() cylinder(h = 600, d = 25);
    }
    
    // Instantiate Scaled Open-Ended Part Molds Symmetrically
    Cast_Open_Ended_Rifle_Shells();
}

module Cast_Open_Ended_Rifle_Shells() {
    // ---- PART D1 MODIFIED: OPEN-ENDED MAIN BARREL HULL (LEFT HALF-SHELL) ----
    translate() color([0.5, 0.5, 0.55]) {
        difference() {
            // Main weapon structural barrel enclosure block
            cylinder(h = rifle_total_length * 0.5, d = open_bore_diameter + (armor_chassis_wall * 2), center = true);
            
            // CONTINUOUS OPEN-ENDED BORE [Cuts completely through both ends of the weapon cylinder]
            cylinder(h = rifle_total_length * 0.6, d = open_bore_diameter, center = true);
            
            // Slicing profile tool to generate clean asymmetrical shell panel face
            translate([0, -open_bore_diameter, 0])
                cube([open_bore_diameter * 2, open_bore_diameter * 2, rifle_total_length], center = true);
        }
        
        // INTEGRATED 4OZ POWER DELIVERY RAILS [Cast directly into the open frame walls]
        color([1.0, 0.73, 0.2]) {
            translate([-(open_bore_diameter/2 + 10), 0, 0])
                cube([30, power_rail_track_width, rifle_total_length * 0.45], center = true);
        }
    }
    
    // ---- PART D2 MODIFIED: OPEN-ENDED MAIN BARREL HULL (RIGHT HALF-SHELL) ----
    translate([650, 0, -800]) rotate() color([0.5, 0.5, 0.55]) {
        difference() {
            cylinder(h = rifle_total_length * 0.5, d = open_bore_diameter + (armor_chassis_wall * 2), center = true);
            cylinder(h = rifle_total_length * 0.6, d = open_bore_diameter, center = true);
            translate([0, -open_bore_diameter, 0])
                cube([open_bore_diameter * 2, open_bore_diameter * 2, rifle_total_length], center = true);
        }
        
        color([1.0, 0.73, 0.2]) {
            translate([-(open_bore_diameter/2 + 10), 0, 0])
                cube([30, power_rail_track_width, rifle_total_length * 0.45], center = true);
        }
    }
}

// Render Master Assembly to Parameter Workspace
Runner_D_Open_Rifle_Forge();
