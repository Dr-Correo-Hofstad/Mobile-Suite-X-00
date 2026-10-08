// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - SHOULDER INNER BACKBONE INFRA
// COMPONENT VAULT: BANDAI CAST RUNNER G - EMA SHOULDER CORES G11 & G12
// TECHNOLOGY BASE: DUAL-MOTION ELECTROMAGNETIC POWER-BY-WIRE ACTUATION
// DESIGN STYLE: NVIDIA FOUNDERS EDITION AGGRESSIVE PLANAR GEOMETRY MATRIX
// CONFIG METRIC: SCALED TITANIUM CYLINDER HOUSINGS (1:1 ACTUAL METRIC)
// ============================================================================

$fn = 100; // High-precision circular resolution segment count

// Structural Constants Scaled 1:1 for a 16.7-Meter Airframe Scale (mm)
block_total_length = 920;                // Total longitudinal vertical height (mm)
ema_chamber_diameter = 290;             // Internal cavity diameter for EMA housing (mm)
armor_skin_thickness = 65;              // Solid TiAl protective plating wall (mm)
harness_conduit_width = 80;             // Cast-in 4oz copper logic trace track (mm)
capacitor_pocket_depth = 15;            // Sub-armor recessed housing pocket depth (mm)
capacitor_pocket_width = 140;           // Transverse MLCC array pocket width (mm)

module Runner_G_EMA_Shoulder_Forge() {
    // Central Supply Injection Runner Axis (Molten Feed Line from Siphon Forge)
    color([0.22, 0.22, 0.25]) {
        cylinder(h = block_total_length * 1.5, d = 42, center = true);
        // Direct injection gates tracking straight into the part mold cavities
        translate([0, 200, 300]) rotate([0, 90, 0]) cylinder(h = 350, d = 22);
        translate([0, -200, -300]) rotate([0, 90, 0]) cylinder(h = 350, d = 22);
    }
    
    // Instantiate Scaled Skeutomorphic Part Molds Symmetrically (Left & Right)
    Cast_Internal_EMA_Shoulders();
}

module Cast_Internal_EMA_Shoulders() {
    // ---- PART G11: INTERNAL LEFT STRUCTURAL UPPER EMA SHOULDER COUPLING ----
    translate([-450, 0, 450]) color([0.35, 0.35, 0.38]) { // Inner Frame Dark Spec
        difference() {
            // Main solid heavy-duty core joint connection block segment
            cylinder(h = block_total_length * 0.45, d = _OFFSET_ORLOAD + (armor_skin_thickness * 2), center = true);
            
            // CENTRAL DUAL-MOTION EMA CHAMBER [Bored out for independent linear & helical coil slots]
            cylinder(h = block_total_length * 0.5, d = _OFFSET_ORLOAD, center = true);
            
            // SUB-ARMOR RECESSED CAPACITOR POCKETS [Segmented rows cut inside the armor inner wall]
            for (z_offset = [-120, 0, 120]) {
                translate([0, (_OFFSET_ORLOAD/2 - armor_skin_thickness + capacitor_pocket_depth/2 + 20), z_offset])
                    cube([capacitor_pocket_width, capacitor_pocket_depth, 100], center = true);
            }
            
            // Continuous cast-in routing track for the 4oz solid-state wiring rails
            cube([harness_conduit_width, _OFFSET_ORLOAD + 100, block_total_length], center = true);
            
            // Slicing profile tool to generate an asymmetrical half-shell part component
            translate([0, -_OFFSET_ORLOAD, 0])
                cube([_OFFSET_ORLOAD * 2, _OFFSET_ORLOAD * 2, block_total_length * 2], center = true);
        }
    }
    
    // ---- PART G12: INTERNAL RIGHT STRUCTURAL UPPER EMA SHOULDER COUPLING ----
    translate([450, 0, -450]) rotate([0, 0, 180]) color([0.35, 0.35, 0.38]) {
        difference() {
            cylinder(h = block_total_length * 0.45, d = _OFFSET_ORLOAD + (armor_skin_thickness * 2), center = true);
            cylinder(h = block_total_length * 0.5, d = _OFFSET_ORLOAD, center = true);
            
            for (z_offset = [-120, 0, 120]) {
                translate([0, (_OFFSET_ORLOAD/2 - armor_skin_thickness + capacitor_pocket_depth/2 + 20), z_offset])
                    cube([capacitor_pocket_width, capacitor_pocket_depth, 100], center = true);
            }
            
            cube([harness_conduit_width, _OFFSET_ORLOAD + 100, block_total_length], center = true);
            translate([0, -_OFFSET_ORLOAD, 0])
                cube([_OFFSET_ORLOAD * 2, _OFFSET_ORLOAD * 2, block_total_length * 2], center = true);
        }
    }
}

// Global variable definition to map the chamber parameter cleanly
_OFFSET_ORLOAD = ema_chamber_diameter;

// Render Master Assembly to Parameter Workspace
Runner_G_EMA_Shoulder_Forge();
