# https-proxy-benchmark

Benchmark between major https proxys based on docker images.

Benchmarks are run using siege.

All proxys use the same backend server based on [static-website-sample](https://github.com/petitchevalroux/static-website-sample) which is a docker nginx image containing static files.

## Todo
 * Nginx as proxy

## Usage
### Clone this repository and change directory

```bash
git clone https://github.com/petitchevalroux/https-proxy-benchmark.git
cd https-proxy-benchmark
```

### Define hostname
Add the following hostname in your /etc/hosts :
```bash
127.0.0.1 docker.localhost
```

### Start services
```bash
cd docker
docker-compose up --build 
```

## Benchmark using siege
```bash
siege -r once -c 20 -f urls-(hitch|haproxy).txt

```
 * -r how many time to repeat (once = 1 request per url in files)
 * -c how many concurrent client
 * -f file containing urls (1 per line)  urls-hitch.txt for benchmark hitch, urls-haproxy.txt for haproxy

## Service ports
 * Nginx (HTTP Backend) run on port 80
 * Haproxy run on port 10443
 * Hitch run on port 11443

## Results :
### 2018-10-09
#### Hitch

#### Haproxy

Author : [Patrick Poulain](http://petitchevalroux.net)
