// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - AIRFRAME STRUCTURAL CORE
// COMPONENT VAULT: BANDAI CAST RUNNER G - SHOULDER LINKAGES G4 & G5
// CIRCUIT RULES: FULL SQUARE-WAVE RETROFITTING & INDUCTIVE POWER PLUGS
// MASS PARITY: FINAL ARM WEIGHT EXTRACTED BEFORE GLOBAL LEG REBALANCING
// ============================================================================

$fn = 100; // Circular segment rendering resolution count

// Sizing Constants Scaled 1:1 for a 16.7-Meter Airframe Scale (mm)
shoulder_link_height = 850;             // Total longitudinal axis height (mm)
pivot_bore_diameter = 420;              // Internal rotational joint bearing path (mm)
titanium_frame_wall = 65;               // Solid TiAl structural wall thickness (mm)
harness_conduit_width = 80;             // Cast-in 4oz copper logic trace track (mm)

module Runner_G_Shoulder_Forge() {
    // Central Supply Injection Runner Axis (Molten Feed Line from Siphon Forge)
    color([0.22, 0.22, 0.25]) {
        cylinder(h = shoulder_link_height * 2.5, d = 42, center = true);
        // Direct injection gates tracking straight into the part mold cavities
        translate([0, 0, 500]) rotate([0, 90, 0]) cylinder(h = 500, d = 22);
        translate([0, 0, -500]) rotate([0, 90, 0]) cylinder(h = 500, d = 22);
    }
    
    // Instantiate Scaled Skeutomorphic Part Molds Symmetrically
    Cast_Internal_Shoulder_Linkages();
}

module Cast_Internal_Shoulder_Linkages() {
    // ---- PART G4: INTERNAL LEFT SHOULDER SWIVEL LINKAGE ---- [Page 4, Step 05-1]
    translate([-450, 0, 500]) color([0.35, 0.35, 0.38]) { // Inner Frame Gunmetal Spec
        difference() {
            // Heavy-duty structural yoke block mounting to the chest cowl
            cube([340, 460, shoulder_link_height * 0.5], center = true);
            
            // Concentric Internal Boring for the Forward Extension Bearing Track
            translate([0, 0, -50])
                rotate([90, 0, 0])
                    cylinder(h = 500, d = pivot_bore_diameter, center = true);
            
            // Continuous cast-in routing track for the 4oz solid-state wiring rails
            cube([harness_conduit_width, 500, shoulder_link_height], center = true);
        }
    }
    
    // ---- PART G5: INTERNAL RIGHT SHOULDER SWIVEL LINKAGE ---- [Page 4, Step 05-1]
    translate([450, 0, -500]) rotate([0, 0, 180]) color([0.35, 0.35, 0.38]) {
        difference() {
            cube([340, 460, shoulder_link_height * 0.5], center = true);
            translate([0, 0, -50])
                rotate([90, 0, 0])
                    cylinder(h = 500, d = pivot_bore_diameter, center = true);
            cube([harness_conduit_width, 500, shoulder_link_height], center = true);
        }
    }
}

// Render Master Assembly to Parameter Workspace
Runner_G_Shoulder_Forge();
