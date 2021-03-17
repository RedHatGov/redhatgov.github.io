#!/usr/bin/env bash

for i in {1..30}; do userdel student$i ; done
for i in {1..30}; do rm -rf /home/student$i ; done
