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
nvim dsdt.patch

```
### dadt.patch

```

--- a/dsdt.dsl	2020-08-01 17:44:50.799557442 +1000
+++ b/dsdt.dsl	2020-08-01 18:06:34.305329465 +1000
@@ -18,7 +18,7 @@
  *     Compiler ID      "    "
  *     Compiler Version 0x01000013 (16777235)
  */
-DefinitionBlock ("", "DSDT", 1, "LENOVO", "CB-01   ", 0x00000001)
+DefinitionBlock ("", "DSDT", 1, "LENOVO", "CB-01   ", 0x00000002)
 {
     External (_PR_.C000, UnknownObj)
     External (_PR_.C000._PPC, IntObj)
@@ -790,20 +790,13 @@
         Zero, 
         Zero
     })
-    If ((CNSB == Zero))
+    Name (_S3, Package (0x04)  // _S3_: S3 System State
     {
-        If ((DAS3 == One))
-        {
-            Name (_S3, Package (0x04)  // _S3_: S3 System State
-            {
-                0x03, 
-                0x03, 
-                Zero, 
-                Zero
-            })
-        }
-    }
-
+        0x03, 
+        0x03, 
+        Zero, 
+        Zero
+    })
     Name (_S4, Package (0x04)  // _S4_: S4 System State
     {
         0x04, 
@@ -10464,11 +10457,6 @@
 
                                 Local0 |= One
                             }
-                            Case (Zero)
-                            {
-                                Local0 |= Zero
-                                Local0 |= 0x02
-                            }
                             Default
                             {
                                 Local0 |= Zero


```

``` 

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