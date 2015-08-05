//
//  NSInvocationClass.m
//  MultiThreadingDemo2
//
//  Created by mac on 8/5/15.
//  Copyright (c) 2015 vstacks. All rights reserved.
//


/* 
 
 use this class for start one operation to print numbers from 1 to 10 and fire a notification when value change to update the value of label.
 
 */
 


#import "NSInvocationClass.h"
#import "ViewController.h"
@implementation NSInvocationClass
@synthesize queue;

-(void)startCounting{
    
    NSInvocationOperation *invocation=[[NSInvocationOperation alloc]initWithTarget:self selector:@selector(printCount) object:nil];
    queue=[[NSOperationQueue alloc]init];
    queue.name=@"kaushal";
   
    [queue addOperation:invocation];
    
}

-(void)printCount{
    for (int i=0; i<1000; i++) {
        NSLog(@"%d",i);
        NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:i],@"value", nil ];
     // post notification on value change to update the UI of viewcontroller 
        [[NSNotificationCenter defaultCenter]postNotificationName:@"updatedValue" object:nil userInfo:dict];
    }
    
    
}

@end
