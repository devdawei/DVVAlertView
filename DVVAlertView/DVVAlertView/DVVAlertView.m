//
//  DVVAlertView.m
//  DVVAlertView <https://github.com/devdawei/DVVAlertView.git>
//
//  Created by 大威 on 2016/11/16.
//  Copyright © 2016年 devdawei. All rights reserved.
//

#import "DVVAlertView.h"

@interface DVVAlertView () <UIAlertViewDelegate>

@property (nonatomic, copy) DVVAlertViewCompletion completion;

@end

@implementation DVVAlertView

#pragma mark - Init

+ (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
              buttonTitles:(NSArray<NSString *> *)buttonTitles
                completion:(DVVAlertViewCompletion)completion
{
    [self showAlertFrom:nil
                  title:title
                message:message
           buttonTitles:buttonTitles
             completion:completion];
}

+ (void)showAlertFrom:(UIViewController *)controller
                title:(NSString *)title
              message:(NSString *)message
         buttonTitles:(NSArray<NSString *> *)buttonTitles
           completion:(DVVAlertViewCompletion)completion
{
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            __block UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                                             message:message
                                                                                      preferredStyle:UIAlertControllerStyleAlert];
            
            void (^alertActionHandler)(UIAlertAction *) = [^(UIAlertAction *action) {
                // This block intentionally retains alertController, and releases it afterwards.
                NSUInteger index = [alertController.actions indexOfObject:action];
                if (completion)
                {
                    completion(index);
                }
                alertController = nil;
            } copy];
            
            for (NSString *buttonTitle in buttonTitles)
            {
                [alertController addAction:[UIAlertAction actionWithTitle:buttonTitle
                                                                    style:UIAlertActionStyleDefault
                                                                  handler:alertActionHandler]];
            }
            
            UIViewController *controller = nil;
            if (controller)
            {
                controller = controller;
            }
            else
            {
                controller = [DVVAlertView topController];
            }
            [controller presentViewController:alertController animated:YES completion:nil];
        });
    }
    else
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            __block DVVAlertView *dvvAlertView = [self new];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                                message:message
                                                               delegate:nil
                                                      cancelButtonTitle:nil
                                                      otherButtonTitles:nil];
            
            for (NSString *buttonTitle in buttonTitles)
            {
                [alertView addButtonWithTitle:buttonTitle];
            }
            
            dvvAlertView.completion = ^(NSUInteger index) {
                if (completion) {
                    completion(index);
                }
                
                dvvAlertView = nil;
            };
            
            alertView.delegate = dvvAlertView;
            [alertView show];
        });
    }
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (_completion) _completion(buttonIndex);
}

#pragma mark - 获取顶层控制器

+ (UIViewController *)topController
{
    UIViewController *resultVC = nil;
    resultVC = [self judgeController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController)
    {
        resultVC = [self judgeController:resultVC.presentedViewController];
    }
    return resultVC;
}

+ (UIViewController *)judgeController:(UIViewController *)controller
{
    if ([controller isKindOfClass:[UINavigationController class]])
    {
        return [self judgeController:[(UINavigationController *)controller topViewController]];
    }
    else if ([controller isKindOfClass:[UITabBarController class]])
    {
        return [self judgeController:[(UITabBarController *)controller selectedViewController]];
    }
    else
    {
        return controller;
    }
    return nil;
}

@end
