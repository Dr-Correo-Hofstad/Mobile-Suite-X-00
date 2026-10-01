// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - THRUST REBALANCING MATRIX
// COMPONENT VAULT: BANDAI CAST RUNNER F - BACKPLATES F25 & F26
// PACKAGING RE-ARCHITECTURE: SUB-ARMOR CAPACITOR RECESSED BANK INTEGRATION
// CONFIG METRIC: SCALED TITANIUM CASTS (1:1 ACTUAL METRIC UP-SCALE)
// ============================================================================

$fn = 100; // Circular segment rendering resolution count

// Structural Constants Scaled 1:1 for a 16.7-Meter Airframe Scale (mm)
backplate_total_length = 1550;          // Total longitudinal vertical height (mm)
nozzle_clearance_diameter = 880;        // Clearance bore to fit over B21 exhaust (mm)
armor_skin_thickness = 50;              // Solid TiAl protective plating wall (mm)
harness_conduit_width = 80;             // Cast-in 4oz copper logic trace track (mm)
capacitor_pocket_depth = 15;            // Sub-armor recessed housing pocket depth (mm)
capacitor_pocket_width = 140;           // Transverse MLCC array pocket width (mm)

module Runner_F_Backplate_Forge() {
    // Central Supply Injection Runner Axis (Molten Feed Line from Siphon Forge)
    color([0.24, 0.24, 0.26]) {
        cylinder(h = backplate_total_length * 2.2, d = 42, center = true);
        // Direct injection gates tracking straight into the part mold cavities
        translate() rotate() cylinder(h = 450, d = 22);
        translate([0, 0, -450]) rotate() cylinder(h = 450, d = 22);
    }
    
    // Instantiate Scaled Skeutomorphic Part Molds Symmetrically (Left & Right)
    Cast_Outer_Backplate_Armor();
}

module Cast_Outer_Backplate_Armor() {
    // ---- PART F25: REAR LEFT PROTECTIVE BACKPLATE COWL SHIELD ---- [Page 18, Step 10-3]
    translate([-450, 0, 450]) color([0.7, 0.7, 0.75]) { // Standard Armor Grey Spec
        difference() {
            // Main solid heavy-duty rear upper hull shell block
            cylinder(h = backplate_total_length * 0.45, d = nozzle_clearance_diameter + (armor_skin_thickness * 2) + 120, center = true);
            
            // Central Internal Clearance Bore (Fits over B21 silent nozzle)
            cylinder(h = backplate_total_length * 0.5, d = nozzle_clearance_diameter, center = true);
            
            // SUB-ARMOR RECESSED CAPACITOR POCKETS [Segmented rows cut inside the armor inner wall]
            for (z_offset = [-200, 0, 200]) {
                translate([0, (nozzle_clearance_diameter/2 + capacitor_pocket_depth/2), z_offset])
                    cube([capacitor_pocket_width, capacitor_pocket_depth, 120], center = true);
            }
            
            // Continuous cast-in routing track for the 4oz solid-state wiring rails
            cube([harness_conduit_width, nozzle_clearance_diameter * 2, backplate_total_length], center = true);
            
            // Slicing profile tool to generate an asymmetrical half-shell part component
            translate([0, -nozzle_clearance_diameter, 0])
                cube([nozzle_clearance_diameter * 2, nozzle_clearance_diameter * 2, backplate_total_length * 2], center = true);
        }
    }
    
    // ---- PART F26: REAR RIGHT PROTECTIVE BACKPLATE COWL SHIELD ---- [Page 18, Step 10-3]
    translate([450, 0, -450]) rotate() color([0.7, 0.7, 0.75]) {
        difference() {
            cylinder(h = backplate_total_length * 0.45, d = nozzle_clearance_diameter + (armor_skin_thickness * 2) + 120, center = true);
            cylinder(h = backplate_total_length * 0.5, d = nozzle_clearance_diameter, center = true);
            
            for (z_offset = [-200, 0, 200]) {
                translate([0, (nozzle_clearance_diameter/2 + capacitor_pocket_depth/2), z_offset])
                    cube([capacitor_pocket_width, capacitor_pocket_depth, 120], center = true);
            }
            
            cube([harness_conduit_width, nozzle_clearance_diameter * 2, backplate_total_length], center = true);
            translate([0, -nozzle_clearance_diameter, 0])
                cube([nozzle_clearance_diameter * 2, nozzle_clearance_diameter * 2, backplate_total_length * 2], center = true);
        }
    }
}

// Render Master Assembly to Parameter Workspace
Runner_F_Backplate_Forge();
