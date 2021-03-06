# makefiles
This directory contains tools for building and testing the main firmware image, that gets put on the sdcard.

The `host/` and `in_chroot/` directories separate those scripts, that are run inside a chroot of the axiom firmware, and those, that run on the host build machine. For example the kernel build and the image assembly are done by scripts in the `host/` directory, while the build of the tools is done `in_chroot/`.

Generally the build currently consists of 2 build stages and one test stage:
1. Build the file trees of the Partitions
    1. bootfs (partition 1) including kernel u-boot and first stage bootloader
    2. extract the archlinux rootfs and run the `in_chroot/` scripts in a chroot of the rootfs
2. assemble the file trees to an image
3. test the image using qemu.

## Build It!
The `docker_make.sh` script allows us to run the build scripts inside docker and manage
all the build dependencies.

Assuming that you have cloned this repository, have docker installed and can run docker as your current user, simply type
```
makefiles/docker_make.sh
```

The script will create a docker container and run the makefiles inside it.
This will result in the finished camera image with path `build/axiom.img`.

You can also run other targets, defined in the makefile, with `docker_make.sh`. You can for example
run:
* `docker_make.sh build-shell` to get a root shell inside the build container
* `docker_make.sh chroot-shell` to get a root shell inide a chroot of the camera
* `docker_make.sh qemu-shell` to boot the camera image inside qemu. currently the network is not working.
* `docker_make.sh test` to run automated tests of the image inside qemu.
