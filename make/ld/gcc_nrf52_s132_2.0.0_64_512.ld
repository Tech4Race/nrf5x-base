/* Linker script to configure memory regions. */
MEMORY
{
  FLASH (rx) : ORIGIN = 0x0 + 112K, LENGTH = 512K - 112K /* 4 kB MBR, 108 kB is taken by S132, 400 kB for app. */
  RAM (rwx) :  ORIGIN = 0x20000000 + 11K, LENGTH = 64K-11K /* softdevice wants max ~10K bytes. */
  /* NOTE: RAM must be updated based on parameters to softdevice_enable() */
}

SECTIONS
{
  .fs_data :
  {
    PROVIDE(__start_fs_data = .);
    KEEP(*(.fs_data))
    PROVIDE(__stop_fs_data = .);
  } > RAM
  .pwr_mgmt_data :
  {
    PROVIDE(__start_pwr_mgmt_data = .);
    KEEP(*(.pwr_mgmt_data))
    PROVIDE(__stop_pwr_mgmt_data = .);
  } > RAM
} INSERT AFTER .data;

INCLUDE "nrf5x_common.ld"
