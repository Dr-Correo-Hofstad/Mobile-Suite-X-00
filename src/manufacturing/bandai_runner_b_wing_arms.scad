// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - AIRFRAME STRUCTURAL CORE
// COMPONENT VAULT: BANDAI CAST RUNNER B - WING JOINT PIVOT ARMS B1 & B2
// MANUFACTURING SPECS: SOLID-STATE INTEGRATED HARNESS CONDUIT TRACKS
// ENGINEERING SPECS: 4,800 Nm TORQUE COMPLIANCE FOR HIGH-G FLIGHT BINDERS
// ============================================================================

$fn = 100; // Circular segment rendering resolution count

// Structural Constants Scaled 1:1 for a 16.7-Meter Airframe Scale (mm)
wing_arm_length = 1650;                 // Total longitudinal joint axis height (mm)
hinge_pin_diameter = 180;               // Core structural crossbar attachment pin (mm)
bone_wall_thickness = 65;               // Solid TiAl structural wall thickness (mm)
harness_conduit_width = 80;             // Cast-in 4oz copper logic trace track (mm)

module Runner_B_Wing_Arm_Forge() {
    // Central Supply Injection Runner Axis (Molten Feed Line from Siphon Forge)
    color([0.22, 0.22, 0.24]) {
        cylinder(h = wing_arm_length * 2.2, d = 42, center = true);
        // Direct injection gates tracking straight into the part mold cavities
        translate([0, 0, 400]) rotate([0, 90, 0]) cylinder(h = 450, d = 22);
        translate([0, 0, -400]) rotate([0, 90, 0]) cylinder(h = 450, d = 22);
    }
    
    // Instantiate Scaled Structural Molds Symmetrically (Left & Right Halves)
    Cast_Internal_Wing_Pivot_Arms();
}

module Cast_Internal_Wing_Pivot_Arms() {
    // ---- PART B1: LEFT FLIGHT SURFACE ARTICULATION SHAFT ROD ---- [Page 5, Step 06-1]
    translate([-450, 0, 400]) color([0.7, 0.7, 0.75]) { // Standard Armor Grey Spec
        difference() {
            // Main solid heavy-duty extension connecting arm rod
            cube([140, 140, wing_arm_length], center = true);
            
            // Upper Backpack Mounting Pivot Hinge Clearance Pin Hole
            translate([0, 0, (wing_arm_length/2 - 120)])
                rotate([0, 90, 0])
                    cylinder(h = 200, d = hinge_pin_diameter, center = true);
            
            // Lower Wing Binder Connection Interlock Hinge Pin Hole
            translate([0, 0, -(wing_arm_length/2 - 120)])
                rotate([0, 90, 0])
                    cylinder(h = 200, d = hinge_pin_diameter, center = true);
            
            // Continuous cast-in routing track for the 4oz solid-state wiring rails
            cube([harness_conduit_width, 150, wing_arm_length + 10], center = true);
        }
    }
    
    // ---- PART B2: RIGHT FLIGHT SURFACE ARTICULATION SHAFT ROD ---- [Page 5, Step 06-1]
    translate([450, 0, -400]) rotate([0, 180, 0]) color([0.7, 0.7, 0.75]) {
        difference() {
            cube([140, 140, wing_arm_length], center = true);
            translate([0, 0, (wing_arm_length/2 - 120)])
                rotate([0, 90, 0])
                    cylinder(h = 200, d = hinge_pin_diameter, center = true);
            translate([0, 0, -(wing_arm_length/2 - 120)])
                rotate([0, 90, 0])
                    cylinder(h = 200, d = hinge_pin_diameter, center = true);
            cube([harness_conduit_width, 150, wing_arm_length + 10], center = true);
        }
    }
}

// Render Master Assembly to Parameter Workspace
Runner_B_Wing_Arm_Forge();
