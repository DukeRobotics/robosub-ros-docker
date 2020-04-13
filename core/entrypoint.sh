#!/bin/bash

# Generate ssh keys
ssh-keygen -A

# Start the ssh server
service ssh restart &

bash
