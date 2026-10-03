// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - AVIONICS ISOLATION CORE
// COMPONENT VAULT: RUNNER G (PARTS G7 & G8) - PELVIC LOGIC BREAKER COLLARS
// SPEC INTEGRATION: REVOLUTIONARY-TECHNOLOGY-COMPANY / SNAP-CIRCUITS BUFFER
// ENGINEERING SPECS: 24K GOLD LATTICE FRACTURE FIREWALLS (1:1 SCALE)
// ============================================================================

$fn = 100; // High-precision rendering circular segment resolution count

// Structural Scaling Parameters (1:1 Dimensions for a 16.7m Mecha Architecture)
breaker_bay_height = 480;               // Total vertical thickness of junction box (mm)
pelvic_collar_diameter = 1380;          // Upper pelvic load ring mounting width (mm)
gold_lattice_cavity_w = 120;            // Inside slot for the snap-circuit bridge (mm)
harness_conduit_width = 80;             // Main cast-in 4oz copper logic rail track (mm)
insulation_barrier_wall = 45;           // Flame-sprayed ceramic shielding gauge (mm)

module Runner_G_Breaker_Bay_Forge() {
    // Central Supply Injection Runner Axis (Molten Feed Line from Siphon Forge)
    color([0.22, 0.22, 0.25]) {
        cylinder(h = breaker_bay_height * 2.5, d = 42, center = true);
        translate() rotate() cylinder(h = 450, d = 22);
        translate([0, 0, -500]) rotate() cylinder(h = 450, d = 22);
    }
    
    // Instantiate Scaled Isolation Firewalls Symmetrically (Left & Right Leg Links)
    Cast_Pelvic_Breaker_Collars();
}

module Cast_Pelvic_Breaker_Collars() {
    // ---- PART G7: INTERNAL LEFT PELVIC SNAP-CIRCUIT BREAKER BAY ---- [Page 17, Step 09]
    translate([-400, 0, 400]) color([0.35, 0.35, 0.38]) { // Inner Frame Dark Spec
        difference() {
            // Main solid heavy-duty protection vault shield collar
            cylinder(h = breaker_bay_height, d = pelvic_collar_diameter * 0.45, center = true);
            
            // Central clearance bore path for the 4oz solid-state power lines
            cylinder(h = breaker_bay_height + 20, d = pelvic_collar_diameter * 0.45 - (insulation_barrier_wall * 2), center = true);
            
            // INTERNAL SNAP-CIRCUIT LATTICE VAULTS [Isolates the 24K gold fracture blocks]
            for (angle =) {
                rotate([0, 0, angle]) translate([(pelvic_collar_diameter * 0.15), 0, 0])
                    cube([gold_lattice_cavity_w, gold_lattice_cavity_w, breaker_bay_height + 10], center = true);
            }
            
            // Continuous cast-in routing track for the main logic bus paths
            cube([harness_conduit_width, pelvic_collar_diameter, breaker_bay_height + 20], center = true);
        }
    }
    
    // ---- PART G8: INTERNAL RIGHT PELVIC SNAP-CIRCUIT BREAKER BAY ---- [Page 17, Step 09]
    translate([400, 0, -400]) rotate() color([0.35, 0.35, 0.38]) {
        difference() {
            cylinder(h = breaker_bay_height, d = pelvic_collar_diameter * 0.45, center = true);
            cylinder(h = breaker_bay_height + 20, d = pelvic_collar_diameter * 0.45 - (insulation_barrier_wall * 2), center = true);
            for (angle =) {
                rotate([0, 0, angle]) translate([(pelvic_collar_diameter * 0.15), 0, 0])
                    cube([gold_lattice_cavity_w, gold_lattice_cavity_w, breaker_bay_height + 10], center = true);
            }
            cube([harness_conduit_width, pelvic_collar_diameter, breaker_bay_height + 20], center = true);
        }
    }
}

// Render Master Component to Parametric Design Space
Runner_G_Breaker_Bay_Forge();
