Apache HBase Docker Image
=========================

[![GitHub Workflow Status]][GitHub Workflow URL]
[![Docker Hub][Docker Pulls Badge]][Docker Hub URL]
[![Apache License Badge]][Apache License, Version 2.0]

![HBase Logo](https://user-images.githubusercontent.com/16126939/180642009-b6f44bda-bbdf-4c0f-a45e-d0c74214dfb4.png)

This image is used to quickly stand up a HBase instance for various development purposes:

1. A pseudo-distributed HBase instance with minimum configurations. Pseudo-distributed mode means that HBase still runs 
   completely on a single host, but each HBase daemon (HMaster, HRegionServer, and ZooKeeper) runs as a separate
   process. __The data is stored in a real HDFS__.
2. Access HBase Web UI from host machine
3. Access HBase REST API endpoints
4. Interact with HBase from local host through HBase shell

Getting Image
-------------

### Docker Hub

We can pull the image from [my docker hub](https://hub.docker.com/r/jack20191124/hbase/):

```console
docker pull jack20191124/hbase
```

### GitHub

We could also build the image from [my source repository](https://github.com/QubitPi/jupiter/tree/hbase/):

```console
git clone git@github.com:QubitPi/hbase.git
cd hbase-docker
docker build -t jack20191124/hbase .
```

Starting a Container
--------------------

Once image is on our machine(either by pulling or building), we can run HBase in 2 modes:

### Non-Interactive Mode

If we would like to have an HBase that just runs forever, run

```console
docker run -it -p 16010:16010 -p 8080:8080 jack20191124/hbase /etc/hbase-init.sh -d
```
    
The port forwarding `16010:16010` allows us to access HBase Web UI from a local port. Another port forwarding
`8080:8080` gives us the ability to access REST endpoints

> [!NOTE]
>
> The HDFS port is set in the upstream
> [hadoop image, which is 8020](https://github.com/QubitPi/jupiter/blob/hadoop/core-site.xml). If its port number
> changes, this config change should also be applied in this image for `hbase.rootdir`, which points to the address of 
> HDFS instance, using the hdfs://// URI syntax. By default, HDFS is running on the localhost at
> [port 8020](https://github.com/QubitPi/jupiter/blob/hbase/hbase-site.xml).
> 
> ```xml
> <property>
>     <name>hbase.rootdir</name>
>     <value>hdfs://localhost:8020/hbase</value>
> </property>
> ```

### Interactive Mode

If we would like to spin up an HBase and interact with it using shell, run

```console
docker run -it -p 16010:16010 -p 8080:8080 jack20191124/hbase /etc/hbase-init.sh -bash
```

HBase Web UI
------------

The quickest way to make sure that this container is working properly is going to http://localhost:16010 to view the
HBase Web UI

HBase Interactive Shell
-----------------------

In addition to being a local dev instance, this container automatically connects to `hbase shell` upon start. Here are 
some example commands for us to play with

Create a table:

```console
$HBASE_HOME/bin/hbase shell

create "test", "cf"
```

The table created is called `test` with one column family `cf`. Now we can put data into the table:

```console
put "test", "row1", "cf:a", "value1"
```

Here we insert value `value1` into row `row1` at column `cf:a`. Columns in HBase are comprised of a column family
prefix, `cf` in this example, followed by a colon and then a column qualifier suffix, `a` in this case.

Scan the table for all data at once:

```console
scan "test"
```
    
Get a single row of data:

```console
get "test", "row1"
```

If we want to delete a table or change its settings, as well as in some other situations, we need to disable the table 
first:

```console
disable "test"
```
    
Drop the table:

```console
drop "test"
```
    
HBase REST API
--------------

We can experiment with HBase REST API by taking the example request from
https://hbase.apache.org/book.html#_using_rest_endpoints . Replace `example.com:8000` with `localhost:8080`.

License
-------

The use and distribution terms for [HBase Docker][Docker Hub URL] are covered by the [Apache License, Version 2.0].

[Apache License Badge]: https://img.shields.io/badge/Apache%202.0-FE5D26.svg?style=for-the-badge&logo=Apache&logoColor=white
[Apache License, Version 2.0]: https://www.apache.org/licenses/LICENSE-2.0

[Docker Pulls Badge]: https://img.shields.io/docker/pulls/jack20191124/hbase?style=for-the-badge&logo=docker&logoColor=white&labelColor=5BBCFF&color=7EA1FF
[Docker Hub URL]: https://hub.docker.com/r/jack20191124/hbase

[GitHub Workflow Status]: https://img.shields.io/github/actions/workflow/status/QubitPi/hbase/ci-cd.yaml?branch=master&logo=github&style=for-the-badge&label=CI/CD&labelColor=2088FF
[GitHub Workflow URL]: https://github.com/QubitPi/hbase/actions/workflows/ci-cd.yaml
