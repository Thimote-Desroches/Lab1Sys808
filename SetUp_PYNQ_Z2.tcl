file mkdir LAB1_SYS808_PYNQ_Z2
cd LAB1_SYS808_PYNQ_Z2


#Creating and setting the correct board
create_project SYS808_Lab1 -part xc7z020clg400-1
set_property board_part tul.com.tw:pynq-z2:part0:1.0 [current_project]

#Add all files
set vhdl_files [glob ../GENERAL_VHDL_FILES/VHDL/*.vhd]
foreach file $vhdl_files {
    add_files $file
}
#Add all testbench files
set vhdl_files [glob ../GENERAL_VHDL_FILES/TESTBENCH/*.vhd]
foreach file $vhdl_files {
	add_files -fileset sim_1 -norecurse -scan_for_includes $file
}




add_files -fileset constrs_1 -norecurse ../PYNQ-Z2_loops_final.xdc

