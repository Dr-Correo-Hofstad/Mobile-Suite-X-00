// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - HEAD SENSOR REBALANCING MATRIX
// COMPONENT VAULT: BANDAI CAST RUNNER A - VIEWPORT CAMERAS A11 & A12
// DESIGN SPECS: BINOCULAR OPTICAL HOUSINGS FOR 1:1 SCALED 16.7M CHASSIS
// ELECTRICAL PARITY: WIRELESS INDUCTIVE DATA PATHS FOR SQUARE-WAVE RETROFITS
// ============================================================================

$fn = 80; // High-fidelity circular resolution segment count

// Structural Constants Scaled 1:1 for a 16.7-Meter Airframe Scale (mm)
viewport_block_height = 420;            // Total vertical axis thickness (mm)
eye_lens_bore_diameter = 140;           // Core optical eye-cam lens tracking width (mm)
armor_skin_thickness = 35;              // Solid TiAl defensive protective wall (mm)
harness_conduit_width = 40;             // Cast-in 4oz copper logic trace track (mm)
clip_bracket_width = 90;                // Structural instrumentation snap socket (mm)

module Runner_A_Head_Viewport_Forge() {
    // Central Supply Injection Runner Axis (Molten Feed Line from Siphon Forge)
    color([0.22, 0.22, 0.25]) {
        cylinder(h = viewport_block_height * 2.8, d = 35, center = true);
        // Direct injection gates tracking straight into the part mold cavities
        translate() rotate() cylinder(h = 350, d = 18);
        translate([0, 0, -350]) rotate() cylinder(h = 350, d = 18);
    }
    
    // Instantiate Scaled Structural Molds Symmetrically (Left & Right Halves)
    Cast_Internal_Viewport_Housings();
}

module Cast_Internal_Viewport_Housings() {
    // ---- PART A11: LEFT INTERNAL VIEWPORT CAMERA HOUSING ---- [Page 5, Step 01-2]
    translate([-300, 0, 400]) color([0.4, 0.4, 0.42]) { // Inner Frame Gunmetal Spec
        difference() {
            // Main solid sub-frame cheek and eye structural bone block
            cube([180, 240, viewport_block_height], center = true);
            
            // Central Optical Eye-Camera Clearance Bore (Houses tracking lenses)
            translate([0, 40, 0])
                rotate()
                    cylinder(h = 260, d = eye_lens_bore_diameter, center = true);
            
            // Precision Instrumentation Clip Port for the secondary sensor boards
            translate([-(180/2 - clip_bracket_width/2), 0, (viewport_block_height/2 - 60)])
                cube([clip_bracket_width, 120, 80], center = true);
                
            // Continuous cast-in routing track for the 4oz solid-state wiring rails
            cube([harness_conduit_width, 240 + 10, viewport_block_height + 10], center = true);
        }
    }
    
    // ---- PART A12: RIGHT INTERNAL VIEWPORT CAMERA HOUSING ---- [Page 5, Step 01-2]
    translate([300, 0, -400]) rotate() color([0.4, 0.4, 0.42]) {
        difference() {
            cube([180, 240, viewport_block_height], center = true);
            translate([0, 40, 0])
                rotate()
                    cylinder(h = 260, d = eye_lens_bore_diameter, center = true);
            translate([-(180/2 - clip_bracket_width/2), 0, (viewport_block_height/2 - 60)])
                cube([clip_bracket_width, 120, 80], center = true);
            cube([harness_conduit_width, 240 + 10, viewport_block_height + 10], center = true);
        }
    }
}

// Render Finished Module Workspace Framework
Runner_A_Head_Viewport_Forge();
