# vpn

### Описание домашнего задания:
1. Между двумя серверами поднять vpn в режимах:
- tun
- tap
Описать в чём разница, замерить и проанализировать скорость передачи данных в туннелях.
2. Поднять RAS на базе OpenVPN с клиентскими сертификатами. подключиться с локальной машины на созданный VPN-сервер.

##### Замер скорости туннеля VPN в режиме tap:

```
# iperf3 -c 10.10.10.1 -t 40 -i 5
```
<details>
  <summary>Результат теста:</summary>
  
```
Connecting to host 10.10.10.1, port 5201
[  4] local 10.10.10.2 port 54514 connected to 10.10.10.1 port 5201
[ ID] Interval           Transfer     Bandwidth       Retr  Cwnd
[  4]   0.00-5.00   sec   164 MBytes   276 Mbits/sec   88    606 KBytes       
[  4]   5.00-10.01  sec   162 MBytes   271 Mbits/sec   14    384 KBytes       
[  4]  10.01-15.00  sec   169 MBytes   283 Mbits/sec    0    622 KBytes       
[  4]  15.00-20.00  sec   156 MBytes   261 Mbits/sec  127    328 KBytes       
[  4]  20.00-25.00  sec   162 MBytes   272 Mbits/sec  121    264 KBytes       
[  4]  25.00-30.01  sec   166 MBytes   278 Mbits/sec    7    381 KBytes       
[  4]  30.01-35.00  sec   161 MBytes   270 Mbits/sec  126    410 KBytes       
[  4]  35.00-40.00  sec   162 MBytes   272 Mbits/sec    4    555 KBytes       
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bandwidth       Retr
[  4]   0.00-40.00  sec  1.27 GBytes   273 Mbits/sec  487             sender
[  4]   0.00-40.00  sec  1.27 GBytes   272 Mbits/sec                  receiver

iperf Done.
```
</details>

##### Замер скорости туннеля VPN в режиме tun:

```
# iperf3 -c 10.10.10.1 -t 40 -i 5
```
<details>
  <summary>Результат теста:</summary>
  
```
Connecting to host 10.10.10.1, port 5201
[  4] local 10.10.10.2 port 54518 connected to 10.10.10.1 port 5201
[ ID] Interval           Transfer     Bandwidth       Retr  Cwnd
[  4]   0.00-5.01   sec   168 MBytes   282 Mbits/sec   81    439 KBytes       
[  4]   5.01-10.00  sec   167 MBytes   281 Mbits/sec   76    221 KBytes       
[  4]  10.00-15.00  sec   169 MBytes   283 Mbits/sec   31    381 KBytes       
[  4]  15.00-20.00  sec   173 MBytes   290 Mbits/sec    0    628 KBytes       
[  4]  20.00-25.00  sec   167 MBytes   281 Mbits/sec  137    503 KBytes       
[  4]  25.00-30.00  sec   170 MBytes   285 Mbits/sec   34    530 KBytes       
[  4]  30.00-35.00  sec   164 MBytes   275 Mbits/sec  185    311 KBytes       
[  4]  35.00-40.00  sec   171 MBytes   286 Mbits/sec   14    449 KBytes       
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bandwidth       Retr
[  4]   0.00-40.00  sec  1.32 GBytes   283 Mbits/sec  558             sender
[  4]   0.00-40.00  sec  1.32 GBytes   283 Mbits/sec                  receiver

iperf Done.

```
</details>

Вывод: при большей пропускной способности туннеля VPN типа `tun`, по отношению к `tap`, он имеет и большее число повторно отправленных TCP-сегментов (см. знач. Retr).




