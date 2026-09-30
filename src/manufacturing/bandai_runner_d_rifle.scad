// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - WEAPON FABRICATION CORES
// COMPONENT VAULT: BANDAI CAST RUNNER D - TWIN BUSTER RIFLE CHASSIS HOUSINGS
// ENGINE ADAPTATION: STRESS-INDUCED THERMOACOUSTIC MATRIX COOLING RETROFIT
// CIRCUIT RULES: FULL SQUARE-WAVE RETROVECTORS & CAST RUNNER CORE AMMO DRIVERS
// ============================================================================

$fn = 100; // Circular fragment resolution count

// Global Tactical Sizing Metrics (1:1 Metrics for an 16.7-Meter Airframe)
rifle_total_length = 5900;              // Total longitudinal barrel weapon axis (mm)
variable_bore_diameter = 420;          // Core 16.5-inch plasma induction path (mm)
armor_chassis_wall = 50;                // Thick TiAl protective shell casing (mm)
power_rail_track_width = 120;           // Sub-surface 4oz copper delivery rail (mm)
pzt_layer_thickness = 15;               // Piezoelectric harvesting crystal array (mm)

module Runner_D_Rifle_Forge() {
    // Master Material Feed Bar (Feeds molten magma from Siphon Forge)
    color([0.25, 0.25, 0.28]) {
        cylinder(h = rifle_total_length * 0.6, d = 45, center = true);
        // Direct injection gates feeding straight to part cavities
        translate() rotate() cylinder(h = 600, d = 25);
        translate([0, 0, -1200]) rotate() cylinder(h = 600, d = 25);
    }
    
    // Instantiate Scaled Part Cavities (Replicating Manual Sprues exactly)
    Cast_Twin_Buster_Rifle_Sections();
}

module Cast_Twin_Buster_Rifle_Sections() {
    // ---- PART D1: MAIN RIFLE MAIN HULL CASING (LEFT HALF-SHELL) ---- [From Page 8, Step 10]
    translate() color([0.5, 0.5, 0.55]) {
        difference() {
            // Main weapon structural barrel enclosure block
            cylinder(h = rifle_total_length * 0.5, d = variable_bore_diameter + (armor_chassis_wall * 2), center = true);
            
            // Core weapon bore path (Six-stage induction plasma loop chamber)
            cylinder(h = rifle_total_length * 0.55, d = variable_bore_diameter, center = true);
            
            // Sub-surface cut out for embedded PZT / micro-Peltier thermoacoustic tracks
            cylinder(h = rifle_total_length * 0.52, d = variable_bore_diameter + pzt_layer_thickness * 2, center = true);
            
            // Slice mold vector to form an asymmetrical mating part shell
            translate([0, -variable_bore_diameter, 0])
                cube([variable_bore_diameter * 2, variable_bore_diameter * 2, rifle_total_length], center = true);
        }
        
        // INTEGRATED 4OZ POWER DELIVERY RAILS [Cast directly into the frame walls]
        color([1.0, 0.73, 0.2]) {
            translate([-(variable_bore_diameter/2 + 10), 0, 0])
                cube([30, power_rail_track_width, rifle_total_length * 0.45], center = true);
        }
    }
    
    // ---- PART D2: MAIN RIFLE MAIN HULL CASING (RIGHT HALF-SHELL) ---- [From Page 8, Step 10]
    translate([650, 0, -800]) rotate([0, 180, 0]) color([0.5, 0.5, 0.55]) {
        difference() {
            cylinder(h = rifle_total_length * 0.5, d = variable_bore_diameter + (armor_chassis_wall * 2), center = true);
            cylinder(h = rifle_total_length * 0.55, d = variable_bore_diameter, center = true);
            cylinder(h = rifle_total_length * 0.52, d = variable_bore_diameter + pzt_layer_thickness * 2, center = true);
            translate([0, -variable_bore_diameter, 0])
                cube([variable_bore_diameter * 2, variable_bore_diameter * 2, rifle_total_length], center = true);
        }
        
        color([1.0, 0.73, 0.2]) {
            translate([-(variable_bore_diameter/2 + 10), 0, 0])
                cube([30, power_rail_track_width, rifle_total_length * 0.45], center = true);
        }
    }

    // ---- PART D4: LOWER SLIDING GRIP & FOREARM COUPLING BLOCK ---- [From Page 8, Step 10]
    translate() color([0.3, 0.3, 0.32]) {
        difference() {
            // Rigid interface coupler that locks into the forearm skeletal frame
            cube([280, 320, 950], center = true);
            // Internal path routing the high-amperage telemetric bus connector
            cube([70, 70, 1000], center = true);
        }
    }
}

// Render Master Assembly to Parameter Workspace
Runner_D_Rifle_Forge();
