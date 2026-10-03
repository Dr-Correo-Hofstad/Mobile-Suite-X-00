// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - AIRFRAME VISUAL OVERHAUL
// COMPONENT VAULT: BANDAI CAST RUNNER F - ABDOMINAL TRIM F3 & F4
// DESIGN STYLE: NVIDIA FOUNDERS EDITION AGGRESSIVE PLANAR GEOMETRY MATRIX
// PRODUCTION SPEC: NORTHROP GRUMMAN AC DELCO COMPRESSION LOCK PARITY
// CONFIG METRIC: SCALED TITANIUM CASTS WITH COCKPIT access TRACKS (1:1 SCALE)
// ============================================================================

$fn = 100; // High-precision circular resolution segment count

// Structural Constants Scaled 1:1 for a 16.7-Meter Airframe Scale (mm)
panel_total_length = 1120;               // Total longitudinal vertical height (mm)
panel_outer_width = 640;                 // Transverse forward abdominal shell envelope depth (mm)
armor_skin_thickness = 50;              // Solid TiAl protective plating wall (mm)
yoke_pocket_depth = 40;                 // AC Delco interlocking yoke socket depth (mm)
harness_conduit_width = 80;             // Cast-in 4oz copper logic trace track (mm)
capacitor_pocket_depth = 15;            // Sub-armor recessed housing pocket depth (mm)
capacitor_pocket_width = 140;           // Transverse MLCC array pocket width (mm)

module Runner_F_Abdominal_Trim_Forge() {
    // Central Supply Injection Runner Axis (Molten Feed Line from Siphon Forge)
    color([0.25, 0.25, 0.28]) {
        cylinder(h = panel_total_length * 1.5, d = 42, center = true);
        // Direct injection gates tracking straight into the part mold cavities
        translate() rotate() cylinder(h = 350, d = 22);
        translate([0, -200, -300]) rotate() cylinder(h = 350, d = 22);
    }
    
    // Instantiate Scaled NVIDIA-Faceted Part Molds Symmetrically (Left & Right)
    Cast_Outer_Abdominal_Trim();
}

module Cast_Outer_Abdominal_Trim() {
    // ---- PART F3: OUTER LEFT PROTECTIVE ABDOMINAL ENTRY COWL TRIM ----
    translate([-550, 0, 400]) color([0.85, 0.15, 0.15]) { // Red Lower Torso Armor Spec
        difference() {
            // Main cowl body extruded with complex faceted polygon profile
            // Replicates the sharp planar clean-breaks of modern high-performance GPU shrouds
            linear_extrude(height = panel_total_length * 0.45, center = true, scale = [0.85, 1.0])
                polygon(points = [, 
                    [panel_outer_width, 70], 
                    [panel_outer_width - 60, 35],   // 45-Degree Diamond Cut Bevel Step
                    [panel_outer_width, -70], 
                    [0, -30]
                ]);
            
            // Internal channel boring (Fits securely over the lower cockpit capsule face)
            cylinder(h = panel_total_length * 0.5, d = panel_outer_width - 30, center = true);
            
            // AC DELCO INTERLOCKING SUB-HATCH YOKE HOUSING [Milled cutouts for door mechanisms]
            translate([panel_outer_width/2 - 20, 0, 0])
                cube([yoke_pocket_depth, 100, 300], center = true);
            
            // SUB-ARMOR CYLINDRICAL BARREL CAPACITOR BAYS [Segmented rows cut inside the armor inner wall]
            for (z_offset = [-150, 0, 150]) {
                translate([(panel_outer_width * 0.5 - armor_skin_thickness + capacitor_pocket_depth/2 - 30), 0, z_offset])
                    cube([capacitor_pocket_depth, capacitor_pocket_width, 100], center = true);
            }
            
            // Continuous cast-in routing track for the 4oz solid-state wiring rails
            cube([harness_conduit_width, panel_outer_width, panel_total_length], center = true);
            
            // Slicing profile tool to generate an asymmetrical half-shell part component
            translate([0, -panel_outer_width, 0])
                cube([panel_outer_width * 2, panel_outer_width * 2, panel_total_length * 2], center = true);
        }
    }
    
    // ---- PART F4: OUTER RIGHT PROTECTIVE ABDOMINAL ENTRY COWL TRIM ----
    translate([550, 0, -400]) rotate([0, 180, 0]) color([0.85, 0.15, 0.15]) {
        difference() {
            linear_extrude(height = panel_total_length * 0.45, center = true, scale = [0.85, 1.0])
                polygon(points = [[0, 30], [panel_outer_width, 70], [panel_outer_width - 60, 35], [panel_outer_width, -70], [0, -30]]);
            
            cylinder(h = panel_total_length * 0.5, d = panel_outer_width - 30, center = true);
            
            translate([panel_outer_width/2 - 20, 0, 0])
                cube([yoke_pocket_depth, 100, 300], center = true);
            
            for (z_offset = [-150, 0, 150]) {
                translate([(panel_outer_width * 0.5 - armor_skin_thickness + capacitor_pocket_depth/2 - 30), 0, z_offset])
                    cube([capacitor_pocket_width, capacitor_pocket_depth, 100], center = true);
            }
            
            cube([harness_conduit_width, panel_outer_width, panel_total_length], center = true);
            translate([0, -panel_outer_width, 0])
                cube([panel_outer_width * 2, panel_outer_width * 2, panel_total_length * 2], center = true);
        }
    }
}

// Render Master Assembly to Parameter Workspace
Runner_F_Abdominal_Trim_Forge();
