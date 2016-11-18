//
//  DVVAlertView.h
//  DVVAlertView <https://github.com/devdawei/DVVAlertView.git>
//
//  Created by 大威 on 2016/11/16.
//  Copyright © 2016年 devdawei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DVVAlertViewCompletion)(NSUInteger idx);

@interface DVVAlertView : NSObject

/**
 显示AlertView

 @param title 标题
 @param message 提示信息
 @param buttonTitles 按钮显示文字（例如：@[ @"取消", @"打酱油滴", @"确定" ]）
 @param completion 点击回调Block
 */
+ (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
              buttonTitles:(NSArray<NSString *> *)buttonTitles
                completion:(DVVAlertViewCompletion)completion;

/**
 显示AlertView
 
 @param controller 从这个控制器打开
 @param title 标题
 @param message 提示信息
 @param buttonTitles 按钮显示文字（例如：@[ @"取消", @"打酱油滴", @"确定" ]）
 @param completion 点击回调Block
 */
+ (void)showAlertFrom:(UIViewController *)controller
                title:(NSString *)title
              message:(NSString *)message
         buttonTitles:(NSArray<NSString *> *)buttonTitles
           completion:(DVVAlertViewCompletion)completion;

@end
