// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - HEAD COMPONENT FORGE
// COMPONENT VAULT: BANDAI CAST RUNNER A - VISOR & CROWN FINS A1 & A2
// DESIGN STYLE: NVIDIA FOUNDERS EDITION AGGRESSIVE PLANAR GEOMETRY MATRIX
// TARGETING CONFIG: ASYMMETRICAL DUAL-EYE OPTICS (LENS #8 GREEN / LENS #3 CLEAR)
// ============================================================================

$fn = 100; // High-precision circular resolution segment count

// Structural Constants Scaled 1:1 for a 16.7-Meter Airframe Scale (mm)
crest_total_length = 580;                // Total vertical height of crown fins (mm)
visor_outer_width = 420;                 // Total transverse width of visor assembly (mm)
lens_radius_8 = 160;                    // r(+) Meniscus Lens #8 radius (mm)
lens_radius_3 = 140;                    // Clear Lens #3 radius (mm)
armor_skin_thickness = 45;              // Solid TiAl protective plating wall (mm)
capacitor_pocket_depth = 15;            // Sub-armor recessed housing pocket depth (mm)
capacitor_pocket_width = 90;            // Transverse MLCC array pocket width (mm)

module Runner_A_Head_Visor_Forge() {
    // Central Supply Injection Runner Axis (Molten Feed Line from Siphon Forge)
    color([0.25, 0.25, 0.28]) {
        cylinder(h = crest_total_length * 1.5, d = 35, center = true);
        translate() rotate() cylinder(h = 350, d = 18);
        translate([0, 200, -250]) rotate() cylinder(h = 350, d = 18);
    }
    
    // Instantiate Scaled NVIDIA-Faceted Visor & Crest Components
    Cast_NVIDIA_Faceted_Visor();
}

module Cast_NVIDIA_Faceted_Visor() {
    // ---- PART A1: PRIMARY FACETED OPTICAL TARGETING VISOR ---- [Page 4, Step 01-1]
    translate([-300, 0, 250]) color([0.2, 0.2, 0.22]) { // Shadow Black Main Visor Shroud
        difference() {
            // Aggressive low-poly exterior envelope (NVIDIA Founders Edition styling)
            cube([visor_outer_width, 180, 220], center = true);
            
            // ASYMMETRICAL internal LENS DRILLING
            // Right Eye Cavity: Meniscus Lens Bed #8 (Green Underlay Coating Node)
            translate([80, 40, 0]) {
                sphere(r = lens_radius_8);
                translate() sphere(r = lens_radius_8 + 10);
            }
            
            // Left Eye Cavity: Inverted Clear Sight Lens Bed #3
            translate([-80, 40, 0]) {
                sphere(r = lens_radius_3);
            }
            
            // Continuous cast-in routing track for the 4oz solid-state wiring rails
            cube([60, 200, 240], center = true);
        }
    }
    
    // ---- PART A2: OUTER PROTECTIVE CROWN STABILIZER FINS ---- [Page 4, Step 01-1]
    translate([300, 0, -250]) color([0.85, 0.85, 0.9]) { // Classic Pure White Crest Plating
        difference() {
            // Main crown fin extended with complex faceted polygon profile
            linear_extrude(height = crest_total_length * 0.45, center = true, scale = [0.7, 0.8])
                polygon(points = [, , 
,   // 45-Degree Diamond Cut Bevel Step
                    [180, -50], 
                    [0, -25]
                ]);
            
            // SUB-ARMOR CYLINDRICAL BARREL CAPACITOR BAYS [Milled inside the crest walls]
            for (z_offset = [-100, 0, 100]) {
                translate([60, 0, z_offset])
                    cube([capacitor_pocket_depth, capacitor_pocket_width, 60], center = true);
            }
        }
    }
}

// Render Master Component to Parameter Workspace
Runner_A_Head_Visor_Forge();
