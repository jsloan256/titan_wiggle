# ecp5dev_wiggle

This project provides a simple test platform the the Lattice ECP5 PCI Expres Board (dev card).

# Features
* Blinks LEDs D1..D8
* Enumerates the PCIe express interface in x1 mode
  * Device ID is dead
  * Vendor ID is beef

# Dependencies
* Lattice Diamond 3.2
* PCI Express x1/x2/x4 Endpoint - Optimized for ECP5UM (6.0_asr)

# Build Instructions
* Open the project (ecp5dev_wiggle.ldf)
* Open Clarity Designer by double-clicking on claritycores.sbx in the file list
  * Re-configure the refclk_inst core
    * Right-click on refclk_inst, then select **Config**
    * In the new dialog, click **Configure** and then **Close** when the process completes
  * Re-configure the pcie_end core
    * Right-click on pcie_end, then select **Config**
    * In the new dialog, click **Configure** and then **Close** when the process completes
  * Click on the **Generate** button at the top of the Clarity Designer window
* Build the FPGA bitstream
