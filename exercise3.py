# -*- coding: utf-8 -*-
"""
Created on Sat Nov  9 16:29:57 2019

@author: gmoran
"""

# 3
rest1 = 51
rest2 = 29
pirates1 = 99
pirates2 = 77

# Iterating for number of possible coins that meets the condition of having a rest of 51 coins with 99 
# pirates and a rest of 29 with 77 pirates.
for i in range(1000):
    if i % pirates1 == rest1 and i % pirates2 == rest2:
        coins = i

# Iterating since 1 to quantity of coins, to find the number of pirates that makes the coin surplus maximun.
max_coins = 0
pirates = 0
for i in range(1,coins):
    x = coins % i
    if x > max_coins:
        max_coins = x
        pirates = i
print(str(coins) + ' total coins, ' + str(pirates) + ' pirates, ' + str(max_coins) +' coins for captain.'  )
