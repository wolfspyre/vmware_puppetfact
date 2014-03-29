Version 0.2.2:
  - Addition of 5.5.0 build 1369380 test and logic.
Version 0.2.1.1:
  - Addition of 5.1.0 build 1065491 test
Version 0.2.1:
  - Forge release
  - Attribution
  - Preparation for integration into vmwaretools module
Version 0.2.0:
  - return nil on non-vmware hosts for the vmware and vmware_patchlevel facts.
  - dmidecode path is no longer hardcoded, but generated from the result of 'which dmidecode'

Version 0.1.0:
  - Major refactor of code to reside in module layout, and to provide unit tests.

This Fact is meant to allow guest VMs to know what version of ESX the hypervisor is running.
This made possible from the information found here:
http://virtwo.blogspot.com/2010/10/which-esx-version-am-i-running-on.html

I have tested this with the following versions

ESXi 3.5    207095 (E66C0)
ESXi 4.0    171294 (EA550)
ESXi 4.0u1  208167 (EA550)
ESXi 4.0u2  261974 (EA550)
ESXi 4.0u3  398348 (EA550)
ESXi 4.0u4  504850 (EA550)
ESXi 4.1    260247 (EA2E0)
ESXi 4.1u2  800380 (EA2E0)
ESXi 5.0    469512 (E72C0)
ESXi 5.0u1  623860 (E72C0)
ESXi 5.1    799733 (EA0C0)
ESXi 5.1.0 1065491 (EA0C0)
ESXi 5.5.0 1369380 (EA050)

ESXi 5.0u2 914586 (E72C0) support was added by https://github.com/kaistian/vmware_puppetfact


If you have access to something other than what's listed, if you wouldn't mind sending me a note containing:

- The version/update of VMware
- The build number
- the output of 'dmidecode -t bios' from a linux vm inside that version
I'll happily update this with that information so it can be more useful to all


NOTE: The bios is only read at power-on. A reboot will *NOT* update the bios information. If you notice an incorrect bios string, try powering off the VM completely and powering it back on. This will reload the bios, and you should have the proper address and release date.


Thanks to:
Adrien Thiebo
Stefan Heijmans
Eric Shamow
Mike Arnold
Kai Stian Olstad
Eric Sakowski
Søren Andreas Bodekær Kröger
