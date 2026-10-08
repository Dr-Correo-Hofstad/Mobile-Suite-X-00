// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - LIMB SKELETON PROTECTION
// COMPONENT VAULT: BANDAI CAST RUNNER B - FOREARM CORES B11 & B12
// PACKAGING RE-ARCHITECTURE: DUAL-MOTION EMA DRIVE CHAMBER INTEGRATION
// DESIGN STYLE: NVIDIA FOUNDERS EDITION AGGRESSIVE PLANAR GEOMETRIC MATRIX
// CONFIG METRIC: SCALED TITANIUM CASTS WITH COIL TRACKS (1:1 ACTUAL METRIC)
// ============================================================================

$fn = 100; // High-precision circular resolution segment count

// Structural Constants Scaled 1:1 for a 16.7-Meter Airframe Scale (mm)
forearm_total_length = 1080;             // Total longitudinal vertical height (mm)
ema_chamber_diameter = 290;             // Internal cavity diameter for EMA housing (mm)
armor_skin_thickness = 65;              // Solid TiAl protective plating wall (mm)
harness_conduit_width = 80;             // Cast-in 4oz copper logic trace track (mm)
capacitor_pocket_depth = 15;            // Sub-armor recessed housing pocket depth (mm)
capacitor_pocket_width = 140;           // Transverse MLCC array pocket width (mm)

module Runner_B_Forearm_Core_Forge() {
    // Central Supply Injection Runner Axis (Molten Feed Line from Siphon Forge)
    color([0.25, 0.25, 0.28]) {
        cylinder(h = forearm_total_length * 1.5, d = 42, center = true);
        // Direct injection gates tracking straight into the part mold cavities
        translate() rotate() cylinder(h = 350, d = 22);
        translate([0, -200, -300]) rotate() cylinder(h = 350, d = 22);
    }
    
    // Instantiate Scaled Skeutomorphic Part Molds Symmetrically (Left & Right)
    Cast_Internal_Forearm_Cores();
}

module Cast_Internal_Forearm_Cores() {
    // ---- PART B11: INTERNAL LEFT STRUCTURAL UPPER FOREARM CORE ----
    translate([-450, 0, 400]) color([0.35, 0.35, 0.38]) { // Inner Frame Dark Spec
        difference() {
            // Main solid heavy-duty low-poly outer bone block envelope
            cylinder(h = forearm_total_length * 0.45, d = ema_chamber_diameter + (armor_skin_thickness * 2), center = true);
            
            // DUAL-MOTION EMA CYLINDER EXCAVATION [Bored out for power-by-wire cores]
            cylinder(h = forearm_total_length * 0.5, d = ema_chamber_diameter, center = true);
            
            // SUB-ARMOR RECESSED CAPACITOR POCKETS [Segmented rows cut inside the armor inner wall]
            for (z_offset = [-150, 0, 150]) {
                translate([0, (ema_chamber_diameter/2 - armor_skin_thickness + capacitor_pocket_depth/2 + 20), z_offset])
                    cube([capacitor_pocket_width, capacitor_pocket_depth, 100], center = true);
            }
            
            // Continuous cast-in routing track for the 4oz solid-state wiring rails
            cube([harness_conduit_width, ema_chamber_diameter + 100, forearm_total_length], center = true);
            
            // Slicing profile tool to generate an asymmetrical half-shell part component
            translate([0, -ema_chamber_diameter, 0])
                cube([ema_chamber_diameter * 2, ema_chamber_diameter * 2, forearm_total_length * 2], center = true);
        }
    }
    
    // ---- PART B12: INTERNAL RIGHT STRUCTURAL UPPER FOREARM CORE ----
    translate([450, 0, -400]) rotate() color([0.35, 0.35, 0.38]) {
        difference() {
            cylinder(h = forearm_total_length * 0.45, d = ema_chamber_diameter + (armor_skin_thickness * 2), center = true);
            cylinder(h = forearm_total_length * 0.5, d = ema_chamber_diameter, center = true);
            
            for (z_offset = [-150, 0, 150]) {
                translate([0, (ema_chamber_diameter/2 - armor_skin_thickness + capacitor_pocket_depth/2 + 20), z_offset])
                    cube([capacitor_pocket_width, capacitor_pocket_depth, 100], center = true);
            }
            
            cube([harness_conduit_width, ema_chamber_diameter + 100, forearm_total_length], center = true);
            translate([0, -ema_chamber_diameter, 0])
                cube([ema_chamber_diameter * 2, ema_chamber_diameter * 2, forearm_total_length * 2], center = true);
        }
    }
}

// Render Master Assembly to Parameter Workspace
Runner_B_Forearm_Core_Forge();
