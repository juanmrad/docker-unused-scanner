# Docker version of Insolita Unused Scanner

based on Unused Scanner tool by Insolita found at: https://github.com/Insolita/unused-scanner

## How to use:

```bash
docker run -v `pwd`:/app juanmrad/unused-scanner ./unused.php
```

### Power Users:

For power users with different configs:

```bash
#add project dir reference. 
PROJECT_DIR=$(pwd)

#add location of config file relative to docker container
CONFIG=/workdir/config/unused-scanner/prod.php

docker run \
    --rm \
    -v $PROJECT_DIR:/workdir \
    -w /workdir \
    $IMAGE \
    $CONFIG
```
