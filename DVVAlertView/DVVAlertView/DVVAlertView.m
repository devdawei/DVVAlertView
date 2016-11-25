//
//  DVVAlertView.m
//  DVVAlertView <https://github.com/devdawei/DVVAlertView.git>
//
//  Created by 大威 on 2016/11/16.
//  Copyright © 2016年 devdawei. All rights reserved.
//

#import "DVVAlertView.h"

@interface DVVAlertView () <UIAlertViewDelegate>

@property (nonatomic, copy) void (^completion)(NSUInteger idx);

@end

@implementation DVVAlertView

+ (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
              buttonTitles:(NSArray<NSString *> *)buttonTitles
                completion:(void (^)(NSUInteger idx))completion
{
    [DVVAlertView showAlertFrom:nil
                          title:title
                        message:message
                   buttonTitles:buttonTitles
                          style:DVVAlertViewStyleDefault
                     completion:^(NSUInteger idx, NSArray<UITextField *> *textFields, DVVAlertViewType type, id obj) {
                               completion(idx);
                           }];
}

+ (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
              buttonTitles:(NSArray<NSString *> *)buttonTitles
                     style:(DVVAlertViewStyle)style
                completion:(void (^)(NSUInteger idx, NSArray<UITextField *> *textFields, DVVAlertViewType type, id obj))completion
{
    [DVVAlertView showAlertFrom:nil
                          title:title
                        message:message
                   buttonTitles:buttonTitles
                          style:style
                     completion:completion];
}

+ (void)showAlertFrom:(UIViewController *)controller
                title:(NSString *)title
              message:(NSString *)message
         buttonTitles:(NSArray<NSString *> *)buttonTitles
                style:(DVVAlertViewStyle)style
           completion:(void (^)(NSUInteger idx, NSArray<UITextField *> *textFields, DVVAlertViewType type, id obj))completion
{
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            __block UIAlertController *alertController = nil;
            alertController = [UIAlertController alertControllerWithTitle:title
                                                                  message:message
                                                           preferredStyle:UIAlertControllerStyleAlert];
            
            void (^alertActionHandler)(UIAlertAction *) = [^(UIAlertAction *action) {
                // This block intentionally retains alertController, and releases it afterwards.
                NSUInteger index = [alertController.actions indexOfObject:action];
                if (completion)
                {
                    completion(index, alertController.textFields, DVVAlertViewTypeUIAlertController, alertController);
                }
                alertController = nil;
            } copy];
            
            switch (style) {
                case DVVAlertViewStylePlainTextInput:
                    [alertController addTextFieldWithConfigurationHandler:nil];
                    break;
                case DVVAlertViewStyleSecureTextInput:
                    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                        textField.secureTextEntry = YES;
                    }];
                    break;
                case DVVAlertViewStyleLoginAndPasswordInput:
                    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                        textField.placeholder = @"Login";
                    }];
                    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                        textField.secureTextEntry = YES;
                        textField.placeholder = @"Password";
                    }];
                    break;
                    
                default:
                    break;
            }
            
            for (NSString *buttonTitle in buttonTitles)
            {
                [alertController addAction:[UIAlertAction actionWithTitle:buttonTitle
                                                                    style:UIAlertActionStyleDefault
                                                                  handler:alertActionHandler]];
            }
            
            UIViewController *vc = nil;
            if (controller)
            {
                vc = controller;
            }
            else
            {
                vc = [DVVAlertView topController];
            }
            [vc presentViewController:alertController animated:YES completion:nil];
        });
    }
    else
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            __block DVVAlertView *dvvAlert = [self new];
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                                message:message
                                                               delegate:nil
                                                      cancelButtonTitle:nil
                                                      otherButtonTitles:nil];
#pragma clang diagnostic pop
            switch (style) {
                case DVVAlertViewStylePlainTextInput:
                    [alertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
                    break;
                case DVVAlertViewStyleSecureTextInput:
                    [alertView setAlertViewStyle:UIAlertViewStyleSecureTextInput];
                    break;
                case DVVAlertViewStyleLoginAndPasswordInput:
                    [alertView setAlertViewStyle:UIAlertViewStyleLoginAndPasswordInput];
                    break;
                    
                default:
                    [alertView setAlertViewStyle:UIAlertViewStyleDefault];
                    break;
            }
            for (NSString *buttonTitle in buttonTitles)
            {
                [alertView addButtonWithTitle:buttonTitle];
            }
            
            dvvAlert.completion = ^(NSUInteger index) {
                if (completion)
                {
                    NSMutableArray<UITextField *> *array = [NSMutableArray array];
                    if (DVVAlertViewStyleDefault != style)
                    {
                        for (NSUInteger i = 0; i < 2; i++)
                        {
                            if ([alertView textFieldAtIndex:i]) [array addObject:[alertView textFieldAtIndex:i]];
                        }
                    }
                    completion(index, array, DVVAlertViewTypeUIAlertView, alertView);
                }
                
                dvvAlert = nil;
            };
            
            alertView.delegate = dvvAlert;
            [alertView show];
        });
    }
}

#pragma mark - UIAlertViewDelegate

#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (_completion) _completion(buttonIndex);
}
#pragma clang diagnostic pop

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
