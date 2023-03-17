# Docker for STM32CubeDE

## download STM32CubeDE for Ubuntu
`en.st-stm32cubeide_1.12.0_14958_20230224_1824_amd64.deb_bundle.sh.zip`

TODO download with docker


## Build the image
The default UID:GID is 1000:1000.
To build with adding the desired user, use:
```
docker build --build-arg USER_ID=$(id -u <username>) --build-arg GROUP_ID=$(id -g <username>) -t stm32 .
```

# 

## Build the project
```
cd <STM32CubeIDE project dir>
```

Import project to workspace.

Clean and build the workspace

```
docker run -u $(id -u):$(id -g) --rm -v ${PWD}:/workdir/project stm32 /bin/bash -c '\
	cd STM32CubeIDE && \
	stm32cubeide -noSplash \
	-data /workdir/cube_ide_workspace  \
	-application org.eclipse.cdt.managedbuilder.core.headlessbuild \
	-import /workdir/project/STM32CubeIDE \
	-build all'
```