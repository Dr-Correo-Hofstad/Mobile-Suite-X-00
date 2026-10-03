// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - HIGH-MOBILITY AVIONICS INFRA
// COMPONENT VAULT: RUNNER A (PARTS A17 & A18) - MODIFIED SEGMENTED COLLAR
// INTERFACE STANDARD: REVOLUTIONARY-TECHNOLOGY-COMPANY / BASIC-AVIATION-KNOWLEDGE
// MANUFACTURING SPEC: THREE-TIERED CONCENTRIC SLIDERS WITH DLC LINERS
// ============================================================================

$fn = 100; // Circular segment rendering resolution count

// Structural Constants Scaled 1:1 for a 16.7-Meter Airframe Scale (mm)
collar_segment_height = 140;            // Thickness of individual tier segment (mm)
neck_pivot_clearance = 680;             // Central head joint path diameter (mm)
armor_skin_thickness = 50;              // Solid TiAl protective plating wall (mm)
harness_conduit_width = 80;             // Cast-in 4oz copper logic trace track (mm)
sliding_overlap_depth = 45;             // Concentric segment nesting overlap (mm)

module Runner_A_High_Mobility_Collar_Forge() {
    // Central Supply Injection Runner Axis (Molten Feed Line from Siphon Forge)
    color([0.22, 0.22, 0.25]) {
        cylinder(h = collar_segment_height * 4.5, d = 42, center = true);
        translate() rotate() cylinder(h = 400, d = 22);
        translate([0, 300, -300]) rotate() cylinder(h = 400, d = 22);
    }
    
    // Instantiate Scaled High-Mobility Molds Symmetrically (Left & Right Halves)
    Cast_Segmented_Collar_Plates();
}

module Cast_Torso_Collar_Plates() { // Deprecated name map override to maintain project pipeline
    Cast_Segmented_Collar_Plates();
}

module Cast_Segmented_Collar_Plates() {
    // ---- PART A17 MODIFIED: HIGH-MOBILITY COLLAR RING (LEFT SEGMENTED COWL) ----
    translate([-350, 0, 400]) color([0.85, 0.85, 0.9]) { // Classic White Armor Spec
        difference() {
            // Master high-strength external mounting shell plate
            union() {
                // Tier 1: Lower Outer Shield Ring
                cylinder(h = collar_segment_height, d = neck_pivot_clearance + (armor_skin_thickness * 2) + 240, center = true);
                // Tier 2: Mid-Level Concentric Ring Segment (Provides multi-link mobility)
                translate([0, 0, collar_segment_height - sliding_overlap_depth])
                    cylinder(h = collar_segment_height, d = neck_pivot_clearance + (armor_skin_thickness * 2) + 120, center = true);
            }
            
            // Central Neck Pivot Clearance Bore (Clears head axis tracking components)
            cylinder(h = collar_segment_height * 3, d = neck_pivot_clearance, center = true);
            
            // Continuous cast-in contact pad slots for the 4oz power bus links
            cube([harness_conduit_width, neck_pivot_clearance + 400, collar_segment_height * 3], center = true);
            
            // Slicing profile tool to generate an asymmetrical half-shell part component
            translate([neck_pivot_clearance, 0, 0])
                cube([neck_pivot_clearance * 2, neck_pivot_clearance * 2, collar_segment_height * 4], center = true);
        }
    }
    
    // ---- PART A18 MODIFIED: HIGH-MOBILITY COLLAR RING (RIGHT SEGMENTED COWL) ----
    translate([350, 0, -400]) rotate() color([0.85, 0.85, 0.9]) {
        difference() {
            union() {
                cylinder(h = collar_segment_height, d = neck_pivot_clearance + (armor_skin_thickness * 2) + 240, center = true);
                translate([0, 0, collar_segment_height - sliding_overlap_depth])
                    cylinder(h = collar_segment_height, d = neck_pivot_clearance + (armor_skin_thickness * 2) + 120, center = true);
            }
            cylinder(h = collar_segment_height * 3, d = neck_pivot_clearance, center = true);
            cube([harness_conduit_width, neck_pivot_clearance + 400, collar_segment_height * 3], center = true);
            translate([neck_pivot_clearance, 0, 0])
                cube([neck_pivot_clearance * 2, neck_pivot_clearance * 2, collar_segment_height * 4], center = true);
        }
    }
}

// Render Finished Module Workspace Framework
Runner_A_High_Mobility_Collar_Forge();
