// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - OPTICAL TARGETING CORES
// COMPONENT VAULT: BANDAI CAST RUNNER D - SCOPE HOUSINGS D17 & D18
// DESIGN STYLE: NVIDIA FOUNDERS EDITION PLANAR FACETED GEOMETRY MATRIX
// LENS PARITY: MENISCUS CONFIGURATION #8 MATRIX (r1(+), r2(+) FIELD EXPANDERS)
// ============================================================================

$fn = 120; // High-fidelity circular resolution segment count

// Structural Constants Scaled 1:1 for a 16.7-Meter Airframe Scale (mm)
scope_total_length = 980;                // Total longitudinal optical barrel length (mm)
scope_outer_diameter = 340;              // Transverse low-poly housing depth (mm)
lens_radius_1 = 180;                    // r1(+) Convex outer radius profile (mm)
lens_radius_2 = 210;                    // r2(+) Concave inward radius profile (mm)
armor_skin_thickness = 45;              // Solid TiAl protective plating wall (mm)
capacitor_pocket_depth = 15;            // Sub-armor recessed housing pocket depth (mm)
capacitor_pocket_width = 110;           // Transverse MLCC array pocket width (mm)

module Runner_D_Scope_Housing_Forge() {
    // Central Supply Injection Runner Axis (Molten Feed Line from Siphon Forge)
    color([0.25, 0.25, 0.28]) {
        cylinder(h = scope_total_length * 1.5, d = 35, center = true);
        translate() rotate() cylinder(h = 350, d = 18);
        translate([0, 200, -300]) rotate() cylinder(h = 350, d = 18);
    }
    
    // Instantiate Scaled NVIDIA-Faceted Part Molds Symmetrically (Left & Right)
    Cast_NVIDIA_Faceted_Scopes();
}

module Cast_NVIDIA_Faceted_Scopes() {
    // ---- PART D17: UPPER LEFT RIFLE TARGETING SCOPE HOUSING ---- [Page 22, Step 13-3]
    translate([-400, 0, 350]) color([0.5, 0.5, 0.55]) { // Weapon Metallic Casing Spec
        difference() {
            // Aggressive faceted exterior envelope (NVIDIA Founders Edition styling)
            linear_extrude(height = scope_total_length * 0.45, center = true, scale = [0.8, 1.0])
                polygon(points = [, 
                    [scope_outer_diameter, 60], 
                    [scope_outer_diameter - 40, 30], // 45-Degree Planar Bevel Step
                    [scope_outer_diameter, -60], 
                    [0, -40]
                ]);
            
            // LENS MATRIX BED #8 CUTOUT [Grounds the r1(+) and r2(+) meniscus lens geometry]
            translate([scope_outer_diameter * 0.3, 0, 0]) {
                // Front Convex Face r1(+)
                sphere(r = lens_radius_1);
                // Inward Concave Face r2(+) offset to form the negative meniscus curve
                translate([35, 0, 0])
                    sphere(r = lens_radius_2);
            }
            
            // SUB-ARMOR CYLINDRICAL BARREL CAPACITOR BAYS [Milled inside the armor lining]
            for (z_offset = [-120, 0, 120]) {
                translate([(scope_outer_diameter - armor_skin_thickness - 15), 0, z_offset])
                    cube([capacitor_pocket_depth, capacitor_pocket_width, 80], center = true);
            }
            
            // Slicing profile tool to generate an asymmetrical half-shell part component
            translate([0, -scope_outer_diameter, 0])
                cube([scope_outer_diameter * 3, scope_outer_diameter * 2, scope_total_length * 2], center = true);
        }
    }
    
    // ---- PART D18: UPPER RIGHT RIFLE TARGETING SCOPE HOUSING ---- [Page 22, Step 13-3]
    translate([400, 0, -350]) rotate() color([0.5, 0.5, 0.55]) {
        difference() {
            linear_extrude(height = scope_total_length * 0.45, center = true, scale = [0.8, 1.0])
                polygon(points = [, [scope_outer_diameter, 60], [scope_outer_diameter - 40, 30], [scope_outer_diameter, -60], [0, -40]]);
            
            translate([scope_outer_diameter * 0.3, 0, 0]) {
                sphere(r = lens_radius_1);
                translate([35, 0, 0])
                    sphere(r = lens_radius_2);
            }
            
            for (z_offset = [-120, 0, 120]) {
                translate([(scope_outer_diameter - armor_skin_thickness - 15), 0, z_offset])
                    cube([capacitor_pocket_depth, capacitor_pocket_width, 80], center = true);
            }
            
            translate([0, -scope_outer_diameter, 0])
                cube([scope_outer_diameter * 3, scope_outer_diameter * 2, scope_total_length * 2], center = true);
        }
    }
}

// Render Master Assembly to Parameter Workspace
Runner_D_Scope_Housing_Forge();
