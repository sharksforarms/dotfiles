#!/bin/bash
set -e

BUILD_DIR=$PWD/build/
DEP_DIR=$PWD/tmp/

mkdir -p $BUILD_DIR
pushd $BUILD_DIR

ZIG_C=$PWD/zigcc
cat << EOF > $ZIG_C
#!/bin/sh
/opt/zig/zig cc \$@
EOF
chmod +x $ZIG_C

ZIG_CXX=$PWD/zigcc
cat << EOF > $ZIG_CXX
#!/bin/sh
/opt/zig/zig c++ \$@
EOF
chmod +x $ZIG_CXX

    # -DCMAKE_C_COMPILER=$ZIG_C \
    # -DCMAKE_CXX_COMPILER=$ZIG_CXX \
    # -DBUILD_FUZZER=ON \
PKG_CONFIG_PATH=$DEP_DIR/lib/pkgconfig/ cmake \
    -DCMAKE_EXPORT_COMPILE_COMMANDS=1 \
    -DCMAKE_C_COMPILER=clang \
    -DCMAKE_CXX_COMPILER=clang++ \
    -DOPENSSL_ROOT_DIR=$DEP_DIR \
    -DCMAKE_BUILD_TYPE=Debug \
    -DCMAKE_INSTALL_PREFIX=$DEP_DIR \
    -DWITH_DTRACE=OFF \
    -DWITH_H2OLOG=OFF \
    ..

make VERBOSE=1 -j12
popd
./build/h2o -c ./tmp/etc/h2o.conf
