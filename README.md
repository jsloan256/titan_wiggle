# titan_wiggle

This is a simple Verilog project to validate the Titan PCI Express development card for the Lattice ECP5 FPGA

# Features
* Toggles GPIO pins on P3 and P5 expansion header (slow enough for LEDs)
* Enumerates the PCIe express interface in x1 mode
  * Device ID is beef
  * Vendor ID is dead

# Dependencies
* Lattice Diamond 3.2
* PCI Express x1/x2/x4 Endpoint - Optimized for ECP5UM (6.0_asr)

# Build Instructions
* Open the project (titan_wiggle.ldf)
* Open Clarity Designer by double-clicking on claritycores.sbx in the file list
  * Re-configure the refclk core
    * Right-click on refclk, then select **Config**
    * In the new dialog, click **Configure** and then **Close** when the process completes
  * Re-configure the pcie_x1 core
    * Right-click on pcie_x1, then select **Config**
    * In the new dialog, click **Configure** and then **Close** when the process completes
  * Click on the **Generate** button at the top of the Clarity Designer window
* Build the FPGA bitstream
