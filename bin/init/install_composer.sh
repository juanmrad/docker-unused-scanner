#!/usr/bin/env bash

set -eu

ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )/../.." && pwd )"

EXPECTED_VERSION=2.0.12
EXPECTED_CHECKSUM=aaf3bc221512bd093701a101a1fe39bbec3c4deece88e6ef9faddda66d10e3e79eae6fff8c0486cde71771a6912b9b62

# Check for existing installation
if [ -e "${ROOT}"/bin/composer ]; then
    echo "Checking Composer version..."
    FOUND_VERSION=`( \
        cd "${ROOT}" && \
        ./bin/composer --version | \
        tail -1 | \
        awk '{print $3}' | \
        "${ROOT}"/bin/linux-sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g" \
    )`

    # Check version of installed composer
    if [ "$FOUND_VERSION" == "$EXPECTED_VERSION" ]; then
        # Version is as expected. We're done.
        echo "Composer ${EXPECTED_VERSION} already installed."
        exit 0
    else
        # Version does not match. Remove it.
        echo "Removing Composer version ${FOUND_VERSION}..."
        rm "${ROOT}"/bin/composer
    fi
fi

# Install composer
echo "Installing Composer ${EXPECTED_VERSION}..."
curl -L https://getcomposer.org/download/${EXPECTED_VERSION}/composer.phar > "${ROOT}"/bin/composer

echo -n "Checking the hash..."

if [[ ! $(shasum -a 384 "${ROOT}"/bin/composer) = "$EXPECTED_CHECKSUM"* ]]; then
    echo "ERROR: composer's sha256 doesn't match. Redownload it."
    exit 0
else
    echo "passed"
fi

# Fix permissions
echo "Setting composer permissions..."
chmod 755 "${ROOT}"/bin/composer

# Ensure ~/.composer exists for the Docker container to mount
echo "Initializing ~/.composer directory..."
if [ ! -d ~/.composer ]; then
    mkdir ~/.composer
fi

echo "Composer v${EXPECTED_VERSION} installation complete."
