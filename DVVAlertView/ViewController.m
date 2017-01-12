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
    
    
//    /* NO.3 */
//    [DVVAlertView showAlertWithTitle:@"标题"
//                             message:@"这是提示信息"
//                        buttonTitles:@[ @"取消", @"确定" ]
//                               style:DVVAlertViewStylePlainTextInput
//                          completion:^(NSUInteger idx, NSArray<UITextField *> *textFields, DVVAlertViewType type, id obj) {
//                              
//                              NSLog(@"idx: %zi", idx);
//                              NSLog(@"type: %zi", type);
//                              NSLog(@"textFields.count: %zi", textFields.count);
//                              if (1 == textFields.count) NSLog(@"textFields[0].text: %@", textFields[0].text);
//                              if (2 == textFields.count) NSLog(@"textFields[1].text: %@", textFields[1].text);
//                              NSLog(@"%@", obj);
//                          }];
    
//    /* NO.4 */
//    [DVVAlertView showAlertWithTitle:@"标题"
//                             message:@"这是提示信息"
//                        buttonTitles:@[ @"取消", @"确定" ]
//                               style:DVVAlertViewStylePlainTextInput
//                          completion:^(NSUInteger idx, NSArray<UITextField *> *textFields, DVVAlertViewType type, id obj) {
//                              
//                              NSLog(@"idx: %zi", idx);
//                              NSLog(@"type: %zi", type);
//                              NSLog(@"textFields.count: %zi", textFields.count);
//                              if (1 == textFields.count) NSLog(@"textFields[0].text: %@", textFields[0].text);
//                              if (2 == textFields.count) NSLog(@"textFields[1].text: %@", textFields[1].text);
//                              NSLog(@"%@", obj);
//                          }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
