# Https Proxy Comparison - nginx vs haproxy vs hitch

Benchmark between major https proxys based on docker images.

Tests are run using siege.

All proxys use the same backend server based on [static-website-sample](https://github.com/petitchevalroux/static-website-sample) which is a docker nginx image containing static files.

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
siege -r once -c 20 -f urls-(hitch|haproxy|nginx).txt

```
 * -r how many time to repeat (once = 1 request per url in files)
 * -c how many concurrent client
 * -f file containing urls (1 per line)  urls-hitch.txt for benchmark hitch, urls-haproxy.txt for haproxy, urls-nginx.txt for haproxy

## Service ports
 * Nginx (HTTP Backend) run on port 80
 * Haproxy run on port 10443
 * Hitch run on port 11443

### First Run 2018-10-19
#### Summary
Keep-alive is off between siege Gzip too

At concurrency level = 50 Nginx seems to take the lead :
 * Nginx : 389.62 trans/sec
 * Haproxy 138.51 trans/sec
 * Hitch 130.07 trans/sec

#### Explaination
As Backend server send etag + Last Modified headers, nginx may cache backend responses in proxy level which may explain the differences between the two others proxys".

Further tests must be made in order to cancel this hypothesis disabling this behaviour.

#### Results
```
siege -r once -c 1 -f urls-haproxy.txt

Transactions:                  12010 hits
Availability:                 100.00 %
Elapsed time:                 427.53 secs
Data transferred:            1200.83 MB
Response time:                  0.02 secs
Transaction rate:              28.09 trans/sec
Throughput:                     2.81 MB/sec
Concurrency:                    0.66
Successful transactions:       12009
Failed transactions:               0
Longest transaction:            0.42
Shortest transaction:           0.00

siege -r once -c 1 -f urls-hitch.txt
Transactions:                  12010 hits
Availability:                 100.00 %
Elapsed time:                 423.64 secs
Data transferred:            1200.83 MB
Response time:                  0.02 secs
Transaction rate:              28.35 trans/sec
Throughput:                     2.83 MB/sec
Concurrency:                    0.67
Successful transactions:       12009
Failed transactions:               0
Longest transaction:            0.43
Shortest transaction:           0.00

siege -r once -c 1 -f urls-nginx.txt
Transactions:                  12010 hits
Availability:                 100.00 %
Elapsed time:                 418.81 secs
Data transferred:            1200.83 MB
Response time:                  0.02 secs
Transaction rate:              28.68 trans/sec
Throughput:                     2.87 MB/sec
Concurrency:                    0.68
Successful transactions:       12009
Failed transactions:               0
Longest transaction:            0.50
Shortest transaction:           0.00

siege -r once -c 50 -f urls-haproxy.txt
Transactions:                 600500 hits
Availability:                 100.00 %
Elapsed time:                4335.51 secs
Data transferred:           60041.70 MB
Response time:                  0.35 secs
Transaction rate:             138.51 trans/sec
Throughput:                    13.85 MB/sec
Concurrency:                   48.14
Successful transactions:      600450
Failed transactions:               0
Longest transaction:            5.43
Shortest transaction:           0.00

siege -r once -c 50 -f urls-hitch.txt
Transactions:                 600500 hits
Availability:                 100.00 %
Elapsed time:                4616.91 secs
Data transferred:           60041.70 MB
Response time:                  0.37 secs
Transaction rate:             130.07 trans/sec
Throughput:                    13.00 MB/sec
Concurrency:                   48.33
Successful transactions:      600450
Failed transactions:               0
Longest transaction:            5.72
Shortest transaction:           0.00

siege -r once -c 50 -f urls-nginx.txt
Transactions:                 600500 hits
Availability:                 100.00 %
Elapsed time:                1541.23 secs
Data transferred:           60041.70 MB
Response time:                  0.12 secs
Transaction rate:             389.62 trans/sec
Throughput:                    38.96 MB/sec
Concurrency:                   45.22
Successful transactions:      600450
Failed transactions:               0
Longest transaction:            1.08
Shortest transaction:           0.00
```

#### Headers between client (siege) and server
##### Html backend
```
siege -g http://docker.localhost:80/index.html
HEAD /index.html HTTP/1.0
Host: docker.localhost
Accept: */*
User-Agent: Mozilla/5.0 (pc-x86_64-linux-gnu) Siege/4.0.2
Connection: close


HTTP/1.1 200 OK
Server: nginx/1.15.6
Date: Mon, 19 Nov 2018 13:06:55 GMT
Content-Type: text/html
Content-Length: 51474
Last-Modified: Wed, 14 Nov 2018 13:14:52 GMT
Connection: close
ETag: "5bec1fcc-c912"
Accept-Ranges: bytes
```

##### Haproxy
```
siege -g https://docker.localhost:10443/index.html
HEAD /index.html HTTP/1.0
Host: docker.localhost:10443
Accept: */*
User-Agent: Mozilla/5.0 (pc-x86_64-linux-gnu) Siege/4.0.2
Connection: close


HTTP/1.1 200 OK
Server: nginx/1.15.6
Date: Mon, 19 Nov 2018 13:08:07 GMT
Content-Type: text/html
Content-Length: 51474
Last-Modified: Wed, 14 Nov 2018 13:14:52 GMT
Connection: close
ETag: "5bec1fcc-c912"
Accept-Ranges: bytes
```

##### Hitch
```
siege -g https://docker.localhost:11443/index.html
HEAD /index.html HTTP/1.0
Host: docker.localhost:11443
Accept: */*
User-Agent: Mozilla/5.0 (pc-x86_64-linux-gnu) Siege/4.0.2
Connection: close


HTTP/1.1 200 OK
Server: nginx/1.15.6
Date: Mon, 19 Nov 2018 13:09:04 GMT
Content-Type: text/html
Content-Length: 51474
Last-Modified: Wed, 14 Nov 2018 13:14:52 GMT
Connection: close
ETag: "5bec1fcc-c912"
Accept-Ranges: bytes
```

##### Nginx
```
siege -g https://docker.localhost:12443/index.html
HEAD /index.html HTTP/1.0
Host: docker.localhost:12443
Accept: */*
User-Agent: Mozilla/5.0 (pc-x86_64-linux-gnu) Siege/4.0.2
Connection: close


HTTP/1.1 200 OK
Server: nginx/1.10.3
Date: Mon, 19 Nov 2018 13:09:40 GMT
Content-Type: text/html
Content-Length: 51474
Connection: close
Last-Modified: Wed, 14 Nov 2018 13:14:52 GMT
ETag: "5bec1fcc-c912"
Accept-Ranges: bytes
```

### Second Run 2018-12-06

#### Summary
In previous run I supposed Nginx (https proxy) may use http cache in order to limit backend requests, improving performances. This time backend headers are set to disable http caching.

Keep-alive is off between siege Gzip too. Etags and Last-Modified headers are removed from Backend. Cache-Control is set for no-cache on Backend.

At concurrency level = 50, on more time nginx takes the lead :
 * Nginx : 388.77 trans/sec
 * Haproxy 138.14 trans/sec
 * Hitch 129.88 trans/sec

#### Explaination
None, nginx performs better in this use case

#### Results
```
siege -g http://docker.localhost:80/index.html
HEAD /index.html HTTP/1.0
Host: docker.localhost
Accept: */*
User-Agent: Mozilla/5.0 (pc-x86_64-linux-gnu) Siege/4.0.2
Connection: close


HTTP/1.1 200 OK
Server: nginx/1.15.7
Date: Thu, 06 Dec 2018 13:05:43 GMT
Content-Type: text/html
Content-Length: 51474
Connection: close
Cache-Control: no-store, no-cache, must-revalidate, proxy-revalidate, max-age=0
Accept-Ranges: bytes

siege -r once -c 50 -f urls-haproxy.txt
Transactions:                 600500 hits
Availability:                 100.00 %
Elapsed time:                4347.01 secs
Data transferred:           60041.70 MB
Response time:                  0.35 secs
Transaction rate:             138.14 trans/sec
Throughput:                    13.81 MB/sec
Concurrency:                   48.14
Successful transactions:      600450
Failed transactions:               0
Longest transaction:            5.45
Shortest transaction:           0.00

siege -r once -c 50 -f urls-hitch.txt
Transactions:                 600500 hits
Availability:                 100.00 %
Elapsed time:                4623.49 secs
Data transferred:           60041.70 MB
Response time:                  0.37 secs
Transaction rate:             129.88 trans/sec
Throughput:                    12.99 MB/sec
Concurrency:                   48.32
Successful transactions:      600450
Failed transactions:               0
Longest transaction:            5.46
Shortest transaction:           0.00

siege -r once -c 50 -f urls-nginx.txt
Transactions:                 600500 hits
Availability:                 100.00 %
Elapsed time:                1544.63 secs
Data transferred:           60041.70 MB
Response time:                  0.12 secs
Transaction rate:             388.77 trans/sec
Throughput:                    38.87 MB/sec
Concurrency:                   45.23
Successful transactions:      600450
Failed transactions:               0
Longest transaction:            5.06
Shortest transaction:           0.00
```

Author : [Patrick Poulain](http://petitchevalroux.net)
