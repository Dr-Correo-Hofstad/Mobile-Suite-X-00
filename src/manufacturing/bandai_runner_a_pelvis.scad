// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - LOWER TORSO REBALANCING MATRIX
// COMPONENT VAULT: BANDAI CAST RUNNER A - WAIST BRACKETS & PELVIC MOUNTS
// DESIGN METRIC: 1.45-METER INNER ELLIPTICAL CORE INTERLOCK INTEGRATION
// ELECTRICAL PARITY: ZERO-WIRE EMBEDDED CONDUITS FOR SQUARE-WAVE RETROFITTING
// ============================================================================

\$fn = 100; // Circular segment rendering fidelity

// Structural Constants Scaled 1:1 for a 16.7-Meter Airframe Envelope (mm)
pelvic_axis_height = 950;               // Total thickness of pelvic mount ring (mm)
ellipse_radius_a = 1450;                // Expanded clearance bounds via BIOCHEM-5000 (mm)
ellipse_radius_b = 1100;                // Transverse inner core axis bounds (mm)
pelvic_armor_wall = 70;                 // Solid Ti-6Al-4V skin wall gauge (mm)
harness_conduit_width = 80;             // Embedded 4oz copper logic bus track (mm)

module Runner_A_Pelvis_Forge() {
    // Central Material Feed Sprue (Conduit from the Siphon Forge)
    color([0.22, 0.22, 0.25]) {
        cylinder(h = pelvic_axis_height * 2.5, d = 45, center = true);
        // Direct feed gates tracking straight into the part mold cavities
        translate() rotate() cylinder(h = 550, d = 22);
        translate([0, 0, -800]) rotate() cylinder(h = 550, d = 22);
    }
    
    // Instantiate Scaled Part Cavities (Replicating Manual Sprues exactly)
    Cast_Pelvic_Anchor_Components();
}

module Cast_Pelvic_Anchor_Components() {
    // ---- PART A11: LEFT SIDE WAIST SKIRT BRACKET REINFORCEMENT ---- [Page 7, Step 6]
    translate([-600, 400, 600]) color([0.2, 0.4, 0.8]) {
        difference() {
            // Contoured structural block mounting the left side armor armor panels
            cube([450, 750, 450], center = true);
            // Sliding slot track for the solid-state skirt articulation hinges
            translate([0, 0, -50]) cube([150, 800, 150], center = true);
            // Internal conduit track for the zero-wire copper harness bus
            cube([harness_conduit_width, harness_conduit_width, 600], center = true);
        }
    }
    
    // ---- PART A12: RIGHT SIDE WAIST SKIRT BRACKET REINFORCEMENT ---- [Page 7, Step 6]
    translate([600, 400, 600]) rotate() color([0.2, 0.4, 0.8]) {
        difference() {
            cube([450, 750, 450], center = true);
            translate([0, 0, -50]) cube([150, 800, 150], center = true);
            cube([harness_conduit_width, harness_conduit_width, 600], center = true);
        }
    }

    // ---- PART A19: CENTRAL PELVIC MOUNT LOAD-RING ASSEMBLY ---- [Page 7, Step 6]
    // Integrates directly with the parametric elliptical core cavity boundaries
    translate([0, -350, -600]) color([0.7, 0.7, 0.72]) {
        difference() {
            // Outer manifold block mapping the core torso-to-hip junction
            scale([1.0, ellipse_radius_b / ellipse_radius_a, 1.0])
                cylinder(h = pelvic_axis_height, r = ellipse_radius_a + pelvic_armor_wall, center = true);
            
            // Parametric Inward Elliptical Cavity Boring (`pelvic_cavity_mapping.scad`)
            scale([1.0, ellipse_radius_b / ellipse_radius_a, 1.0])
                cylinder(h = pelvic_axis_height + 20, r = ellipse_radius_a, center = true);
            
            // Sub-surface wire conduits cast directly inside the load ring ribs
            for(angle =) {
                rotate([0, 0, angle]) translate([ellipse_radius_a + 20, 0, 0])
                    cube([harness_conduit_width, harness_conduit_width, pelvic_axis_height + 40], center = true);
            }
        }
    }
}

// Render Master Assembly to Parameter Workspace
Runner_A_Pelvis_Forge();
