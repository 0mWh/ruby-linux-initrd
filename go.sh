#!/bin/bash

shopt -s lastpipe

version="$(uname -r)"

kernel=/boot/vmlinuz-${version}
initrd=rblinux-initrd-$(git log -1 --format=%h).img
append='edd=off init=/init HOME=/home rw vga=792'

ruby -e 'puts RUBY_VERSION[0..2]' | read ruby_version

if dpkg -p libssl3
then
	ssl_version=3
else
	ssl_version=1.1
fi


mkdir cache -p
pushd cache

	apt-get download libc6 linux-image-${version}

	# framebuffer
	apt-get download kmod libzstd1 liblzma5 libssl${ssl_version}
	apt-get download coreutils util-linux libselinux1 libpcre2-8-0
	apt-get download v86d libx86-1

	# bash
	apt-get download bash libtinfo6

	# ruby
	apt-get download ruby${ruby_version} libruby${ruby_version} zlib1g libgmp10 libcrypt1

	# unpack
	for deb in *.deb
	do
		echo "extracting ${deb}"
		dpkg-deb -x "${deb}" ../initrd
	done

popd

pushd initrd

	pushd usr/bin
		ln -sfv ruby${ruby_version} ruby
	popd

	echo "building initrd ${initrd}"
	find . | cpio -o -H newc > "../${initrd}"

popd

echo "booting..."

qemu-system-x86_64   \
 -kernel "initrd/${kernel}" \
 -initrd "${initrd}" \
 -append "${append}" \
 -enable-kvm -m 4G $*

