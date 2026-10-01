// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - HEAD SENSOR REBALANCING MATRIX
// COMPONENT VAULT: BANDAI CAST RUNNER A - CAMERA BRACKETS A1 & VISOR CAPS A2
// MANUFACTURING SPECS: SOLID-STATE INTEGRATED COUPLING LINKAGES
// INTERFACE SPECS: MAIN OPTICAL VISOR FRAMES & 35mm HEAT DEFENSE WALLS
// ============================================================================

$fn = 100; // Circular segment rendering resolution count

// Structural Constants Scaled 1:1 for a 16.7-Meter Airframe Scale (mm)
visor_cap_length = 680;                 // Total horizontal width of visor cap (mm)
visor_cap_height = 340;                 // Vertical thickness of forehead plate (mm)
camera_bore_diameter = 180;             // Main optical lens block clearance path (mm)
armor_skin_thickness = 35;              // Solid TiAl protective wall thickness (mm)
harness_conduit_width = 40;             // Cast-in 4oz copper logic trace track (mm)

module Runner_A_Head_Camera_Forge() {
    // Central Supply Injection Runner Axis (Molten Feed Line from Siphon Forge)
    color([0.22, 0.22, 0.25]) {
        cylinder(h = visor_cap_length * 2.2, d = 35, center = true);
        // Direct injection gates tracking straight into the part mold cavities
        translate([0, 0, 300]) rotate([0, 90, 0]) cylinder(h = 350, d = 18);
        translate([0, 0, -300]) rotate([0, 90, 0]) cylinder(h = 350, d = 18);
    }
    
    // Instantiate Scaled Skeutomorphic Part Molds Symmetrically
    Cast_Head_Camera_Components();
}

module Cast_Head_Camera_Components() {
    // ---- PART A1: UPPER HEAD MAIN CAMERA LENS BRACKET ---- [Page 7, Step 7 / Page 5, Step 01-1]
    translate([-300, 0, 300]) color([0.4, 0.4, 0.42]) { // Inner Frame Gunmetal Spec
        difference() {
            // Rigid sub-frame block holding the multi-sensor camera lens arrays
            cube([200, 240, visor_cap_height], center = true);
            
            // Central Optical Camera Core Bore (Clears tracking lens systems)
            cylinder(h = visor_cap_height + 20, d = camera_bore_diameter, center = true);
            
            // Continuous cast-in routing track for the 4oz solid-state wiring rails
            cube([harness_conduit_width, 240 + 10, visor_cap_height + 10], center = true);
        }
    }
    
    // ---- PART A2: SENSOR VISOR HOUSING CAP (FOREHEAD CROWN) ---- [Page 7, Step 7 / Page 5, Step 01-1]
    translate([300, 0, -300]) color([0.85, 0.85, 0.9]) { // Classic White Armor Spec
        difference() {
            // Tapered external protective forehead guard shield block
            scale([1.0, 0.4, 1.0])
                cylinder(h = visor_cap_height, r1 = visor_cap_length * 0.5, r2 = visor_cap_length * 0.35, center = true);
            
            // Internal pocket excavation (Leaves the rigid 35mm defensive wall)
            scale([1.0, 0.4, 1.0])
                cylinder(h = visor_cap_height + 20, r1 = (visor_cap_length * 0.5) - armor_skin_thickness, r2 = (visor_cap_length * 0.35) - armor_skin_thickness, center = true);
            
            // Cast-in guide channel for the solid-state harness copper bus tracks
            cube([harness_conduit_width, visor_cap_length, visor_cap_height + 10], center = true);
            
            // Splitting cut to generate clean asymmetrical shell panel face
            translate([0, -visor_cap_length, 0])
                cube([visor_cap_length * 2, visor_cap_length * 2, visor_cap_height * 2], center = true);
        }
    }
}

// Render Master Assembly to Parameter Workspace
Runner_A_Head_Camera_Forge();
