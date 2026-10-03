// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - LIMB DEFENSE CORES
// COMPONENT VAULT: BANDAI CAST RUNNER F - SHOULDER WRAPPERS F11 & F12
// PACKAGING RE-ARCHITECTURE: INTEGRATED VAPOR CHAMBER COOLING VENTS
// DESIGN STYLE: NVIDIA FOUNDERS EDITION AGGRESSIVE PLANAR GEOMETRIC MATRIX
// CONFIG METRIC: SCALED TITANIUM CASTS WITH RADIATOR SLOTS (1:1 ACTUAL METRIC)
// ============================================================================

$fn = 100; // High-precision circular resolution segment count

// Structural Constants Scaled 1:1 for a 16.7-Meter Airframe Scale (mm)
wrapper_total_length = 980;              // Total longitudinal vertical height (mm)
wrapper_outer_width = 580;               // Transverse shoulder armor shell envelope width (mm)
armor_skin_thickness = 50;              // Solid TiAl protective plating wall (mm)
vent_slot_width = 30;                   // Integrated cooling vent slot width (mm)
harness_conduit_width = 80;             // Cast-in 4oz copper logic trace track (mm)
capacitor_pocket_depth = 15;            // Sub-armor recessed housing pocket depth (mm)
capacitor_pocket_width = 140;           // Transverse MLCC array pocket width (mm)

module Runner_F_Shoulder_Wrapper_Forge() {
    // Central Supply Injection Runner Axis (Molten Feed Line from Siphon Forge)
    color([0.25, 0.25, 0.28]) {
        cylinder(h = wrapper_total_length * 1.5, d = 42, center = true);
        // Direct injection gates tracking straight into the part mold cavities
        translate() rotate() cylinder(h = 350, d = 22);
        translate([0, -200, -300]) rotate() cylinder(h = 350, d = 22);
    }
    
    // Instantiate Scaled NVIDIA-Faceted Part Molds Symmetrically (Left & Right)
    Cast_Outer_Shoulder_Wrappers();
}

module Cast_Outer_Shoulder_Wrappers() {
    // ---- PART F11: OUTER LEFT PROTECTIVE UPPER SHOULDER ARMOR WRAPPER ----
    translate([-500, 0, 400]) color([0.85, 0.85, 0.9]) { // Classic Pure White Plating Spec
        difference() {
            // Main cowl body extruded with complex faceted polygon profile
            // Replicates the sharp planar clean-breaks of modern high-performance GPU shrouds
            linear_extrude(height = wrapper_total_length * 0.45, center = true, scale = [0.85, 1.0])
                polygon(points = [, 
                    [wrapper_outer_width, 70], 
                    [wrapper_outer_width - 60, 35],   // 45-Degree Diamond Cut Bevel Step
                    [wrapper_outer_width, -70], 
                    [0, -30]
                ]);
            
            // Internal pocket excavation (Fits securely over the shoulder inner trim cowlings)
            cylinder(h = wrapper_total_length * 0.5, d = wrapper_outer_width - 30, center = true);
            
            // ACTIVE VAPOR CHAMBER COOLING VENTS [Segmented exhaust slots milled through front armor skin]
            for (y_offset = [-120 : 60 : 120]) {
                translate([wrapper_outer_width/2 - 40, y_offset, 0])
                    cube([60, vent_slot_width, wrapper_total_length * 0.3], center = true);
            }
            
            // SUB-ARMOR CYLINDRICAL BARREL CAPACITOR BAYS [Segmented rows cut inside the inner wall]
            for (z_offset = [-150, 0, 150]) {
                translate([(wrapper_outer_width * 0.5 - armor_skin_thickness + capacitor_pocket_depth/2 - 40), 0, z_offset])
                    cube([capacitor_pocket_depth, capacitor_pocket_width, 100], center = true);
            }
            
            // Continuous cast-in routing track for the 4oz solid-state wiring rails
            cube([harness_conduit_width, wrapper_outer_width, wrapper_total_length], center = true);
            
            // Slicing profile tool to generate an asymmetrical half-shell part component
            translate([0, -wrapper_outer_width, 0])
                cube([wrapper_outer_width * 2, wrapper_outer_width * 2, wrapper_total_length * 2], center = true);
        }
    }
    
    // ---- PART F12: OUTER RIGHT PROTECTIVE UPPER SHOULDER ARMOR WRAPPER ----
    translate([500, 0, -400]) rotate() color([0.85, 0.85, 0.9]) {
        difference() {
            linear_extrude(height = wrapper_total_length * 0.45, center = true, scale = [0.85, 1.0])
                polygon(points = [, [wrapper_outer_width, 70], [wrapper_outer_width - 60, 35], [wrapper_outer_width, -70], [0, -30]]);
            
            cylinder(h = wrapper_total_length * 0.5, d = wrapper_outer_width - 30, center = true);
            
            for (y_offset = [-120 : 60 : 120]) {
                translate([wrapper_outer_width/2 - 40, y_offset, 0])
                    cube([60, vent_slot_width, wrapper_total_length * 0.3], center = true);
            }
            
            for (z_offset = [-150, 0, 150]) {
                translate([(wrapper_outer_width * 0.5 - armor_skin_thickness + capacitor_pocket_depth/2 - 40), 0, z_offset])
                    cube([capacitor_pocket_width, capacitor_pocket_depth, 100], center = true);
            }
            
            cube([harness_conduit_width, wrapper_outer_width, wrapper_total_length], center = true);
            translate([0, -wrapper_outer_width, 0])
                cube([wrapper_outer_width * 2, wrapper_outer_width * 2, wrapper_total_length * 2], center = true);
        }
    }
}

// Render Master Assembly to Parameter Workspace
Runner_F_Shoulder_Wrapper_Forge();
