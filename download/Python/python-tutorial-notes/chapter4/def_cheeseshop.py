#!/usr/bin/env python
# coding=utf-8
'''
命名关键字参数
'''
def cheeseshop(kind , *arguments , **keywords):#命名关键字参数使得关键字参数传入不受限制
    print("--Do you have any ",kind , "?")
    print("--i'm  sorry , we're all out of ",kind)
    for arg in arguments : #*arguments为可变参数,可以输入多个参数
        print(arg) #arg将多个参数分别提取出来
    print("-"*40)
    for kw in keywords: # **keywords为关键字参数，需要keyword=value组合   
        print(kw , ":",keywords[kw]) #kw为关键字，keywords[]为值

print(cheeseshop("Limburger","it's very runny,sir","it's really very , very runny ,sir",shopkeeper = "michael Palin",client = "John Cleese",shetch = "Cheese Shop shetch"))
