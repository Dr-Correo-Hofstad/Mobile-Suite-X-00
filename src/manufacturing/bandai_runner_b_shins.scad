// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - LOWER SKELTAL ARCHITECTURE
// COMPONENT VAULT: BANDAI CAST RUNNER B - SHIN BACKBONES B11 & B12
// MANUFACTURING SPEC: SOLID-STATE CAST-IN POWER RAILS FOR SQUARE-WAVE BUS
// REAL-WORLD REF: 1/144 HG FIGHTING ACTION STEP 1 & 2 / 16.7M CHASSIS airframe
// ============================================================================

$fn = 100; // Circular segment fidelity calculation count

// Sizing Constants Scaled 1:1 for a 16.7-Meter Airframe Scale (mm)
shin_backbone_length = 3600;            // Total vertical shin core height (mm)
ankle_housing_diameter = 580;           // Lower joint cycloidal reducer track width (mm)
skeletal_core_wall = 70;                // Thick TiAl internal structural bone thickness (mm)
harness_conduit_width = 80;             // Embedded 4oz copper logic trace track width (mm)

module Runner_B_Shin_Forge() {
    // Central Supply Injection Runner Axis (Molten Feed Line from Siphon Forge)
    color([0.22, 0.22, 0.24]) {
        cylinder(h = shin_backbone_length * 1.4, d = 42, center = true);
        // Direct injection gates tracking straight into the part mold cavities
        translate([0, 0, 800]) rotate([0, 90, 0]) cylinder(h = 500, d = 22);
        translate([0, 0, -800]) rotate([0, 90, 0]) cylinder(h = 500, d = 22);
    }
    
    // Instantiate Scaled Structural Part Molds Symmetrically
    Cast_Internal_Shin_Backbones();
}

module Cast_Internal_Shin_Backbones() {
    // ---- PART B11: INTERNAL LEFT SHIN BACKBONE MOUNT STRUCTURAL CORE ---- [Page 6, Step 1]
    translate([-450, 0, 0]) color([0.4, 0.4, 0.42]) {
        difference() {
            // Main solid internal shin backbone structural column
            cube([360, 360, shin_backbone_length], center = true);
            
            // Lower Integrated Cycloidal Ankle Housing Socket Bore
            translate([0, 0, -(shin_backbone_length/2 - ankle_housing_diameter/2 - 50)])
                rotate([0, 90, 0])
                    cylinder(h = 380, d = ankle_housing_diameter, center = true);
            
            // Continuous cast-in routing track for the 4oz solid-state wiring rails
            cube([harness_conduit_width, 380, shin_backbone_length + 10], center = true);
        }
    }
    
    // ---- PART B12: INTERNAL RIGHT SHIN BACKBONE MOUNT STRUCTURAL CORE ---- [Page 6, Step 2]
    translate([450, 0, 0]) rotate([0, 0, 180]) color([0.4, 0.4, 0.42]) {
        difference() {
            cube([360, 360, shin_backbone_length], center = true);
            translate([0, 0, -(shin_backbone_length/2 - ankle_housing_diameter/2 - 50)])
                rotate([0, 90, 0])
                    cylinder(h = 380, d = ankle_housing_diameter, center = true);
            cube([harness_conduit_width, 380, shin_backbone_length + 10], center = true);
        }
    }
}

// Render Master Assembly to Parameter Workspace
Runner_B_Shin_Forge();
