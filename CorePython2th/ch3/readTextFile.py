#!/usr/bin/env python

'readTextFile.py -- read and display test file'

fname = raw_input('Enter filename:')
print

try:
    fobj = open(fname, 'r')
except IOError, e:
    print "*** file open error:", e
else:
    #display contents to the screen
    for eachLine in fobj:
        print eachLine,
    fobj.close()
