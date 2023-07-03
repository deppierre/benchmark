# benchmark

## Build new image
```bash
docker build -t ycsb_benchmark .
```

## Run docker image
```bash
docker run --rm -d --name newYcsb ycsb_benchmark
```

## Load then RUN YCSB workload
```bash
docker exec -w /usr/local/ycsb newYcsb ./bin/ycsb.sh load mongodb -s -P benchmark
docker exec -w /usr/local/ycsb newYcsb ./bin/ycsb.sh run mongodb -s -P benchmark
```