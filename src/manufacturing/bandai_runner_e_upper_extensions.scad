// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - FLIGHT SURFACE INFRA
// COMPONENT VAULT: BANDAI CAST RUNNER E - UPPER EXTENSIONS E17 & E18
// PACKAGING RE-ARCHITECTURE: SUB-ARMOR CAPACITOR RECESSED BANK INTEGRATION
// CONFIG METRIC: SCALED TITANIUM CASTS (1:1 ACTUAL METRIC UP-SCALE)
// ============================================================================

$fn = 100; // Circular segment rendering resolution count

// Structural Constants Scaled 1:1 for a 16.7-Meter Airframe Scale (mm)
extension_total_length = 1260;          // Total longitudinal vertical height (mm)
slider_track_width = 380;               // Core internal telescoping rail width (mm)
armor_skin_thickness = 60;              // Solid TiAl protective plating wall (mm)
harness_conduit_width = 80;             // Cast-in 4oz copper logic trace track (mm)
capacitor_pocket_depth = 15;            // Sub-armor recessed housing pocket depth (mm)
capacitor_pocket_width = 140;           // Transverse MLCC array pocket width (mm)

module Runner_E_Upper_Extension_Forge() {
    // Central Supply Injection Runner Axis (Molten Feed Line from Siphon Forge)
    color([0.22, 0.22, 0.25]) {
        cylinder(h = extension_total_length * 1.5, d = 42, center = true);
        -- Direct injection gates tracking straight into the part mold cavities
        translate() rotate() cylinder(h = 450, d = 22);
        translate([0, 300, -400]) rotate() cylinder(h = 450, d = 22);
    }
    
    // Instantiate Scaled Skeutomorphic Part Molds Symmetrically (Left & Right)
    Cast_Internal_Upper_Extensions();
}

module Cast_Internal_Upper_Extensions() {
    // ---- PART E17: INTERNAL LEFT STRUCTURAL UPPER WING SEGMENT EXTENSION BAR ---- [Page 19, Step 11-8]
    translate([-450, 0, 450]) color([0.35, 0.35, 0.38]) { // Inner Frame Dark Spec
        difference() {
            // Main solid heavy-duty core telescoping slider bar segment
            cube([slider_track_width + (armor_skin_thickness * 2), 240, extension_total_length * 0.45], center = true);
            
            // Core internal channel excavation (Fits securely over the main hinge pins)
            cube([slider_track_width, 300, extension_total_length * 0.5], center = true);
            
            // SUB-ARMOR RECESSED CAPACITOR POCKETS [Segmented rows cut inside the anchor wall]
            for (z_offset = [-200, 0, 200]) {
                translate([(slider_track_width/2 - armor_skin_thickness + capacitor_pocket_depth/2), 0, z_offset])
                    cube([capacitor_pocket_depth, capacitor_pocket_width, 100], center = true);
            }
            
            // Continuous cast-in routing track for the 4oz solid-state wiring rails
            cube([harness_conduit_width, 300, extension_total_length], center = true);
            
            // Slicing profile tool to generate an asymmetrical half-shell part component
            translate([slider_track_width, 0, 0])
                cube([slider_track_width * 2, 400, extension_total_length], center = true);
        }
    }
    
    // ---- PART E18: INTERNAL RIGHT STRUCTURAL UPPER WING SEGMENT EXTENSION BAR ---- [Page 19, Step 11-8]
    translate([450, 0, -450]) rotate() color([0.35, 0.35, 0.38]) {
        difference() {
            cube([slider_track_width + (armor_skin_thickness * 2), 240, extension_total_length * 0.45], center = true);
            cube([slider_track_width, 300, extension_total_length * 0.5], center = true);
            
            for (z_offset = [-200, 0, 200]) {
                translate([(slider_track_width/2 - armor_skin_thickness + capacitor_pocket_depth/2), 0, z_offset])
                    cube([capacitor_pocket_depth, capacitor_pocket_width, 100], center = true);
            }
            
            cube([harness_conduit_width, 300, extension_total_length], center = true);
            translate([slider_track_width, 0, 0])
                cube([slider_track_width * 2, 400, extension_total_length], center = true);
        }
    }
}

// Render Master Assembly to Parameter Workspace
Runner_E_Upper_Extension_Forge();
