# POC Keycloak-proxy OAuth

## Components

- backend
  it's only example test component, backend http service, which will print current time, hostname and request headers

- keycloak-proxy
  https://github.com/gambol99/keycloak-proxy

## Pros and cons

Cons:

Pros:

## Stress test

```
[root@dockerhost keycloak-proxy]# ab -n 40000 -c 300 -C "kc-access=eyJhbGciOiJSUzI1NiIsImtpZCI6ImIzMDY0NjhlYmI3MDFmMzA2OWEyYzA0MTBiNmIxMzdmMjU2Yzg2NDgifQ.eyJhenAiOiIxNjI5ODY0MDgzMDItdHNram10cGk5bDhhb3U3NWdhZWZhZzk4YnBnYXIxb3MuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxNjI5ODY0MDgzMDItdHNram10cGk5bDhhb3U3NWdhZWZhZzk4YnBnYXIxb3MuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTc0OTg1NTYzMjc1MjgyMDY2NjIiLCJlbWFpbCI6Imphbi5nYXJhakBnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwiYXRfaGFzaCI6InlUQWNKbGYwTE44YmV6Y2NuaDRXYUEiLCJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJpYXQiOjE1MDAzNzcyNDIsImV4cCI6MTUwMDM4MDg0MiwibmFtZSI6IkphbiBHYXJhaiIsInBpY3R1cmUiOiJodHRwczovL2xoNC5nb29nbGV1c2VyY29udGVudC5jb20vLURld00wLVJxLTg4L0FBQUFBQUFBQUFJL0FBQUFBQUFBQnBvL1EwVHR2UnUzZFJnL3M5Ni1jL3Bob3RvLmpwZyIsImdpdmVuX25hbWUiOiJKYW4iLCJmYW1pbHlfbmFtZSI6IkdhcmFqIiwibG9jYWxlIjoiZW4ifQ.eGGE4JxQCBb9bNEiCGfcdx1gmsrkfCn_q8ocZ011yPLRzyitxxq1Gj2mn_VKZtltxd0U6sYLdkZczgH2KnG0fdhmnEi6ooRZdzr8uzqKFB9VC-0O14JrNPsO4FcBls7Uxq1HhwTzEcks9HT-leqnWE-I02YJD7RMLYlvErkAT5hesThtTntX-GV1nE86cq19SOPatx7jSBBL4ff7WFzoBAZ6bl_x1gm-0PYSYj9b1XEow100Of2pUnDoUh_4NN4a3xZuyJaKP6cpRoCOSx9grygwdzlxa3ILscPsfeV1DTw9YQvRz_o9kKWJ3tEGU-xLIjq2jtGWbaRWAMKnl69fUw" http://192.168.32.128:2016/
This is ApacheBench, Version 2.3 <$Revision: 1430300 $>
Copyright 1996 Adam Twiss, Zeus Technology Ltd, http://www.zeustech.net/
Licensed to The Apache Software Foundation, http://www.apache.org/

Benchmarking 192.168.32.128 (be patient)
Completed 4000 requests
Completed 8000 requests
Completed 12000 requests
Completed 16000 requests
Completed 20000 requests
Completed 24000 requests
Completed 28000 requests
Completed 32000 requests
Completed 36000 requests
Completed 40000 requests
Finished 40000 requests


Server Software:
Server Hostname:        192.168.32.128
Server Port:            2016

Document Path:          /
Document Length:        3948 bytes

Concurrency Level:      300
Time taken for tests:   18.805 seconds
Complete requests:      40000
Failed requests:        0
Write errors:           0
Total transferred:      161800000 bytes
HTML transferred:       157920000 bytes
Requests per second:    2127.05 [#/sec] (mean)
Time per request:       141.041 [ms] (mean)
Time per request:       0.470 [ms] (mean, across all concurrent requests)
Transfer rate:          8402.25 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0   23 145.7      1    1020
Processing:     6  118  50.4    109     525
Waiting:        1  116  50.2    107     445
Total:          9  141 159.7    111    1520

Percentage of the requests served within a certain time (ms)
  50%    111
  66%    132
  75%    147
  80%    158
  90%    194
  95%    233
  98%   1085
  99%   1160
 100%   1520 (longest request)

$ docker stats
CONTAINER           CPU %               MEM USAGE / LIMIT     MEM %               NET I/O             BLOCK I/O           PIDS
keycloak-proxy      289.15%             33.21MiB / 3.686GiB   0.88%               0B / 0B             0B / 0B             13
```

