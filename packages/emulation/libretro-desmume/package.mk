# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-desmume"
PKG_VERSION="2ed78e2cece0bb9978fd64d37b17049ce2495c37"
PKG_SHA256="450bad42f90880ec759582c3b2f58af9cee6061965048e278c789cd9a70a43eb"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/desmume"
PKG_URL="https://github.com/libretro/desmume/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_LONGDESC="libretro wrapper for desmume NDS emulator."
PKG_TOOLCHAIN="make"

PKG_LIBNAME="desmume_libretro.so"
PKG_LIBPATH="desmume/${PKG_LIBNAME}"
PKG_LIBVAR="DESMUME_LIB"

make_target() {
  case ${TARGET_CPU} in
    arm1176jzf-s)
      make -C desmume -f Makefile.libretro platform=armv6-hardfloat-${TARGET_CPU}
      ;;
    cortex-a7|cortex-a9)
      make -C desmume -f Makefile.libretro platform=armv7-neon-hardfloat-${TARGET_CPU}
      ;;
    x86-64)
      make -C desmume -f Makefile.libretro
      ;;
  esac
}

makeinstall_target() {
  mkdir -p ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}
  cp ${PKG_LIBPATH} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME}
  echo "set(${PKG_LIBVAR} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME})" > ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}/${PKG_NAME}-config.cmake
}
