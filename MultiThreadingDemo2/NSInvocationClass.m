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
-(void)usingNSThread{
    NSThread *thread=[[NSThread alloc]initWithTarget:self selector:@selector(printCount1) object:nil];
    thread.name=@"manoj";
    [thread start];
}
-(void)printCount1{
    for (int i=0; i<1000; i++) {
        NSLog(@"%d",i);
        NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:i],@"value", nil ];
        // post notification on value change to update the UI of viewcontroller
        if ([[NSThread currentThread]isCancelled]) {
            [NSThread exit];
            return;
        }
        [[NSNotificationCenter defaultCenter]postNotificationName:@"updatedValue1" object:nil userInfo:dict];
    }
    
    
}

-(void)concatinateTwoStrings:(NSString *)string{
    NSInvocationOperation *invocationOperation=[[NSInvocationOperation alloc]initWithTarget:self selector:@selector(stringAppend:) object:nil];
    NSOperationQueue *operationQueue=[NSOperationQueue new];
    operationQueue.name=@"stringAppend";
    
    NSInvocationOperation *invocationOperation2=[[NSInvocationOperation alloc]initWithTarget:self selector:@selector(finalAppendedString) object:nil];
    
    [invocationOperation2 addDependency:invocationOperation];
    
    [operationQueue addOperation:invocationOperation];
    [operationQueue addOperation:invocationOperation2];
    [operationQueue waitUntilAllOperationsAreFinished];
    
}
-(NSString*)stringAppend:(NSString*)stringparam{
    //NSString *string;
    NSMutableString *stringAppend=[[NSMutableString alloc]init];
  stringAppend=  [stringAppend stringByAppendingString:stringparam];
    
    NSLog(@"string=%@",stringAppend );
    return stringAppend;
}

-(void)finalAppendedString{
    NSMutableString*string3=[[NSMutableString alloc]initWithString:@"kaushal yadav"];
    NSString*string2= [self stringAppend:@"hello"];
   string3= [string3 stringByAppendingString:string2];
    NSLog(@"final string=%@",string3);
}
@end
