# dcos-controller
Install the DC/OS CLI and provision selected demo(s).

#Demos

## Docker Cloud Hello World
Deploys the Docker container version of the Docker Cloud hello-world sample.

### Environment variables

* DCOS_CONTROLLER_INSTALL_DOCKERCLOUD_HELLO_WORLD: `true` - install [Dockercloud hello-world](https://github.com/docker/dockercloud-he
llo-world) demo.
* DOCKERCLOUD_DEMO_HAPROXY_VHOST: the virtual host name for the public exposing of the demo. Typically the DNS name of the ELB e.g. `dcos-cluster-elb-1413204708.eu-west-1.elb.amazonaws.com` or the FQDN of a host in a domain under your control.

## Service Discovery and Load Balancing
Install the Service Discovery and Load Balancing demo by Mesosphere.

### Environment variables

* DCOS_CONTROLLER_INSTALL_DEMO_SD_AND_LB_NGINX: `true` - install demo setting up Nginx as described in [Service discovery and load balancing with DCOS and marathon-lb: Part 1](https://mesosphere.com/blog/2015/12/04/dcos-marathon-lb/).
