// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - WEAPON FABRICATION CORES
// COMPONENT VAULT: BANDAI CAST RUNNER D - UPPER RIFLE RAILS D11 & D12
// RE-ARCHITECTURE PACKAGING: BARREL-TYPE SUB-ARMOR CAPACITOR STORAGE RECESSES
// SYSTEM COMPATIBILITY: CONTINUOUS OPEN-ENDED DOUBLE-VENTED DISCHARGE PARITY
// ============================================================================

$fn = 100; // Circular segment rendering resolution count

// Structural Constants Scaled 1:1 for a 16.7-Meter Airframe Scale (mm)
rail_total_length = 3200;                // Total longitudinal vertical height (mm)
rail_outer_width = 320;                 // Transverse casing base width (mm)
armor_skin_thickness = 50;              // Solid TiAl protective plating wall (mm)
harness_conduit_width = 40;             // Cast-in 4oz copper logic trace track (mm)
capacitor_pocket_depth = 15;            // Sub-armor recessed housing pocket depth (mm)
capacitor_pocket_width = 110;           // Transverse MLCC array pocket width (mm)

module Runner_D_Rifle_Rail_Forge() {
    // Central Supply Injection Runner Axis (Molten Feed Line from Siphon Forge)
    color([0.25, 0.25, 0.28]) {
        cylinder(h = rail_total_length * 1.5, d = 42, center = true);
        // Direct injection gates tracking straight into the part mold cavities
        translate() rotate() cylinder(h = 450, d = 22);
        translate([0, 0, -450]) rotate() cylinder(h = 450, d = 22);
    }
    
    // Instantiate Scaled Skeutomorphic Part Molds Symmetrically (Left & Right)
    Cast_Upper_Weapon_Rails();
}

module Cast_Upper_Weapon_Rails() {
    // ---- PART D11: UPPER LEFT RIFLE CASING RAIL SPINE ---- [Page 8, Step 10]
    translate([-350, 0, 450]) color([0.5, 0.5, 0.55]) { // Weapon Metallic Casing Spec
        difference() {
            // Main solid heavy-duty rifle reinforcement spine panel
            cube([rail_outer_width, 240, rail_total_length * 0.45], center = true);
            
            // Pressure Expansion Slot Cutout (Vents hot ionized air for open-bore)
            cube([rail_outer_width - (armor_skin_thickness * 2), 300, rail_total_length * 0.3], center = true);
            
            // SUB-ARMOR RECESSED CAPACITOR POCKETS [Segmented rows cut inside the rail lining]
            for (z_offset = [-200, 0, 200]) {
                translate([(rail_outer_width/2 - armor_skin_thickness + capacitor_pocket_depth/2), 0, z_offset])
                    cube([capacitor_pocket_depth, capacitor_pocket_width, 140], center = true);
            }
            
            // Continuous cast-in routing track for the 4oz solid-state wiring rails
            cube([harness_conduit_width, 300, rail_total_length], center = true);
            
            // Slicing profile tool to generate an asymmetrical half-shell part component
            translate([rail_outer_width, 0, 0])
                cube([rail_outer_width * 2, 500, rail_total_length], center = true);
        }
    }
    
    // ---- PART D12: UPPER RIGHT RIFLE CASING RAIL SPINE ---- [Page 8, Step 10]
    translate([350, 0, -450]) rotate() color([0.5, 0.5, 0.55]) {
        difference() {
            cube([rail_outer_width, 240, rail_total_length * 0.45], center = true);
            cube([rail_outer_width - (armor_skin_thickness * 2), 300, rail_total_length * 0.3], center = true);
            
            for (z_offset = [-200, 0, 200]) {
                translate([(rail_outer_width/2 - armor_skin_thickness + capacitor_pocket_depth/2), 0, z_offset])
                    cube([capacitor_pocket_depth, capacitor_pocket_width, 140], center = true);
            }
            
            cube([harness_conduit_width, 300, rail_total_length], center = true);
            translate([rail_outer_width, 0, 0])
                cube([rail_outer_width * 2, 500, rail_total_length], center = true);
        }
    }
}

// Render Master Assembly to Parameter Workspace
Runner_D_Rifle_Rail_Forge();
