#!/bin/bash -e

on_chroot << EOF
        set -x
        curl -fsSL https://deb.nodesource.com/setup_18.x -o nodesource_setup.sh
        bash nodesource_setup.sh
EOF

