# https-proxy-benchmark

Benchmark between major https proxys based on docker images

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

## Benchmark
```bash
ab -n 10000 -c 50 https://docker.localhost:11443/

```

## Service ports
 * Nginx (HTTP Backend) run on port 80
 * Haproxy run on port 10443
 * Hitch run on port 11443

## Results :
### 2018-10-09
#### Hitch
ab -n 10000 -c 50 https://docker.localhost:11443/
This is ApacheBench, Version 2.3 <$Revision: 1826891 $>
Copyright 1996 Adam Twiss, Zeus Technology Ltd, http://www.zeustech.net/
Licensed to The Apache Software Foundation, http://www.apache.org/

Benchmarking docker.localhost (be patient)
Completed 1000 requests
Completed 2000 requests
Completed 3000 requests
Completed 4000 requests
Completed 5000 requests
Completed 6000 requests
Completed 7000 requests
Completed 8000 requests
Completed 9000 requests
Completed 10000 requests
Finished 10000 requests


Server Software:        nginx/1.15.6
Server Hostname:        docker.localhost
Server Port:            11443
SSL/TLS Protocol:       TLSv1.2,ECDHE-RSA-AES256-GCM-SHA384,4096,256
TLS Server Name:        docker.localhost

Document Path:          /
Document Length:        612 bytes

Concurrency Level:      50
Time taken for tests:   234.938 seconds
Complete requests:      10000
Failed requests:        0
Total transferred:      8450000 bytes
HTML transferred:       6120000 bytes
Requests per second:    42.56 [#/sec] (mean)
Time per request:       1174.689 [ms] (mean)
Time per request:       23.494 [ms] (mean, across all concurrent requests)
Transfer rate:          35.12 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:       28 1003 153.2   1007    2535
Processing:    10  168  68.4    149    1805
Waiting:        6  140  47.8    133    1709
Total:         38 1171 158.3   1165    2782

Percentage of the requests served within a certain time (ms)
  50%   1165
  66%   1210
  75%   1240
  80%   1261
  90%   1319
  95%   1398
  98%   1486
  99%   1552
 100%   2782 (longest request)

#### Haproxy
```bash
ab -n 10000 -c 50 https://docker.localhost:10443/
This is ApacheBench, Version 2.3 <$Revision: 1826891 $>
Copyright 1996 Adam Twiss, Zeus Technology Ltd, http://www.zeustech.net/
Licensed to The Apache Software Foundation, http://www.apache.org/

Benchmarking docker.localhost (be patient)
Completed 1000 requests
Completed 2000 requests
Completed 3000 requests
Completed 4000 requests
Completed 5000 requests
Completed 6000 requests
Completed 7000 requests
Completed 8000 requests
Completed 9000 requests
Completed 10000 requests
Finished 10000 requests


Server Software:        nginx/1.15.6
Server Hostname:        docker.localhost
Server Port:            10443
SSL/TLS Protocol:       TLSv1.2,ECDHE-RSA-AES256-GCM-SHA384,4096,256
TLS Server Name:        docker.localhost

Document Path:          /
Document Length:        612 bytes

Concurrency Level:      50
Time taken for tests:   188.311 seconds
Complete requests:      10000
Failed requests:        0
Total transferred:      8450000 bytes
HTML transferred:       6120000 bytes
Requests per second:    53.10 [#/sec] (mean)
Time per request:       941.557 [ms] (mean)
Time per request:       18.831 [ms] (mean, across all concurrent requests)
Transfer rate:          43.82 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:       30  698 216.1    741    1854
Processing:     7  241 214.5    154    1502
Waiting:        3  226 212.5    134    1495
Total:         37  939 279.8    894    2377

Percentage of the requests served within a certain time (ms)
  50%    894
  66%    980
  75%   1067
  80%   1124
  90%   1293
  95%   1467
  98%   1678
  99%   1767
 100%   2377 (longest request)
```

Author : [Patrick Poulain](http://petitchevalroux.net)
