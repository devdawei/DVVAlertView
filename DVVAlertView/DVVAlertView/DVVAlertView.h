//
//  DVVAlertView.h
//  DVVAlertView <https://github.com/devdawei/DVVAlertView.git>
//
//  Created by 大威 on 2016/11/16.
//  Copyright © 2016年 devdawei. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 Alert样式
 
 - DVVAlertViewStyleDefault: 默认没有输入框
 - DVVAlertViewStyleSecureTextInput: 一个密码
 - DVVAlertViewStylePlainTextInput: 一个正常的输入框
 - DVVAlertViewStyleLoginAndPasswordInput: 一个账号输入框和一个密码输入框
 */
typedef NS_ENUM(NSInteger, DVVAlertViewStyle) {
    DVVAlertViewStyleDefault = 0,
    DVVAlertViewStyleSecureTextInput,
    DVVAlertViewStylePlainTextInput,
    DVVAlertViewStyleLoginAndPasswordInput
};

/**
 Alert类型

 - DVVAlertViewTypeUIAlertView: UIAlertView
 - DVVAlertViewTypeUIAlertController: UIAlertController
 */
typedef NS_ENUM(NSUInteger, DVVAlertViewType) {
    DVVAlertViewTypeUIAlertView,
    DVVAlertViewTypeUIAlertController
};

@interface DVVAlertView : NSObject

// NOTE: 取消按钮的加粗效果不好看，所以就没有用取消按钮

/**
 显示Alert
 
 @param title 标题
 @param message 提示信息
 @param buttonTitles 按钮显示文字（例如：@[ @"取消", @"确定" ] 或者 @[ @"打酱油滴", @"确定", @[取消] ] ）
 @param completion 点击回调Block
 */
+ (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
              buttonTitles:(NSArray<NSString *> *)buttonTitles
                completion:(void (^)(NSUInteger idx))completion;

/**
 显示带输入框的Alert
 
 @param title 标题
 @param message 提示信息
 @param buttonTitles 按钮显示文字（例如：@[ @"取消", @"确定" ]）
 @param style 样式
 @param completion 点击回调Block
 */
+ (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
              buttonTitles:(NSArray<NSString *> *)buttonTitles
                     style:(DVVAlertViewStyle)style
                completion:(void (^)(NSUInteger idx, NSArray<UITextField *> *textFields, DVVAlertViewType type, id obj))completion;

@end
