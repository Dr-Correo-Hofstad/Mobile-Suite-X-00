// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - COCKPIT DOCKING MATRIX
// COMPONENT VAULT: BANDAI CAST RUNNER C - COCKPIT HATCH FRAMES C1 & C2
// PACKAGING RE-ARCHITECTURE: SUB-ARMOR CAPACITOR RECESSED BANK INTEGRATION
// CONFIG METRIC: SCALED TITANIUM CASTS (1:1 ACTUAL METRIC UP-SCALE)
// ============================================================================

$fn = 100; // Circular segment rendering resolution count

// Structural Constants Scaled 1:1 for a 16.7-Meter Airframe Scale (mm)
hatch_frame_length = 1650;               // Total longitudinal vertical height (mm)
hatch_outer_diameter = 2500;             // Outer clear track bounding width (mm)
armor_skin_thickness = 50;              // Solid TiAl protective plating wall (mm)
harness_conduit_width = 80;             // Cast-in 4oz copper logic trace track (mm)
capacitor_pocket_depth = 15;            // Sub-armor recessed housing pocket depth (mm)
capacitor_pocket_width = 140;           // Transverse MLCC array pocket width (mm)

module Runner_C_Chest_Hatch_Forge() {
    // Central Supply Injection Runner Axis (Molten Feed Line from Siphon Forge)
    color([0.22, 0.22, 0.24]) {
        cylinder(h = hatch_frame_length * 1.5, d = 42, center = true);
        // Direct injection gates tracking straight into the part mold cavities
        translate() rotate() cylinder(h = 450, d = 22);
        translate([0, 300, -400]) rotate() cylinder(h = 450, d = 22);
    }
    
    // Instantiate Scaled Skeutomorphic Part Molds Symmetrically (Left & Right)
    Cast_Outer_Hatch_Frames();
}

module Cast_Outer_Hatch_Frames() {
    // ---- PART C1: UPPER TORSO CHEST COLLAR EXTENSION (LEFT HATCH FRAME) ---- [Page 5, Step 02-1]
    translate([-600, 0, 450]) color([0.2, 0.4, 0.8]) { // Cobalt Blue Accent Spec
        difference() {
            // Main solid heavy-duty cockpit access enclosure framing block
            cylinder(h = hatch_frame_length * 0.45, d1 = hatch_outer_diameter + 100, d2 = hatch_outer_diameter, center = true);
            
            // Core internal channel boring (Fits securely over the 2400mm cockpit cylinder pod outer wall)
            cylinder(h = hatch_frame_length * 0.5, d = 2400, center = true);
            
            // SUB-ARMOR RECESSED CAPACITOR POCKETS [Segmented rows cut inside the frame walls]
            for (z_offset = [-250, 0, 250]) {
                translate([0, (2400/2 - armor_skin_thickness + capacitor_pocket_depth/2), z_offset])
                    cube([capacitor_pocket_width, capacitor_pocket_depth, 120], center = true);
            }
            
            // Continuous cast-in routing track for the 4oz solid-state wiring rails
            cube([harness_conduit_width, hatch_outer_diameter + 120, hatch_frame_length], center = true);
            
            // Slicing profile tool to generate an asymmetrical half-shell part component
            translate([0, -hatch_outer_diameter, 0])
                cube([hatch_outer_diameter * 2, hatch_outer_diameter * 2, hatch_frame_length * 2], center = true);
        }
    }
    
    // ---- PART C2: UPPER TORSO CHEST COLLAR EXTENSION (RIGHT HATCH FRAME) ---- [Page 5, Step 02-1]
    translate([600, 0, -450]) rotate() color([0.2, 0.4, 0.8]) {
        difference() {
            cylinder(h = hatch_frame_length * 0.45, d1 = hatch_outer_diameter + 100, d2 = hatch_outer_diameter, center = true);
            cylinder(h = hatch_frame_length * 0.5, d = 2400, center = true);
            
            for (z_offset = [-250, 0, 250]) {
                translate([0, (2400/2 - armor_skin_thickness + capacitor_pocket_depth/2), z_offset])
                    cube([capacitor_pocket_width, capacitor_pocket_depth, 120], center = true);
            }
            
            cube([harness_conduit_width, hatch_outer_diameter + 120, hatch_frame_length], center = true);
            translate([0, -hatch_outer_diameter, 0])
                cube([hatch_outer_diameter * 2, hatch_outer_diameter * 2, hatch_frame_length * 2], center = true);
        }
    }
}

// Render Master Assembly to Parameter Workspace
Runner_C_Chest_Hatch_Forge();
