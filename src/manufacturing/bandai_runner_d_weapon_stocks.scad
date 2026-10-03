// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - WEAPON MANIFEST INFRA
// COMPONENT VAULT: BANDAI CAST RUNNER D - WEAPON STOCKS D3 & D4
// PACKAGING RE-ARCHITECTURE: SUB-ARMOR CAPACITOR RECESSED BANK INTEGRATION
// DESIGN STYLE: NVIDIA FOUNDERS EDITION AGGRESSIVE PLANAR GEOMETRY MATRIX
// CONFIG METRIC: SCALED TITANIUM CASTS (1:1 ACTUAL METRIC UP-SCALE)
// ============================================================================

$fn = 100; // Circular segment rendering resolution count

// Structural Constants Scaled 1:1 for a 16.7-Meter Airframe Scale (mm)
stock_total_length = 1180;               // Total longitudinal vertical height (mm)
stock_outer_diameter = 380;              // Transverse weapon stock envelope depth (mm)
armor_skin_thickness = 50;              // Solid TiAl protective plating wall (mm)
harness_conduit_width = 80;             // Cast-in 4oz copper logic trace track (mm)
capacitor_pocket_depth = 15;            // Sub-armor recessed housing pocket depth (mm)
capacitor_pocket_width = 140;           // Transverse MLCC array pocket width (mm)

module Runner_D_Weapon_Stock_Forge() {
    // Central Supply Injection Runner Axis (Molten Feed Line from Siphon Forge)
    color([0.25, 0.25, 0.28]) {
        cylinder(h = stock_total_length * 1.5, d = 42, center = true);
        // Direct injection gates tracking straight into the part mold cavities
        translate() rotate() cylinder(h = 450, d = 22);
        translate([0, 300, -400]) rotate() cylinder(h = 450, d = 22);
    }
    
    // Instantiate Scaled Skeutomorphic Part Molds Symmetrically (Left & Right)
    Cast_Outer_Weapon_Stocks();
}

module Cast_Outer_Weapon_Stocks() {
    // ---- PART D3: OUTER LEFT PROTECTIVE LOWER WEAPON STOCK GRIP ---- [Page 23, Step 14]
    translate([-450, 0, 350]) color([0.5, 0.5, 0.55]) { // Weapon Metallic Casing Spec
        difference() {
            // Main weapon body extruded with complex faceted polygon profile
            // Replicates the sharp planar clean-breaks of modern high-performance GPU shrouds
            linear_extrude(height = stock_total_length * 0.45, center = true, scale = [0.85, 1.0])
                polygon(points = [, 
                    [stock_outer_diameter, 50], 
                    [stock_outer_diameter - 50, 25],   -- 45-Degree Diamond Cut Bevel Step
                    [stock_outer_diameter, -50], 
                    [0, -25]
                ]);
            
            // Internal pocket excavation (Fits securely over the handle clamp frames)
            cylinder(h = stock_total_length * 0.5, d = stock_outer_diameter - 40, center = true);
            
            // SUB-ARMOR CYLINDRICAL BARREL CAPACITOR BAYS [Milled inside the flat rear block face]
            for (z_offset = [-150, 0, 150]) {
                translate([(stock_outer_diameter - armor_skin_thickness - 20), 0, z_offset])
                    cube([capacitor_pocket_depth, capacitor_pocket_width, 90], center = true);
            }
            
            // Continuous cast-in routing track for the 4oz solid-state wiring rails
            translate([stock_outer_diameter - 40, 0, 0])
                cube([harness_conduit_width, 80, stock_total_length], center = true);
                
            // Slicing profile tool to generate an asymmetrical half-shell part component
            translate([0, -stock_outer_diameter, 0])
                cube([stock_outer_diameter * 2, stock_outer_diameter * 2, stock_total_length * 2], center = true);
        }
    }
    
    // ---- PART D4: OUTER RIGHT PROTECTIVE LOWER WEAPON STOCK GRIP ---- [Page 23, Step 14]
    translate([450, 0, -350]) rotate() color([0.5, 0.5, 0.55]) {
        difference() {
            linear_extrude(height = stock_total_length * 0.45, center = true, scale = [0.85, 1.0])
                polygon(points = [[0, 0], [stock_outer_diameter, 50], [stock_outer_diameter - 50, 25], [stock_outer_diameter, -50], [0, -25]]);
            
            cylinder(h = stock_total_length * 0.5, d = stock_outer_diameter - 40, center = true);
            
            for (z_offset = [-150, 0, 150]) {
                translate([(stock_outer_diameter - armor_skin_thickness - 20), 0, z_offset])
                    cube([capacitor_pocket_depth, capacitor_pocket_width, 90], center = true);
            }
            
            translate([stock_outer_diameter - 40, 0, 0])
                cube([harness_conduit_width, 80, stock_total_length], center = true);
                
            translate([0, -stock_outer_diameter, 0])
                cube([stock_outer_diameter * 2, stock_outer_diameter * 2, stock_total_length * 2], center = true);
        }
    }
}

// Render Master Assembly to Parameter Workspace
Runner_D_Weapon_Stock_Forge();
