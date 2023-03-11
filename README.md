# Docker for STM32CubeDE

## download STM32CubeDE for Ubuntu
`en.st-stm32cubeide_1.12.0_14958_20230224_1824_amd64.deb_bundle.sh.zip`

TODO download with docker


## Build the image
```
docker build -t stm32 .
```

# 

## Build the project
```
cd <STM32CubeIDE project dir>
```

Import project to workspace.

Clean and build the workspace

```
docker run --rm -v ${PWD}:/workdir/project stm32 /bin/bash -c '\
	cd STM32CubeIDE && \
	stm32cubeide -noSplash \
	-data /workdir/cube_ide_workspace  \
	-application org.eclipse.cdt.managedbuilder.core.headlessbuild \
	-import /workdir/project/STM32CubeIDE \
	-build all'
```