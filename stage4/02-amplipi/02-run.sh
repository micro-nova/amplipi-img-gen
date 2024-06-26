#!/bin/bash -e

on_chroot << EOF
        set -x
        sudo sed -i "s|console=serial0,115200 ||" /boot/cmdline.txt
        sudo rm -rf /home/${FIRST_USER_NAME}/amplipi-dev # for development re-runs
        sudo wget -O /tmp/release.tgz https://github.com/micro-nova/${REPO}/archive/refs/tags/${AMPLIPI_VERSION}.tar.gz
        sudo tar xvzf /tmp/release.tgz -C /home/pi
        sudo mv /home/pi/${REPO}-${AMPLIPI_VERSION} /home/${FIRST_USER_NAME}/amplipi-dev
        sudo chown ${FIRST_USER_NAME}:${FIRST_USER_NAME} -R /home/${FIRST_USER_NAME}/amplipi-dev
        sudo -u ${FIRST_USER_NAME} python3 /home/${FIRST_USER_NAME}/amplipi-dev/scripts/configure.py --python-deps --os-deps --web --display --audiodetector --ci-mode --development
        sudo sed -Ei 's|^(.*)$|\1 quiet init=/home/pi/amplipi-dev/scripts/first_boot_partitioning|' /boot/cmdline.txt
        sudo rm -f /home/${FIRST_USER_NAME}/amplipi-dev/house.json /tmp/release.tgz
EOF

