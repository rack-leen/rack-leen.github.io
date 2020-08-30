#!/bin/bash
rm -rf /usr/bin/grade

wget -O /usr/bin/grade http://server.group8.example.com/pub/rhce-grade

chmod 755 /usr/bin/grade
