//
//  ViewController.m
//  MultiThreadingDemo2
//
//  Created by mac on 8/5/15.
//  Copyright (c) 2015 vstacks. All rights reserved.
//

#import "ViewController.h"
#import "NSInvocationClass.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;
@property ( nonatomic)  UILabel *label3,*label4,*label5,*label6;


@end

@implementation ViewController
@synthesize label3,label,label4,label5,label6;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
// call first thread or invoke first operation
    NSInvocationClass*class=[[NSInvocationClass alloc]init];
    [class startCounting];
    [class usingNSThread];
    [class concatinateTwoStrings:@"Hello"];

#pragma mark create second label dynamically
    label2=[[UILabel alloc]initWithFrame:CGRectMake(63, 190, 200, 50)];
    label2.backgroundColor=[UIColor redColor];
    [self.view addSubview:label2];
    
#pragma mark create Third label dynamically
    label3=[[UILabel alloc]initWithFrame:CGRectMake(63, 250, 200, 50)];
    label3.backgroundColor=[UIColor redColor];
    [self.view addSubview:label3];
    
#pragma mark create Third label dynamically
    label4=[[UILabel alloc]initWithFrame:CGRectMake(63, 310, 200, 50)];
    label4.backgroundColor=[UIColor redColor];
    [self.view addSubview:label4];

#pragma mark create Fifth label dynamically
    label5=[[UILabel alloc]initWithFrame:CGRectMake(63, 370, 200, 50)];
    label5.backgroundColor=[UIColor redColor];
    [self.view addSubview:label5];

#pragma mark create Sixth label dynamically
    label6=[[UILabel alloc]initWithFrame:CGRectMake(63, 430, 200, 50)];
    label6.backgroundColor=[UIColor redColor];
    [self.view addSubview:label6];
    
  
//    dispatch_queue_t queue2=dispatch_queue_create("manjeet", NULL);
//    dispatch_async(queue2, ^{
//
//    });
//
    [self updateSecondLabel];
   
#pragma mark invoke another thread in background
    NSInvocationOperation *operation=[[NSInvocationOperation alloc]initWithTarget:self selector:@selector(callingNewOperationQueue) object:nil];
    
    operationQueue=[[NSOperationQueue alloc]init];
    operationQueue.name=@"abhi";
    [operationQueue addOperation:operation];
    
    thread=[[NSThread alloc]initWithTarget:self selector:@selector(callNSThreadMethod) object:nil];
    thread.name=@"pankaj";
    [thread start];
    
    NSLog(@"operationQueue Name= %@",operationQueue.name);
    NSLog(@"operationQueue Name description= %@",operationQueue.name.description);
    
    
}
#pragma mark method for concatinating two strings
-(void)concatenateTwoStrings:(NSString*)string{
    
    
}


#pragma mark THreading using GCD concept in background
-(void)updateSecondLabel{
   
  
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        
        //Do EXTREME PROCESSING!!!
        for (int i = 0; i< 1000; i++) {
           // [NSThread sleepForTimeInterval:.05];
            NSLog(@"%i", i);
            dispatch_async(dispatch_get_main_queue(), ^{
                [label3 setText:[NSString stringWithFormat:@"%d",i]];
            });
        }
        
        
    });
}
#pragma mark call new OperationQueue
-(void)callingNewOperationQueue{
    for (int i=1000; i<2000; i++) {
        NSLog(@"ismainThread=%d",[NSThread isMainThread]);
   
        // stop operation execution in NSOperationQueue
        
        if (i==1500) {
            [operationQueue cancelAllOperations];
        }
        // get mainQueue from nsoperation to update the UI
       
        
        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
          label2.text=[NSString stringWithFormat:@"%d",i];

      }];
        
    
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   // add obeserver for notification name "updateValue" to update the value of label when notification fire
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateUI:) name:@"updatedValue" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateUILabel5:) name:@"updatedValue1" object:nil];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark set setter of strignNumber
-(void)setStringNumber:(NSMutableString *)stringNumber{
    _stringNumber=stringNumber;
    
}
-(void)updateUI:(NSNotification*)notification{
    NSDictionary *dict=[notification userInfo];
    // get main queue from thread and update the UI using GCD
    
   
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [label setText:[NSString stringWithFormat:@"%@",[dict valueForKey:@"value"]] ];
            //    [ label5 setText:[NSString stringWithFormat:@"%@",[dict valueForKey:@"value"]]];
    });
   
    
}
-(void)updateUILabel5:(NSNotification*)notification{
    NSDictionary *dict=[notification userInfo];
    // get main queue from thread and update the UI using GCD
    
    
  
    
    if ([[dict valueForKey:@"value"]integerValue]==500) {
        
        if (![[NSThread currentThread]isMainThread]) {
             [NSThread exit];
            
        }
    }
    dispatch_sync(dispatch_get_main_queue(), ^{
        //[label setText:[NSString stringWithFormat:@"%@",[dict valueForKey:@"value"]] ];
        [ label5 setText:[NSString stringWithFormat:@"%@",[dict valueForKey:@"value"]]];
    });
    
}
-(void)callNSThreadMethod{
    
    for (int i=0; i<1000; i++) {
        NSLog(@"threadname=%@",thread.name);
        NSLog(@"isMainthread=%d",[thread isMainThread]);
        
       /* if (i==500) {
            if (![NSThread isMainThread]) {
                [thread cancel];
            };// this method is used to stop NSthread execution
        }
        if ([thread isCancelled]) {
            [NSThread exit];
            //return;
        }*/
        
        if (i==800) {
            [NSThread exit];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [label4 setText:[NSString stringWithFormat:@"%d",i]];
        });
        
    }
}
@end
