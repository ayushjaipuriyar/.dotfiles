# Sleep fix

```
paru acpica 
paru cpio 
```

## Steps

``` bash

mkdir ~/acpi/
cd ~/acpi/
sudo acpidump -b
iasl -e *.dat -d dsdt.dat

patch -p1 < dsdt.patch
iasl -ve -tc dsdt.dsl
mkdir -p kernel/firmware/acpi
cp dsdt.aml kernel/firmware/acpi

find kernel | cpio -H newc --create > acpi_override
sudo cp acpi_override /boot

```

### GRUB

``` bash

sudo nvim /etc/default/grub


GRUB_CMDLINE_LINUX_DEFAULT="mem_sleep_default=deep"
GRUB_EARLY_INITRD_LINUX_CUSTOM=acpi_override


sudo grub-mkconfig -o /boot/grub/grub.cfg

```