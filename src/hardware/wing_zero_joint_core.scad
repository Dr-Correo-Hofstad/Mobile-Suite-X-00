// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO - ENDLESS WALTZ MASTER ARCHITECTURE
// SUB-MODULE: REINFORCED JOINT MATRIX & VARIABLE-RELUCTANCE INTERLOCK
// DESIGN PARAMETERS: FULL SQUARE-WAVE SNAP-CIRCUIT BUS POWER STABILITY
// TARGET SCALE: 16.7 METERS OVERALL HEAD HEIGHT
// ============================================================================

\$fn = 120; // Structural rendering fidelity

// Global Environmental & Dimensional Constraints
chassis_height = 16700;                 // 16.7 Meter vertical limit (mm)
pelvic_inner_radius_a = 1450;           // Expanded inner ellipse bounds (mm) via BIOCHEM-5000
pelvic_inner_radius_b = 1100;           // Transverse inner ellipse bounds (mm)
pelvic_armor_thickness = 70;            // Optimized Ti-6Al-4V skin thickness (mm)
clearance_offset = 15;                  // Solid-State wiring harness isolation gap (mm)

// Motor & Driveline Physical Envelope (Upscaled High-Output GM Axial-Flux)
motor_casing_diameter = 980;            // External stator core width (mm)
motor_casing_length = 620;              // Longitudinal core axis footprint (mm)
driveshaft_channel_diameter = 320;      // Active variable-reluctance channel path (mm)

module Master_Pelvic_Assembly() {
    difference() {
        // 1. Exterior Protective Hull Plating
        color([0.7, 0.7, 0.75]) {
            render() scale([1.0, 1.0, 1.0])
                cylinder(h = motor_casing_length + (pelvic_armor_thickness * 2), 
                         r1 = pelvic_inner_radius_a + pelvic_armor_thickness, 
                         r2 = pelvic_inner_radius_a + pelvic_armor_thickness, 
                         center = true);
        }
        
        // 2. Parametric Elliptical Cavity Ingestion (`pelvic_cavity_mapping.scad`)
        color([0.2, 0.2, 0.2]) {
            scale([pelvic_inner_radius_a / 1000, pelvic_inner_radius_b / 1000, 1.0])
                cylinder(h = chassis_height, r = 1000, center = true);
        }
        
        // 3. Central Driveshaft Clearance Path (Horizontal Axis Integration)
        rotate([0, 90, 0])
            cylinder(h = chassis_height, d = driveshaft_channel_diameter, center = true);
    }
    
    // 4. Integrated High-Output Internal Component Group
    Internal_Component_Payload();
}

module Internal_Component_Payload() {
    // Left-Side Upscaled GM Axial-Flux Propulsion Motor
    translate([-(pelvic_inner_radius_a - motor_casing_length/2 - clearance_offset), 0, 0])
        rotate([0, 90, 0])
            color([0.15, 0.15, 0.2]) {
                // Motor Stator Ring Enclosure
                cylinder(h = motor_casing_length, d = motor_casing_diameter, center = true);
                // Heavy-Duty 4oz Solid-State Power Bus Connector Array
                translate([0, 0, motor_casing_length/2 + 5])
                    cylinder(h = 10, d = motor_casing_diameter * 0.4, center = true);
            }

    // Right-Side Upscaled GM Axial-Flux Propulsion Motor
    translate([(pelvic_inner_radius_a - motor_casing_length/2 - clearance_offset), 0, 0])
        rotate([0, -90, 0])
            color([0.15, 0.15, 0.2]) {
                cylinder(h = motor_casing_length, d = motor_casing_diameter, center = true);
                translate([0, 0, motor_casing_length/2 + 5])
                    cylinder(h = 10, d = motor_casing_diameter * 0.4, center = true);
            }
            
    // 5. Parametric Fibonacci Golden Spiral Structural Ribbing Nodes
    for(angle = [0 : 30 : 360]) {
        // Computes exponential growth paths to anchor joint points directly to the hull skin
        assign(radius_growth = 200 * exp(0.003 * angle)) {
            rotate([0, 0, angle])
                translate([pelvic_inner_radius_a - radius_growth, 0, 0])
                    color([0.45, 0.5, 0.45])
                        cube([45, 90, motor_casing_length + 20], center = true);
        }
    }
}

// Instantiate Master Assembly for Parametric Workspace Rendering
Master_Pelvic_Assembly();
