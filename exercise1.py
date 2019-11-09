# -*- coding: utf-8 -*-
"""
Created on Sat Nov  9 16:27:17 2019

@author: gmoran
"""


# 1
import random

def weighted_random(values, weights):
    total_weight = sum(weights)
    acum_weights = [w / total_weight for w in weights[:]]
    for i in range(len(weights)-1):
        acum_weights[i+1] += acum_weights[i]
    rand = random.random()
    for value, weight in zip(values, acum_weights):
        if weight > rand:
            return value

# The function had an error when calculating de the acumulate probability. For each value was defining the acumulate 
# adding its own puntual probability. This way, the first value (1), had a acum_weights of one and all de random 
# number were under it, so thats why was allways returning 1.
# With the fix, the acumulate is the sum of the puntual probability of values less than or equal to it self.