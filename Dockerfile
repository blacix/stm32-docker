# Base image which contains global dependencies
FROM ubuntu:22.04 as base
WORKDIR /workdir

# ARG USER_NAME=jenkins
# ARG USER_ID=1000
# ARG GROUP_ID=1000

# # Create a new user with the desired UID and GID
# RUN groupadd -g ${GROUP_ID} ${USER_NAME} && \
#     useradd -u ${USER_ID} -g ${GROUP_ID} -ms /bin/bash ${USER_NAME}

ENV DEBIAN_FRONTEND=noninteractive
ENV ACCEPT_EULA=Y
ENV LICENSE_ALREADY_ACCEPTED=1

# System dependencies
RUN mkdir -p /tmp/install && \
	apt update -y && apt upgrade -y && apt install -y --no-install-recommends \
        wget \
        unzip \
        build-essential \
        # stm32 + uavcan
        cmake \
        ninja-build \
        git \
        python3 \
        python3-pip \
        # cube dependencies
        apt-utils \
        udev \
        libusb-1.0-0 \
        libusb-dev \
        libwebkit2gtk-4.0-37 \
        libpython2.7 \
        libncurses5 \
        && \
    # uavcan
    python3 -m pip install nunavut && \
    apt -y clean && apt -y autoremove && rm -rf /var/lib/apt/lists/*
    


ARG STM23_CUBE_IDE_VERSION=stm32cubeide_1.12.0
ARG CUBE_IDE_INSTALLER_ZIP=en.st-stm32cubeide_1.12.0_14958_20230224_1824_amd64.deb_bundle.sh.zip
# ARG CUBE_IDE_INSTALLER_SH=st-stm32cubeide_1.12.0_14980_20230301_1550_amd64.deb_bundle.sh
# mind the prefix: st-
ARG CUBE_IDE_INSTALLER_SH=st-${STM23_CUBE_IDE_VERSION}*.sh

WORKDIR /tmp/install
COPY ${CUBE_IDE_INSTALLER_ZIP} ./
RUN unzip ${CUBE_IDE_INSTALLER_ZIP} && \
    chmod u+x ${CUBE_IDE_INSTALLER_SH} && \
    ./${CUBE_IDE_INSTALLER_SH} --quiet && \
    # install every pacakge separately
    # ./${CUBE_IDE_INSTALLER} --quiet --noexec --keep --target cube_installer && \
    # cd cube_installer && \
    # apt install -y ./segger-jlink-udev-rules-*.deb ./st-stlink-udev-rules-*.deb ./st-stlink-server-*.deb ./st-stm32cubeide-*.deb
    cd && rm -rf /tmp/*

# add Cube IDE to the path
ENV PATH="/opt/st/${STM23_CUBE_IDE_VERSION}:${PATH}"


# workspace folder for cube ide
# RUN chown -R ${USER_NAME}:${USER_NAME} /workdir
# USER ${USER_NAME}:${USER_NAME}
RUN mkdir /workdir/project && mkdir /workdir/cube_ide_workspace && \
    chmod a+rwx /workdir/*

WORKDIR /workdir/project
