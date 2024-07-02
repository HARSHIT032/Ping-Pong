## This file is RPI Logic board .xdc for the PYNQ-Z2 ########################################
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports)
## - according to the top level signal names in the project
##
###########################Raspberry Digital I/O###############################################
## Clock signal 12 MHz  ##
#set_property -dict { PACKAGE_PIN Y9    IOSTANDARD LVCMOS33 } [get_ports { OSC_12MHz }]; #rpio_21

##Button #Active Low##
#set_property -dict { PACKAGE_PIN V7    IOSTANDARD LVCMOS33 } [get_ports { Button }]; #rpio_27  

## SSD(Seven Segment Display) x 4 ##
set_property -dict { PACKAGE_PIN Y16   IOSTANDARD LVCMOS33 } [get_ports { ss[6] }]; #rpio_sd
set_property -dict { PACKAGE_PIN Y17   IOSTANDARD LVCMOS33 } [get_ports { ss[5] }]; #rpio_sc 
set_property -dict { PACKAGE_PIN W18   IOSTANDARD LVCMOS33 } [get_ports { ss[4] }]; #rpio_02
set_property -dict { PACKAGE_PIN W19   IOSTANDARD LVCMOS33 } [get_ports { ss[3] }]; #rpio_03
set_property -dict { PACKAGE_PIN Y18   IOSTANDARD LVCMOS33 } [get_ports { ss[2] }]; #rpio_04
set_property -dict { PACKAGE_PIN Y19   IOSTANDARD LVCMOS33 } [get_ports { ss[1] }]; #rpio_05
set_property -dict { PACKAGE_PIN U18   IOSTANDARD LVCMOS33 } [get_ports { ss[0] }]; #rpio_06
#set_property -dict { PACKAGE_PIN U19   IOSTANDARD LVCMOS33 } [get_ports { SSD_CP }]; #rpio_07

set_property -dict { PACKAGE_PIN F19   IOSTANDARD LVCMOS33 } [get_ports { enabler[0] }]; #rpio_08
set_property -dict { PACKAGE_PIN V10   IOSTANDARD LVCMOS33 } [get_ports { enabler[1] }]; #rpio_09
set_property -dict { PACKAGE_PIN V8    IOSTANDARD LVCMOS33 } [get_ports { enabler[2] }]; #rpio_10
set_property -dict { PACKAGE_PIN W10   IOSTANDARD LVCMOS33 } [get_ports { enabler[3] }]; #rpio_11

##LED(GREEN)## 
#set_property -dict { PACKAGE_PIN B20   IOSTANDARD LVCMOS33 } [get_ports { w[0] }]; #rpio_12
#set_property -dict { PACKAGE_PIN W8    IOSTANDARD LVCMOS33 } [get_ports { w[1] }]; #rpio_13
#set_property -dict { PACKAGE_PIN U8    IOSTANDARD LVCMOS33 } [get_ports { w[2] }]; #rpio_22
#set_property -dict { PACKAGE_PIN W6    IOSTANDARD LVCMOS33 } [get_ports { w[3] }]; #rpio_23
#set_property -dict { PACKAGE_PIN Y7    IOSTANDARD LVCMOS33 } [get_ports { w[4] }]; #rpio_24
#set_property -dict { PACKAGE_PIN F20   IOSTANDARD LVCMOS33 } [get_ports { w[5] }]; #rpio_25

##Switches##
#set_property -dict { PACKAGE_PIN V6    IOSTANDARD LVCMOS33 } [get_ports { SWA }]; #rpio_14
#set_property -dict { PACKAGE_PIN Y6    IOSTANDARD LVCMOS33 } [get_ports { SWB }]; #rpio_15
#set_property -dict { PACKAGE_PIN B19   IOSTANDARD LVCMOS33 } [get_ports { SWC }]; #rpio_16
#set_property -dict { PACKAGE_PIN U7    IOSTANDARD LVCMOS33 } [get_ports { SWD }]; #rpio_17
#set_property -dict { PACKAGE_PIN C20   IOSTANDARD LVCMOS33 } [get_ports { SWE }]; #rpio_18
#set_property -dict { PACKAGE_PIN Y8    IOSTANDARD LVCMOS33 } [get_ports { SWF }]; #rpio_19
#set_property -dict { PACKAGE_PIN A20   IOSTANDARD LVCMOS33 } [get_ports { SWG }]; #rpio_20
#set_property -dict { PACKAGE_PIN W9    IOSTANDARD LVCMOS33 } [get_ports { SWH }]; #rpio_26



