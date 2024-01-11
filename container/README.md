```
cd container

# build container
docker build --no-cache --force-rm ./ -t lc-dune:0.0.1

# run container
docker run -it lc-dune:0.0.1 /bin/bash

# run container temporary
docker run --rm -it lc-dune:0.0.1 /bin/bash
```

https://v2.aintek.xyz/posts/minimum-docker-for-ocaml