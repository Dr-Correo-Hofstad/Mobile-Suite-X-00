// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - CORE STRUCTURAL SECURITY
// COMPONENT VAULT: BANDAI CAST RUNNER G - BACKPLATE EXTENSIONS G3 & G4
// PRODUCTION SPEC: NORTHROP GRUMMAN AC DELCO AUTOMOTIVE HARDWARE PARITY
// DESIGN STYLE: NVIDIA FOUNDERS EDITION AGGRESSIVE PLANAR GEOMETRY MATRIX
// CONFIG METRIC: SCALED TITANIUM CASTS WITH EMBEDDED MOISTURE GASKETS (1:1 SCALE)
// ============================================================================

$fn = 120; // High-precision circular resolution segment count

// Structural Constants Scaled 1:1 for a 16.7-Meter Airframe Scale (mm)
backplate_total_length = 1380;           // Total longitudinal vertical height (mm)
capsule_outer_diameter = 2400;           // Fits over the 2310mm clear pod casing (mm)
armor_skin_thickness = 65;              // Solid TiAl heavy core backbone wall (mm)
gasket_groove_depth = 20;               // AC Delco form-molded gasket slot depth (mm)
gasket_groove_width = 45;               // AC Delco high-pressure seal tracking width (mm)
harness_conduit_width = 80;             // Cast-in 4oz copper logic trace track (mm)

module Runner_G_Bulkhead_Seal_Forge() {
    // Central Supply Injection Runner Axis (Molten Feed Line from Siphon Forge)
    color([0.22, 0.22, 0.25]) {
        cylinder(h = backplate_total_length * 1.5, d = 42, center = true);
        // Direct injection gates tracking straight into the part mold cavities
        translate() rotate() cylinder(h = 450, d = 22);
        translate([0, -300, -400]) rotate() cylinder(h = 450, d = 22);
    }
    
    // Instantiate Scaled AC Delco-Faceted Part Molds Symmetrically (Left & Right)
    Cast_AC_Delco_Bulkhead_Seals();
}

module Cast_AC_Delco_Bulkhead_Seals() {
    // ---- PART G3: LEFT BACKPLATE COLLAR EXTENSION & REAR VISOR SEAL ----
    translate([-600, 0, 450]) color([0.2, 0.2, 0.22]) { // Shadow Black Plating Spec
        difference() {
            // Main solid heavy-duty core backplate member with faceted outer shroud lines
            linear_extrude(height = backplate_total_length * 0.45, center = true, scale = [0.85, 1.0])
                polygon(points = [, 
                    [capsule_outer_diameter * 0.5 + 120, 80], 
                    [capsule_outer_diameter * 0.5 + 60, 40],   // 45-Degree Diamond Cut Bevel Step
                    [capsule_outer_diameter * 0.5 + 120, -80]
                ]);
            
            // Central channel boring (Fits tightly around the outer cockpit pod casing)
            cylinder(h = backplate_total_length, d = capsule_outer_diameter, center = true);
            
            // AC DELCO FORM-MOLDED GASKET GROOVE TRACKS [Milled continuously inside the seal face]
            for (offset = [-350, 0, 350]) {
                translate([0, 0, offset])
                    difference() {
                        cylinder(h = gasket_groove_width, d = capsule_outer_diameter + 10, center = true);
                        cylinder(h = gasket_groove_width + 5, d = capsule_outer_diameter - gasket_groove_depth, center = true);
                    }
            }
            
            // Continuous cast-in routing track for the 4oz solid-state wiring rails
            cube([harness_conduit_width, capsule_outer_diameter + 300, backplate_total_length], center = true);
            
            // Slicing profile tool to generate an asymmetrical half-shell part component
            translate([0, -capsule_outer_diameter, 0])
                cube([capsule_outer_diameter * 2, capsule_outer_diameter * 2, backplate_total_length * 2], center = true);
        }
    }
    
    // ---- PART G4: RIGHT BACKPLATE COLLAR EXTENSION & REAR VISOR SEAL ----
    translate([600, 0, -450]) rotate() color([0.2, 0.2, 0.22]) {
        difference() {
            linear_extrude(height = backplate_total_length * 0.45, center = true, scale = [0.85, 1.0])
                polygon(points = [, [capsule_outer_diameter * 0.5 + 120, 80], [capsule_outer_diameter * 0.5 + 60, 40], [capsule_outer_diameter * 0.5 + 120, -80]]);
            
            cylinder(h = backplate_total_length, d = capsule_outer_diameter, center = true);
            
            for (offset = [-350, 0, 350]) {
                translate([0, 0, offset])
                    difference() {
                        cylinder(h = gasket_groove_width, d = capsule_outer_diameter + 10, center = true);
                        cylinder(h = gasket_groove_width + 5, d = capsule_outer_diameter - gasket_groove_depth, center = true);
                    }
            }
            
            cube([harness_conduit_width, capsule_outer_diameter + 300, backplate_total_length], center = true);
            translate([0, -capsule_outer_diameter, 0])
                cube([capsule_outer_diameter * 2, capsule_outer_diameter * 2, backplate_total_length * 2], center = true);
        }
    }
}

// Render Master Component to Parameter Workspace
Runner_G_Bulkhead_Seal_Forge();
