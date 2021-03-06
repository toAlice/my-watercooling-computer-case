// constans
mobo_thickness = 2.36;
// mobo_ff = "EATX";
mobo_ff = "ATX";
// mobo_ff = "mATX";
// mobo_ff = "mDTX";
// mobo_ff = "mITX";

sandwich = true;
unit_space = 5;

function inches2mm(inches = 0) = (25.4 * inches);

mITX_width = inches2mm(6.7);
mITX_height = inches2mm(6.7);
mDTX_width = inches2mm(6.7);
mDTX_height = inches2mm(8);
mATX_width = inches2mm(9.6);
mATX_height = inches2mm(9.6);
ATX_width = inches2mm(9.6);
ATX_height = inches2mm(12);
EATX_width = inches2mm(13); // full size E-ATX / EEB
EATX_height = inches2mm(12);

pci_socket_to_top = inches2mm(12 - 0.65 - 3.1) - 47.29;
pci_socket_distance = inches2mm(0.8);
pci_socket_indent = inches2mm(2.25);
pci_to_mobo = 16.15;

psu_sfx_width = 125;
psu_sfx_height = 63.5;
psu_flex_width = 81.5;
psu_flex_height = 40.5;
psu_atx_width = 150;
psu_atx_height = 86;

alu_thickness = 1.5;

screw_col_0_to_back = inches2mm(0.4);
screw_col_1_to_back = inches2mm(0.4 + 6.1);
screw_col_2_to_back = inches2mm(0.4 + 8.95);
screw_col_3_to_back = inches2mm(0.4 + 12.3); // eatx

screw_row_0_to_top = inches2mm(12 - 0.65 - 11.1);
screw_row_0_col_0_to_back = inches2mm(0.4 + 0.9);
screw_row_1_to_top = inches2mm(12 - 0.65 - 4.9);
screw_row_1_5_to_top = inches2mm(12 - 0.65 - 3.1);
screw_row_1_m_to_top = inches2mm(12 - 0.65 - 3.1) + pci_socket_distance;
screw_row_2_to_top = inches2mm(12 - 0.65);

ext_sidelen = 20;

mobo_width = mobo_ff == "mITX" ? mITX_width
           : mobo_ff == "mDTX" ? mDTX_width
           : mobo_ff == "mATX" ? mATX_width
           : (mobo_ff == "EATX" || mobo_ff == "EEB") ? EATX_width
           : mobo_ff == "ATX"? ATX_width
           : 0;
mobo_height = mobo_ff == "mITX" ? mITX_height
            : mobo_ff == "mDTX" ? mDTX_height
            : mobo_ff == "mATX" ? mATX_height
            : (mobo_ff == "EATX" || mobo_ff == "EEB") ? EATX_height
            : mobo_ff == "ATX"? ATX_height
            : 0;

// mobo_offset = 0;
// offset + screw_col_0_to_back > extlen + 2 (assuming use M4 screws)
// and offset + screw_col_0_to_back ~= extlen / 2 (assuming use M4 screws)
mobo_offset = ext_sidelen / 2 + 4; 
mobo_clearance = 5;
mobo_io_space = unit_space * 2;

alu_ext_screw_hole_size = 4;
m3_screw_hole_size = 3;

fan_thickness = 30;
fan_size = 200;

fan_mounting_holes = 170;
rad_mounting_holes = 185;

rad_top_height=30;
rad_body_height = 400;
rad_bottom_height = 15;
rad_full_height = rad_top_height + rad_body_height + rad_bottom_height;
rad_width = 200;
rad_depth = 48;
rad_top_clearance = unit_space * -2;
rad_bottom_clearance = unit_space * -2;

front_rad_clearance = unit_space * 8 
                      + (sandwich ? alu_thickness + fan_thickness : 0);
back_rad_clearance = unit_space * 4 
                     + (sandwich ? alu_thickness + fan_thickness : 0);


pci_mount_thickness = 1.03;

gpu_thickness = 4;
gpu_sidelen = 73;
gpu_pcb_thickness = 1.57;
gpu_pcb_length = 150;
// gpu_pcb_length = inches2mm(12);
gpu_pcb_height = 118.25;

pci_shift = (mobo_ff == "mITX" || mobo_ff == "mDTX" || mobo_ff == "mATX") ? 0 : 1;
pci_lock_multiplier = ((mobo_ff == "mITX" || mobo_ff == "mDTX") ? 4 : 7)
                       - pci_shift;



psu_length = 150;
psu_in_cabel_space = 40;
psu_side_clearance = 2;
psu_bottom_clearance = 2;

pump_mount_size = 120;
reservoir_height = 300;

height = ext_sidelen 
        + max(rad_bottom_clearance + rad_full_height + rad_top_clearance, 
            psu_side_clearance + psu_atx_width + psu_side_clearance + mobo_io_space
                + max(mobo_width, gpu_pcb_length) + mobo_offset - ext_sidelen) 
        + ext_sidelen;
width = ext_sidelen + unit_space + fan_size + unit_space + ext_sidelen;
depth = ext_sidelen + alu_thickness + rad_depth + front_rad_clearance
        + mobo_height + back_rad_clearance + rad_depth + alu_thickness 
        + ext_sidelen;
