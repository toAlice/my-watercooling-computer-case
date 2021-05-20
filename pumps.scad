include <variables.scad>

module pumps() {
    module _arm() {
        translate([ 0, 0, -40 ])
            linear_extrude(height = alu_thickness) for (i = [0:3]) {
            rotate([0, 0, 90 * i])polygon([
                [0, 0],
                [0, 6],
                [pump_mount_size / 2 - 6, pump_mount_size / 2],
                [pump_mount_size / 2, pump_mount_size / 2],
                [pump_mount_size / 2, pump_mount_size / 2 - 6],
                [6, 0]
            ]);
        }
    }
    module reservoir() {
        color("#1F1F1F") 
            cylinder(d = 60, h = 10);
        color("#AFAFFF") 
            translate([0, 0, 10]) 
                cylinder(d = 60, h = reservoir_height - 20);
        color("#1F1F1F") 
            translate([0, 0, reservoir_height - 10]) 
                cylinder(d = 60, h = 10);
    }
    translate([ pump_mount_size / 2, pump_mount_size / 2, 40 ]) {
        color("#1F1F1F") cube([ 81, 75, 80 ], center = true);
        color("#5F5F6F") rotate([0, 90, 0]) 
            cylinder(d = 60, h = 151, center = true);
        color("#1F1F1F") _arm();
        translate([0, 0, 40]) reservoir();
    }
}

