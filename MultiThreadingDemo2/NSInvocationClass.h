//
//  NSInvocationClass.h
//  MultiThreadingDemo2
//
//  Created by mac on 8/5/15.
//  Copyright (c) 2015 vstacks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSInvocationClass : NSObject
@property (nonatomic,strong)NSOperationQueue *queue;
-(void)startCounting;
-(void)printCount;
@end
