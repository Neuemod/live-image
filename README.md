# Neue System Live Image Builder

A tool to build a live image of Neue System and a combination from Ubuntu
Budgie, Ubuntu Cinnamon Remix, and Elementary OS image builder script with some
modifications.

## Dependencies

This script need these dependencies to make it work:

```bash
debootstrap
live-build # See Note
docker # optional
```

Note: for `live-build` must be use the debian upstream one, since the Ubuntu
patched version won't work recently. You need to build it from
[source](https://salsa.debian.org/live-team/live-build.git).

## Configuration

You can configure or edit the configuration by modifying `build.config`

## Building

To build ISO, there are two methods:

* If you want to build on a container (as some distros recommended), run:

```bash
docker run --privileged -i -v /proc:/proc \
    -v ${PWD}:/working_dir \
    -w /working_dir \
    debian:latest \
    /bin/bash -s etc/build.conf < build.sh
```
*Recommended for those who won't messing up their computer*


* If you prefer build image locally, you can easily run:

```bash
bash ./build.sh
```
*Recommended for beginner and testers*


## Credits

* Ubuntu Cinnamon Remix: https://github.com/Ubuntu-Cinnamon-Remix/iso-builder-devel
* Elementary OS: https://github.com/elementary/os
