// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - LOWER FRAME STABILIZATION
// COMPONENT VAULT: BANDAI CAST RUNNER A - HEEL STABILIZERS A5 & A6
// AUTOMOTIVE RETROFIT: GM IMPALA ACTUATORS & SILVERADO MEDIUM-DUTY PISTONS
// ENGINEERING SPEC: ACTIVE MAGLEV BALANCING & REGENERATIVE GROUND TRACTION
// ============================================================================

$fn = 100; // Circular segment fidelity resolution count

// Structural Constants Scaled 1:1 for a 16.7-Meter Airframe Scale (mm)
foot_armor_length = 2200;               // Total longitudinal heel-to-toe span (mm)
heel_stabilizer_width = 950;            // Transverse ground anchor footprint (mm)
piston_bore_diameter = 340;             // GM suspension piston casing width (mm)
titanium_plate_wall = 60;               // Solid protective outer armor gauge (mm)
harness_conduit_width = 80;             // Embedded 4oz copper logic trace track (mm)

module Runner_A_Feet_Forge() {
    // Central Supply Injection Runner Axis (Molten Feed Line from Siphon Forge)
    color([0.24, 0.24, 0.26]) {
        cylinder(h = foot_armor_length * 1.4, d = 42, center = true);
        // Direct feed gates tracking straight into the part mold cavities
        translate() rotate() cylinder(h = 550, d = 22);
        translate([0, 0, -900]) rotate() cylinder(h = 550, d = 22);
    }
    
    // Instantiate Scaled Part Molds Symmetrically
    Cast_Heel_Stabilizer_Plates();
}

module Cast_Heel_Stabilizer_Plates() {
    // ---- PART A5: LEFT HEEL STABILIZER HULL HALF-SHELL ---- [Page 6, Step 2]
    translate([-500, 0, 500]) color([0.8, 0.8, 0.85]) {
        difference() {
            // Main solid thick foot protective shell block
            cube([heel_stabilizer_width, foot_armor_length * 0.45, 450], center = true);
            
            // Cylindrical Ingestion Bay for the GM Impala Balancing Actuator Stems
            translate([0, 100, 0])
                cylinder(h = 500, d = piston_bore_diameter, center = true);
                
            // Secondary Mounting Chamber for the Silverado Leaf-Spring Pistons
            translate([0, -300, 0])
                cylinder(h = 500, d = piston_bore_diameter * 0.8, center = true);
            
            // Continuous cast-in routing track for the 4oz solid-state wiring rails
            cube([harness_conduit_width, foot_armor_length, 600], center = true);
        }
    }
    
    // ---- PART A6: RIGHT HEEL STABILIZER HULL HALF-SHELL ---- [Page 6, Step 1]
    translate([500, 0, -500]) rotate() color([0.8, 0.8, 0.85]) {
        difference() {
            cube([heel_stabilizer_width, foot_armor_length * 0.45, 450], center = true);
            translate([0, 100, 0])
                cylinder(h = 500, d = piston_bore_diameter, center = true);
            translate([0, -300, 0])
                cylinder(h = 500, d = piston_bore_diameter * 0.8, center = true);
            cube([harness_conduit_width, foot_armor_length, 600], center = true);
        }
    }
}

// Render Master Assembly to Parameter Workspace
Runner_A_Feet_Forge();
