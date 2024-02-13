#!/bin/bash

version="$(uname -r)"

kernel=/boot/vmlinuz-${version}
initrd=rblinux-initrd-$(date +%s).img
append='edd=off init=/init HOME=/home rw vga=792'

mkdir cache -p
pushd cache

	apt-get download libc6 linux-image-${version}

	# framebuffer
	apt-get download kmod libzstd1 liblzma5 libssl3
	apt-get download coreutils util-linux libselinux1 libpcre2-8-0
	apt-get download v86d libx86-1

	# bash
	apt-get download bash libtinfo6

	# ruby
	apt-get download ruby3.2 libruby3.2 zlib1g libgmp10 libcrypt1

	# unpack
	for deb in *.deb
	do
		echo "extracting ${deb}"
		dpkg-deb -x "${deb}" ../initrd
	done

popd

pushd initrd

	echo "building initrd ${initrd}"
	find . | cpio -o -H newc > "../${initrd}"

popd

echo "booting..."

qemu-system-x86_64   \
 -kernel "initrd/${kernel}" \
 -initrd "${initrd}" \
 -append "${append}" \
 -enable-kvm -m 4G $*

