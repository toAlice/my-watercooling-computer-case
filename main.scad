include <variables.scad>

use <extrusions.scad>
use <fans.scad>
use <mainframes.scad>
use <mainboard.scad>
use <gpu.scad>
use <psu.scad>
use <radiators.scad>
use <pumps.scad>

mainframes();
rad_fans();
rad_fan_ext_mount();
if(sandwich) rad_fan_mount();
radiators();

translate([ width - (ext_sidelen + mobo_clearance), 
            ext_sidelen + alu_thickness + rad_depth + front_rad_clearance, 
            height - ext_sidelen / 2 + screw_col_0_to_back - mobo_offset ]) {
    rotate([ -90, 0, 0 ]) {
        rotate([ 0, -90, 0 ]) {
            mainboard();
        }
    }
    translate([ -pci_to_mobo - mobo_thickness,
                pci_socket_to_top + pci_socket_distance * pci_shift,
                -pci_socket_indent ]) {
        rotate([ -90, 0, 0 ]) {
            rotate([ 0, -90, 0 ]) {
                gpu();
            }    
        }
    }
    if (mobo_ff != "mITX" && mobo_ff != "mDTX") 
        translate([ -pci_to_mobo - mobo_thickness,
                    pci_socket_to_top + pci_socket_distance * (pci_shift + 2),
                    -pci_socket_indent ]) {
            rotate([ -90, 0, 0 ]) {
                rotate([ 0, -90, 0 ]) {
                    gpu();
                }    
            }
        }
}

if (mobo_ff != "mITX" && mobo_ff != "mDTX") {
    translate([ width - ext_sidelen - psu_atx_height - psu_bottom_clearance, 
                ext_sidelen + rad_depth 
                        + front_rad_clearance + screw_row_2_to_top 
                        - ext_sidelen / 2 - psu_length, 
                ext_sidelen + psu_atx_width + psu_side_clearance ]) {
        rotate([ 0, 90, 0 ]) {
            atx_psu(psu_length);
        }
    }
    translate([ width - ext_sidelen - psu_bottom_clearance - psu_atx_height,
                ext_sidelen + rad_depth 
                        + front_rad_clearance + screw_row_2_to_top 
                        - ext_sidelen / 2,
                0 ]) {
        atx_corner_mount();
    }
} else {
    translate([ width - ext_sidelen - psu_atx_height - psu_bottom_clearance, 
                depth - psu_length, 
                ext_sidelen + psu_atx_width + psu_side_clearance ]) {
        rotate([ 0, 90, 0 ]) {
            atx_psu(psu_length);
        }
    }
    translate([ width - ext_sidelen - psu_bottom_clearance - psu_atx_height,
                depth,
                0 ]) {
        atx_corner_mount();
    }
}

if (mobo_ff != "mITX" && mobo_ff != "mDTX") 
    translate([ ext_sidelen,
                rad_depth + front_rad_clearance + screw_row_2_to_top 
                    - ext_sidelen / 2,
                0 ]) {
        xext(width - ext_sidelen * 2);
    }
translate([ ext_sidelen,
            rad_depth + front_rad_clearance + screw_row_2_to_top 
                + ext_sidelen / 2 - psu_length,
            0 ]) {
    xext(width - ext_sidelen * 2);
}
translate([ ext_sidelen,
            rad_depth + front_rad_clearance + screw_row_2_to_top 
                + ext_sidelen + ext_sidelen / 2 
                - psu_length - pump_mount_size,
            0 ]) {
    xext(width - ext_sidelen * 2);
}

translate([ pump_mount_size + ext_sidelen, 
            rad_depth + front_rad_clearance + screw_row_2_to_top + ext_sidelen 
                + ext_sidelen / 2 - psu_length - pump_mount_size, 
            ext_sidelen]) 
    rotate([ 0, 0, 90 ]) 
        pumps();

translate([ ext_sidelen,
            ext_sidelen + alu_thickness + rad_depth
            + front_rad_clearance + pci_socket_to_top 
            + pci_socket_distance * pci_shift - gpu_pcb_thickness / 2 
            - pci_mount_thickness - (21.59 - 18.42) 
            - (mobo_offset + (57.15 - 49.65) - 9.40) / 2 
            - pci_mount_thickness,
            height ]) 
    pcie_mount();
