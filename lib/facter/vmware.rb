# I have verified that the following versions match the following strings in dmidecode
# ESXi 3.5   207095 ( Address: 0xE66C0 Release Date: 03/19/2009)
# ESXi 4.0   171294 ( Address: 0xEA550 Release Date: 03/26/2009)
# ESXi 4.0u1 208167 ( Address: 0xEA550 Release Date: 09/22/2009)
# ESXi 4.0u2 261974 ( Address: 0xEA550 Release Date: 09/22/2009)
# ESXi 4.0u3 398348 ( Address: 0xEA550 Release Date: 09/22/2009)
# ESXi 4.0u4 504850 ( Address: 0xEA550 Release Date: 09/22/2009)
# ESXi 4.1   260247 ( Address: 0xEA2E0 Release Date: 10/13/2009)
# ESXi 4.1u2 800380 ( Address: 0xEA2E0 Release Date: 04/15/2011)
# ESXi 5.0   469512 ( Address: 0xE72C0 Release Date: 01/07/2011)
# ESXi 5.0u1 623860 ( Address: 0xE72C0 Release Date: 09/21/2011)
# ESXi 5.1   799733 ( Address: 0xEA0C0 Release Date: 06/22/2012)
#
mainver = "unknown"
update  = "unknown"
if File.exists?("/usr/sbin/dmidecode")
  foobar = %x{/usr/sbin/dmidecode -t bios}
  if not foobar.nil?
    #sometimes Dmidecode will barf:
    if not foobar.match(/No SMBIOS nor DMI entry point found, sorry./)
      mainver  = "unknown"
      address  = foobar.match(/Address: 0x(.*)/i)[0]
      biosdate = foobar.match(/Release Date: (.*)/i)[0]
      case
        when address.match(/E8480/)
          mainver = "2.5"
        when address.match(/E7C70/)
          mainver = "3.0"
        when address.match(/E7910/)
          mainver = "3.5"
        when address.match(/E66C0/)
          mainver = "3.5"
        when address.match(/EA6C0/)
          mainver = "4.0"
        when address.match(/EA550/)
          mainver = "4.0"
        when address.match(/EA2E0/)
          mainver = "4.1"
          case
            when biosdate.match(/04\/15\/2011/)
              update = "u2"
          end
        when address.match(/E72C0/)
          mainver = "5.0"
          case
            when biosdate.match(/09\/21\/2011/)
              update = "u1"
          end
        when address.match(/EA0C0/)
          mainver = "5.1"
       end
       result = mainver
    end
  end
end
Facter.add("vmware") do
  #set a generic value in case we're not VMWARE
  result = "non-vmware"
  confine :virtual => :vmware
  setcode do
    #set a generic VMware value in case we're being run on a non-linux guest in vmware
    result = "vmware-unknown"
    confine :kernel => :linux
      #in linux, do some magic
      result = mainver
    end
  result
end
unless update == "unknown"
  Facter.add("vmware_patchlevel") do
    confine :virtual => :vmware
    setcode do
      result = "vmware-unknown"
      confine :kernel => :linux
        result = update
    end
    result
  end
end