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
              when line.match(/E8480/)
                result = "2.5"
              when line.match(/E7C70/)
                result = "3.0"
              when line.match(/E7910/)
                result = "3.5"
              when line.match(/EA6C0/)
                result = "4.0"
              when line.match(/EA550/)
                result = "4U1"
              when line.match(/EA2E0/)
                result = "4.1"
              when line.match(/E72C0/)
                result = "5.0"
            end
          end
        end
      end
    result
    end
    result
  end