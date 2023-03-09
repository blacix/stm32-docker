# download `en.st-stm32cubeide_1.12.0_14958_20230224_1824_amd64.deb_bundle.sh.zip` and copy next to thd Dockerfile
## TODO download with docker

# cd stm32-docker repo

# build the image
```
docker build -t stm32 .
```

# cd project dir

# import project to workspace
# clean and build the workspace
```
docker run --rm -v ${PWD}:/workdir/project stm32 /bin/bash -c '\
    stm32cubeide -noSplash \
    -data /workdir/cube_ide_workspace  \
    -application org.eclipse.cdt.managedbuilder.core.headlessbuild \
    -import /workdir/project/* \
    -build all \
    -cleanBuild all'
```