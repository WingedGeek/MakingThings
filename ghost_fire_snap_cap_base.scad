// Ghost Fire pedalboard hole cap — parametric blank for future modifications.
// All dimensions in millimeters. Modify this file or the derived STL.
// Orientation: cap face is at z=10.94; free ends of flexible clips at z=0.
$fn = 180;

cap_diameter = 39.55;
cap_thickness = 2.50;
overall_height = 10.94;
body_diameter = 34.80;
body_inner_diameter = 30.80; // nominal wall 2 mm
retention_diameter = 36.67;  // maximum diameter across clip bulges
slot_width = 1.60;
finger_count = 6;

skirt_height = overall_height - cap_thickness;
body_radius = body_diameter/2;
inside_radius = body_inner_diameter/2;
retention_radius = retention_diameter/2;

module clip_ring() {
    // Rotational section defines flat-wall fingers with chamfered entrances
    // and a tapered snap bead, 1–3 mm above the clip tips.
    rotate_extrude(convexity=10)
        polygon(points=[
            [inside_radius+0.45,0],
            [body_radius-0.35,0],
            [body_radius,0.55],
            [body_radius,1.00],
            [retention_radius,1.75],
            [retention_radius,2.45],
            [body_radius,3.45],
            [body_radius,skirt_height+0.25],
            [inside_radius,skirt_height+0.25],
            [inside_radius,0.45]
        ]);
}

module cap_blank() {
    union() {
        // Fully solid lid, intended for customization with apertures/mounts.
        translate([0,0,skirt_height])
            cylinder(h=cap_thickness,d=cap_diameter);
        difference() {
            clip_ring();
            // Six straight slots interrupt the cylindrical ring but stop
            // at the lid; clips are united by the solid cap.
            for(i=[0:finger_count-1])
                rotate([0,0,i*360/finger_count])
                    translate([inside_radius-0.5,-slot_width/2,-0.1])
                        cube([cap_diameter/2-inside_radius+1,slot_width,skirt_height+0.1]);
        }
    }
}
cap_blank();
