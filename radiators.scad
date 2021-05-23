include <variables.scad>

module radiator(body_height = rad_body_height, body_width = rad_width, 
                body_depth = rad_depth,
                top_height = rad_top_height, bottom_height = rad_bottom_height, 
                mount_spacing = fan_mounting_holes) {
    module top() {
        color("#4F4F4F") translate([body_width * 0.025, body_depth * 0.05, 0]) 
            cube([ body_width * 0.45, body_depth * 0.9, top_height]);
        color("#4F4F4F") translate([body_width * 0.525, body_depth * 0.05, 0]) 
            cube([ body_width * 0.45, body_depth * 0.9, top_height]);
    }
    module body() {
        color("#2F2F2F") difference() {
            cube([body_width, body_depth, body_height]);
            translate([body_width * 0.05, -0.01, body_height * 0.05]) {
                cube([body_width * 0.9, body_depth + 0.02, body_height * 0.9]);
            }
        }
        color("#AFAFAF") translate([0.01, body_depth * 0.15, 0.01]) {
            cube([body_width - 0.02, body_depth * 0.7, body_height - 0.02]);
        }
    }
    module bottom() { 
        color("#4F4F4F") translate([body_width * 0.05, body_depth * 0.05, 0]) 
            cube([ body_width * 0.9, body_depth * 0.9, bottom_height ]);
    }

    translate([0, 0, body_height + bottom_height]) top();
    translate([0, 0, bottom_height]) body();
    bottom();
}

module radiators() {
    // front
    translate([ (width - fan_size) / 2, 
                ext_sidelen + alu_thickness, 
                height - ext_sidelen - rad_top_clearance
                    - rad_top_height - fan_size * 2 - rad_bottom_height ]) {
        radiator();
    }
    // back (removed if the mobo is not large enough)
    if (mobo_ff != "mITX" && mobo_ff != "mDTX" && mobo_ff != "mATX") 
        translate([(width - fan_size) / 2, 
                    depth - ext_sidelen - alu_thickness - rad_depth, 
                    height - ext_sidelen - rad_top_clearance
                    - rad_top_height - fan_size * 2 - rad_bottom_height ])
            radiator();
}
