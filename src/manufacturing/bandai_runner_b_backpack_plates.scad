// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - THRUST PROFILE MATING
// COMPONENT VAULT: BANDAI CAST RUNNER B - BACKPACK MOUNTING PLATES B19 & B20
// MANUFACTURING SPECS: SOLID-STATE CAST-IN INDUCTIVE POWER HARNESS CONTACTS
// ENGINEERING PARITY: HIGH-LOAD LOAD ENCLOSURE FOR 1:1 SCALED 16.7M CHASSIS
// ============================================================================

$fn = 100; // Circular segment resolution calculation count

// Sizing Constants Scaled 1:1 for a 16.7-Meter Airframe Scale (mm)
backpack_plate_height = 1450;           // Total vertical mounting span (mm)
wing_hinge_bore_diameter = 480;         // Primary wing arm pivot track width (mm)
titanium_armor_wall = 60;               // Heavy solid TiAl plate thickness (mm)
harness_conduit_width = 80;             // Cast-in 4oz copper logic trace track (mm)

module Runner_B_Backpack_Plates_Forge() {
    // Central Supply Injection Runner Axis (Molten Feed Line from Siphon Forge)
    color([0.22, 0.22, 0.24]) {
        cylinder(h = backpack_plate_height * 2.2, d = 42, center = true);
        // Direct injection gates tracking straight into the part mold cavities
        translate() rotate() cylinder(h = 450, d = 22);
        translate([0, 0, -500]) rotate() cylinder(h = 450, d = 22);
    }
    
    // Instantiate Scaled Structural Molds Symmetrically (Left & Right Halves)
    Cast_Backpack_Mounting_Plates();
}

module Cast_Backpack_Mounting_Plates() {
    // ---- PART B19: LEFT EXTERIOR BACKPACK STRUCTURAL PLATE ---- [Page 18, Step 10-1]
    translate([-400, 0, 450]) color([0.7, 0.7, 0.75]) { // Standard Armor Grey Spec
        difference() {
            // Main solid high-strength external mounting shell plate
            cube([350, 520, backpack_plate_height], center = true);
            
            // Integrated Wing Joint Articulation Hinge Axis Clearance Bore
            translate([0, (520/2 - titanium_armor_wall), (backpack_plate_height * 0.2)])
                rotate()
                    cylinder(h = 300, d = wing_hinge_bore_diameter, center = true);
            
            // Continuous cast-in contact pad slots for the 4oz power bus links
            cube([harness_conduit_width, 520 + 10, backpack_plate_height + 10], center = true);
            
            // Slicing profile tool to generate an asymmetrical half-shell part component
            translate([400, 0, 0])
                cube([800, 600, backpack_plate_height * 2], center = true);
        }
    }
    
    // ---- PART B20: RIGHT EXTERIOR BACKPACK STRUCTURAL PLATE ---- [Page 18, Step 10-1]
    translate([400, 0, -450]) rotate() color([0.7, 0.7, 0.75]) {
        difference() {
            cube([350, 520, backpack_plate_height], center = true);
            translate([0, (520/2 - titanium_armor_wall), (backpack_plate_height * 0.2)])
                rotate()
                    cylinder(h = 300, d = wing_hinge_bore_diameter, center = true);
            cube([harness_conduit_width, 520 + 10, backpack_plate_height + 10], center = true);
            translate([400, 0, 0])
                cube([800, 600, backpack_plate_height * 2], center = true);
        }
    }
}

// Render Master Assembly to Parameter Workspace
Runner_B_Backpack_Plates_Forge();
