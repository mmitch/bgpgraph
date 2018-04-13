bgpgraph - print a network graph of routing information
=======================================================

[![GPL 3+](https://img.shields.io/badge/license-GPL%203%2B-blue.svg)](http://www.gnu.org/licenses/gpl-3.0-standalone.html)


license/copyright
-----------------

Copyright (C) 2011,2014,2015,2018  Christian Garbs <mitch@cgarbs.de>  
Licensed under GNU GPL 3 or later.


project homepage
----------------

  https://github.com/mmitch/bgpgraph
  

dependencies
------------

- ``vtysh`` from the [quagga](https://www.quagga.net/) package
- ``dot`` from the [GraphViz](https://www.graphviz.org/) package


usage
-----

Run

```shell
vtysh -c 'show ip bgp' | vtysh_bgp_to_dot 1234 | dot -Tpng > graph.png
```

to generate a graph, where ``1234`` is your local AS and ``graph.png``
will be the generated graph.  You need read-access with ``vtysh``, of
course.


### optional features

If there is an ``info.conf`` in your current directory, it will be
read to spice up the graph.  The format of ``info.conf`` is whitespace
delimited fields:

- First field contains an AS number.
- Second field contains a name describing the AS.
- Third field optionally contains a flag for marking a node in the output.


#### Example ``info.conf``

```
60001  this_is_me
60002  Network_A
60003  Network_B  important
60004  Network_C
```

This configuration will add labels to the graph nodes 60001 to 60004
and mark the node 60003 as important.
