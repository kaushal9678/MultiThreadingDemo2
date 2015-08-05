//
//  main.m
//  MultiThreadingDemo2
//
//  Created by mac on 8/5/15.
//  Copyright (c) 2015 vstacks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "NSInvocationClass.h"
int main(int argc, char * argv[]) {
    @autoreleasepool {
      
        for (int i=0; i<10; i++) {
            NSLog(@"hello kaushal");
            
        }
//        NSInvocationClass*class=[[NSInvocationClass alloc]init];
//        [class startCounting];
//
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
