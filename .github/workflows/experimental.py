#!/usr/bin/env python

f=open("/etc/docker/daemon.json","w")
f.write("{")
f.write('"experimental": true')
f.write("}")
f.close()

