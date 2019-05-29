#!/bin/sh

./qemu/x86_64-softmmu/qemu-system-x86_64 \
-M q35,accel=kvm,kernel-irqchip=split \
-device intel-iommu,intremap=on,caching-mode=on,eim=on,device-iotlb=on \
-m 4G \
-smp 4,sockets=4,cores=1,threads=1 \
-enable-kvm \
-uuid 990ea161-6b67-47b2-b803-19fb01d30d12 \
-k en-us \
-usb \
-boot c \
-device usb-tablet \
-device pcie-root-port,bus=pcie.0,id=root0,multifunction=on,chassis=1,addr=0xa.0 \
-device ahci,id=ahci0 \
-drive file=/home/yanv/images/ubuntu_iommu.qcow2,format=qcow2,if=none,id=drive-ide0-0-0,format=qcow2 \
-device ide-drive,bus=ahci0.0,unit=0,drive=drive-ide0-0-0,id=ide0-0-0 \
-netdev tap,id=hostnet1,script=/home/yanv/dev/qemu-ifup,ifname=ws2016_02 \
-device e1000,netdev=hostnet1,mac=00:33:c3:02:31:12,id=vnic02 \
-cdrom /home/yanv/images/iso/ubuntu-19.04-live-server-amd64.iso \
-monitor stdio \
-netdev tap,id=hostnet2,vhost=on,script=/home/yanv/dev/qemu-ifup,ifname=2016_02 \
-device virtio-net-pci,netdev=hostnet2,mac=00:33:c3:02:22:32,id=vnic03,iommu_platform=on,ats=on,disable-legacy=on,disable-modern=off \
-vnc :5 
	

#-netdev tap,id=hostnet2,vhost=on,script=/home/yanv/dev/qemu-ifup,ifname=2016_02 \
#-device virtio-net-pci,netdev=hostnet2,mac=00:33:c3:02:22:32,id=vnic03,iommu_platform=on,ats=on,disable-legacy=on,disable-modern=off \


#-device virtio-blk-pci,drive=drive-virtio-disk1,id=virtio-disk1,bus=root0,iommu_platform=on,ats=on \
# -drive file=/home/yanv/images/iso/virtio-win-0.1.141.iso,if=none,id=drive-virtio-disk3,format=raw \

# -device intel-iommu,intremap=on,caching-mode=on,eim=on,device-iotlb=on \
# windows_2016_X64.qcow2
# -drive file=/home/yanv/images/windows_2016_X64_test_install.qcow2,if=none,id=drive-virtio-disk0,format=qcow2,cache=none,werror=stop,rerror=stop \

