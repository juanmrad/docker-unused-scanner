# Docker version of Insolita Unused Scanner

based on Unused Scanner tool by Insolita found at: https://github.com/Insolita/unused-scanner

## How to use:

```bash
docker run -v `pwd`:/app juanmrad/unused-scanner ./unused.php
```

### Power Users:

For power users with different configs:

```bash
# Add project dir reference. 
PROJECT_DIR=$(pwd)

# Add location of config file relative to docker container
CONFIG=/workdir/config/unused-scanner/prod.php

# Image Tag:
# tag is defined as: juanmrad/unused-scanner:[package version]
PHP_UNUSED_SCANNER=juanmrad/unused-scanner:2.2.0

docker run \
    --rm \
    -v $PROJECT_DIR:/workdir \
    -w /workdir \
    $IMAGE \
    $CONFIG
```
