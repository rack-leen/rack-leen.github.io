#!/usr/bin/env python
# coding=utf-8
def this_fails():
    x = 1/0

try:
    this_fails()
except ZeroDivisionError as err:
    print('Handling run-time error',err)
