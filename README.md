bgpgraph - print a network graph of routing information
=======================================================

[![Build status](https://github.com/mmitch/bgpgraph/workflows/Tests/badge.svg)](https://github.com/mmitch/bgpgraph/actions?query=workflow%3ATests)
[![GPL 3+](https://img.shields.io/badge/license-GPL%203%2B-blue.svg)](http://www.gnu.org/licenses/gpl-3.0-standalone.html)


license/copyright
-----------------

Copyright (C) 2011-2026 Christian Garbs <mitch@cgarbs.de>  
Licensed under GNU GPL 3 or later.

bgpgraph is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

bgpgraph is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with bgpgraph.  If not, see <http://www.gnu.org/licenses/>.


project homepage
----------------

  https://github.com/mmitch/bgpgraph


dependencies
------------

- ``dot`` from the [GraphViz](https://www.graphviz.org/) package
- one of
  - ``vtysh`` from the [quagga](https://www.quagga.net/) package
  - ``birdc`` from the [BIRD 1](https://bird.network.cz/) package
  - ``birdc`` from the [BIRD 2](https://bird.network.cz/) package


usage
-----

Run

```shell
vtysh -c 'show ip bgp' | vtysh_bgp_to_dot 1234 | dot -Tpng > graph.png
```

to generate a graph, where ``1234`` is your local AS and ``graph.png``
will be the generated graph.  You need read-access with ``vtysh``, of
course.


### excluding the local node from the graph

If you pass no local AS to ``vtysh_bgp_to_dot``, the local node will
not be included in the generated graph:

```shell
vtysh -c 'show ip bgp' | vtysh_bgp_to_dot | dot -Tpng > graph_without_local_node.png
```

### using BIRD instead of quagga

Use the scripts ``birdc_bgp_to_dot`` or ``bird2c_bgp_to_dot`` instead
of ``vtysh_bgp_to_dot``.

### add information to the nodes in the graph

If there is an ``info.conf`` in your current directory, it will be
read to spice up the graph.  The format of ``info.conf`` is whitespace
delimited fields:

- First field contains an AS number.
- Second field contains a name describing the AS.
- Third field optionally contains a flag for marking a node in the output.


#### example ``info.conf``

```
60001  this_is_me
60002  Network_A
60003  Network_B  important
60004  Network_C
```

This configuration will add labels to the graph nodes 60001 to 60004
and mark the node 60003 as important.


### add status information to the graph

If you want to add additional information to the generated graph, you
could use ``convert`` from the [Imagemagick](http://imagemagick.org/)
package like this:

```shell
vtysh -c 'show ip bgp' | ./vtysh_bgp_to_dot 60001 | dot -Tpng | \
convert - \
        -gravity Southwest -background white -splice 0x25 \
        -annotate +0+2 "  `hostname -f` - `date`  " graph.png
```

This will add a status text to the bottom of the graph containing the
hostname and the current date.


### remote operation

As ``vtysh_bgp_to_dot`` reads from stdin, it does not need to be
installed on your router.

If you have SSH access to the router, you can execute ``vtysh``
remotely and execute everything else locally like this:

```shell
ssh user@router 'vtysh -c "show ip bgp"' | vtysh_bgp_to_dot | ...
```

You can use the ``command=`` setting in ``~/.ssh/authorized_keys`` to
enable key-based login without password while restricting access to
the ``vtysh`` command.

Instead of SSH you could also use ``netcat`` and ``(x)inetd`` or a
cronjob plus some sort of network file exchange or even send the
``vtysh`` output by email and process it with ``procmail`` or
``maildrop``.

