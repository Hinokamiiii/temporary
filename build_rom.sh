# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/PixysOS/manifest -b thirteen -g default,-mips,-darwin,-notdefault
git clone https://github.com/NRanjan-17/local_manifest.git --depth 1 -b Pixys-13-violet .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch pixys_violet-userdebug
export KBUILD_BUILD_USER=HyperPower
export KBUILD_BUILD_HOST=17
export BUILD_USERNAME=HyperPower
export BUILD_HOSTNAME=17
export TZ=Asia/Delhi #put before last build command
make pixys

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
