// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - THRUST REBALANCING MATRIX
// COMPONENT VAULT: BANDAI CAST RUNNER B - BACKPACK HOUSING & BOOSTER JUNCTION
// MANUFACTURING STANDARD: SOLID-STATE EMBEDDED ELECTRICAL HARNESSING
// COMPATIBILITY: ELECTROACOUSTIC PROPULSION & CYMATICS VORTEX MANIFOLDS
// ============================================================================

$fn = 100; // Circular segment fidelity

// Global Dimensional Constants (1:1 Metrics for 16.7m Airframe)
spine_mount_height = 1450;              // Vertical backpack bracket span (mm)
booster_junction_diameter = 1100;       // Spherical launch rocket interface neck (mm)
titanium_armor_wall = 60;               // Structural casing thickness (mm)
solid_state_bus_width = 80;             // 4oz Copper embedded harness guide path (mm)
waveguide_bore_width = 240;             // Electroacoustic gas oscillation core (mm)

module Runner_B_Backpack_Forge() {
    // Central Supply Runner Frame (Feeds Molten Alloy from Siphon Forge)
    color([0.22, 0.22, 0.26]) {
        cylinder(h = spine_mount_height * 2.2, d = 45, center = true);
        // Lateral injection gates connecting straight to parts molds
        translate() rotate([0, 90, 0]) cylinder(h = 500, d = 22);
        translate([0, 0, -900]) rotate([0, 90, 0]) cylinder(h = 500, d = 22);
    }
    
    // Instantiate Scaled Part Cavities
    Cast_Backpack_Thrust_Sections();
}

module Cast_Backpack_Thrust_Sections() {
    // ---- PART B19: LEFT SPINAL BASE MOUNT PLATE ---- [Page 18, Step 10-1]
    translate([-450, 0, 800]) color([0.7, 0.7, 0.75]) {
        difference() {
            // High-strength thick protective backplate structure
            cube([350, 500, spine_mount_height], center = true);
            // Embedded conduit channels for the zero-wire copper harness
            cube([solid_state_bus_width, 600, spine_mount_height + 10], center = true);
            // Pre-cast bolt configurations for the flexible wing joint arms
            translate([0, 150, 400]) rotate([0, 90, 0]) cylinder(h = 400, d = 60, center = true);
        }
    }
    
    // ---- PART B20: RIGHT SPINAL BASE MOUNT PLATE ---- [Page 18, Step 10-1]
    translate() rotate() color([0.7, 0.7, 0.75]) {
        difference() {
            cube([350, 500, spine_mount_height], center = true);
            cube([solid_state_bus_width, 600, spine_mount_height + 10], center = true);
            translate([0, 150, 400]) rotate([0, 90, 0]) cylinder(h = 400, d = 60, center = true);
        }
    }

    // ---- PART B21: CENTRAL ACOUSTIC PROPULSION MANIFOLD ---- [Page 18, Step 10-3]
    translate([0, -650, -600]) color([0.4, 0.4, 0.45]) {
        difference() {
            // Heavy-duty intake junction bracket coupling with the launch sphere
            cylinder(h = 850, d = booster_junction_diameter + (titanium_armor_wall * 2), center = true);
            // Main wave driver chamber bore (Isolates gas during sound excitation)
            cylinder(h = 860, d = booster_junction_diameter, center = true);
            // Focused electroacoustic waveguide ports routing to exhaust nozzles
            for (angle = [0 : 90 : 270]) {
                rotate([0, 0, angle]) translate([booster_junction_diameter/2, 0, 0])
                    cube([waveguide_bore_width, waveguide_bore_width, 900], center = true);
            }
        }
    }
}

// Render Core Runner to Parametric CAD Design Workspace
Runner_B_Backpack_Forge();
