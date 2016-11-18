//
//  ViewController.m
//  DVVAlertView
//
//  Created by 大威 on 2016/11/16.
//  Copyright © 2016年 devdawei. All rights reserved.
//

#import "ViewController.h"
#import "DVVAlertView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)openAction:(id)sender
{
    /* NO.1 */
    [DVVAlertView showAlertWithTitle:@"标题"
                             message:@"这是提示信息"
                        buttonTitles:@[ @"取消", @"确定" ]
                          completion:^(NSUInteger idx) {
                              
                              NSLog(@"%zi", idx);
                          }];
    
//    /* NO.2 */
//    [DVVAlertView showAlertFrom:self
//                          title:@"标题"
//                        message:@"这是提示信息"
//                   buttonTitles:@[ @"取消", @"确定" ]
//                     completion:^(NSUInteger idx) {
//                         
//                         NSLog(@"%zi", idx);
//                     }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
