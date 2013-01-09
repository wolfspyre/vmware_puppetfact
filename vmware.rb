Facter.add("vmware") do
  #set a generic value in case we're not VMWARE
  result = "non-vmware"
  confine :virtual => :vmware
  setcode do
    #set a generic VMware value in case we're being run on a non-linux guest in vmware
    result = "vmware-unknown"
    confine :kernel => :linux
    #in linux, do some magic
    if File.exists?("/usr/sbin/dmidecode")
      foobar = %x{/usr/sbin/dmidecode -t bios}
      if not foobar.nil?
        foobar.each_line do |line|
          case
            # I have tested this with the following versions
            # ESXi 3.5   207095 (E66C0)
            # ESXi 4.0   171294 (EA550)
            # ESXi 4.0u1 208167 (EA550)
            # ESXi 4.0u2 261974 (EA550)
            # ESXi 4.0u3 398348 (EA550)
            # ESXi 4.0u4 504850 (EA550)
            # ESXi 4.1   260247 (EA2E0)
            # ESXi 4.1u2 800380 (EA2E0)
            # ESXi 5.0   469512 (E72C0)
            # ESXi 5.0u1 623860 (E72C0)
            # ESXi 5.1   799733 (EA0C0)
            #
            when line.match(/E8480/)
              result = "2.5"
            when line.match(/E7C70/)
              result = "3.0"
            when line.match(/E7910/)
              result = "3.5"
            when line.match(/E66C0/)
              result = "3.5"
            when line.match(/EA6C0/)
              result = "4.0"
            when line.match(/EA550/)
              result = "4.0"
            when line.match(/EA2E0/)
              result = "4.1"
            when line.match(/E72C0/)
              result = "5.0"
            when line.match(/EA0C0/)
              result = "5.1"
          end
        end
      end
    end
  result
  end
  result
end