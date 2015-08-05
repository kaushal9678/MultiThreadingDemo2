//
//  ViewController.h
//  MultiThreadingDemo2
//
//  Created by mac on 8/5/15.
//  Copyright (c) 2015 vstacks. All rights reserved.
//

/* 
 
 THIS CLASS SHOWS HOW TO USE MULTITHREADING IN DIFFERENT WAYS USING GCD, NSOPERATIONQUEUE AND NSTHREAD
 
 
 
 */

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{
    UILabel *label2;
    NSThread *thread;
      NSOperationQueue *operationQueue;
}
@property (nonatomic,strong)NSMutableString *stringNumber;

@end

