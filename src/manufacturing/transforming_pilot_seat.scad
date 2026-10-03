// ============================================================================
// PROJECT: XXXG-00W0 WING GUNDAM ZERO EW - PILOT OPERATIONS VAULT
// COMPONENT: TRANSFORMING SEAT BUCKET FRAME (TRANSFORMING_PILOT_SEAT.SCAD)
// PACKAGING CONFIG: DUAL-SIDE LONGITUDINAL CYLINDER WALL TRACK INTERLOCKS
// CONFIG METRIC: SCALED TITANIUM CASTS (1:1 ACTUAL METRIC UP-SCALE)
// ============================================================================

$fn = 80; // High-fidelity circular resolution segment count

// Structural Cockpit Constraints (1:1 Metric Airframe Scale - mm)
inner_diameter = 2310;                  // Orion clear internal diameter boundary (mm)
inner_length = 2760;                    // Clear internal cabin depth path (mm)
seat_width = 650;                       // Central pilot bucket frame width (mm)
track_arm_extension = 780;              // Extension length from seat center to wall tracks (mm)
link_thickness = 45;                    // Solid TiAl structural link plating thickness (mm)

// Transformation Mode Selection (0 = Stowed Flat, 1 = Flight Bucket, 2 = Dental Bed)
transformation_state = 1; 

module Master_Pilot_Seat_Assembly() {
    // 1. Render Symmetrical Left & Right Longitudinal Cylinder Wall Tracks
    color([0.3, 0.3, 0.32]) {
        translate([-inner_diameter/2 + 20, 0, 0]) cube([40, inner_length, 80], center = true);
        translate([inner_diameter/2 - 20, 0, 0])  cube([40, inner_length, 80], center = true);
    }
    
    // 2. Render Symmetrical Dual-Side Load-Bearing Tracking Arms
    color([0.45, 0.45, 0.48]) { // Deep Titanium Industrial Spec
        translate([-track_arm_extension/2 - seat_width/2, 0, 0]) cube([track_arm_extension, 90, 60], center = true);
        translate([track_arm_extension/2 + seat_width/2, 0, 0])  cube([track_arm_extension, 90, 60], center = true);
    }
    
    // 3. Render Articulating Seat Bucket Components Based on Hexadecimal State Input
    if (transformation_state == 0) {
        // FLAT BULKHEAD STOWED CONFIGURATION (Locked flush against rear wall)
        translate([0, -inner_length/2 + 100, 0]) Build_Stowed_Flat_Profile();
    } else if (transformation_state == 2) {
        // ERGONOMIC DENTAL STABILIZATION BED CONFIGURATION (High-G Shock Dousing)
        translate([0, 0, -100]) Build_Dental_Bed_Profile();
    } else {
        // STANDARD FLIGHT BUCKET MODE (Nominal Upright Operations)
        translate([0, 200, -50]) Build_Flight_Bucket_Profile();
    }
}

module Build_Flight_Bucket_Profile() {
    // Seating Surface Base Plate
    cube([seat_width, 550, link_thickness], center = true);
    
    // Upright 75-Degree Backrest Frame
    translate([0, -260, 300]) rotate([15, 0, 0])
        cube([seat_width, link_thickness, 750], center = true);
        
    // Angled Lower Leg Support Linkage
    translate([0, 260, -150]) rotate([-45, 0, 0])
        cube([seat_width, 400, link_thickness], center = true);
}

module Build_Dental_Bed_Profile() {
    // Flattened Seating Surface Base Plate
    cube([seat_width, 600, link_thickness], center = true);
    
    // Reclined 18-Degree Backrest Frame
    translate([0, -380, 120]) rotate([72, 0, 0])
        cube([seat_width, link_thickness, 750], center = true);
        
    // Horizontally Extended Lower Leg Support Rails
    translate([0, 480, 0])
        cube([seat_width, 500, link_thickness], center = true);
}

module Build_Stowed_Flat_Profile() {
    // All structural sections collapsed into a single 90mm thick planar stack
    cube([seat_width, link_thickness, 600], center = true);
    translate([0, 0, link_thickness])
        cube([seat_width, link_thickness, 750], center = true);
}

// Render Master Component to Parameter Workspace
Master_Pilot_Seat_Assembly();
