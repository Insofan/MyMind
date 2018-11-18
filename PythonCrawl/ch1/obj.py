#!/usr/bin/env python

class Bike:
    def __init__(self):
        self.other = 'basket'

    compose = ['frame', 'wheel', 'pedal']

    def use(self):
        print('you are riding')

    def time(self, time):
        print('you ride {}m'.format(time * 100))

myBike = Bike()
yourBike = Bike()

print(myBike.compose)
print(yourBike.compose)

myBike.use()
myBike.time(10)

print(myBike.other)
