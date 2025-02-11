//
//  JYHLSVProgressHUD.h
//  JYHLLiveRoom
//
//  Created by Peter on 2018/7/2.
//  Copyright © 2018年 9yu. All rights reserved.
//

#import <SVProgressHUD/SVProgressHUD.h>
#import <AvailabilityMacros.h>

@interface JYHLSVProgressHUD : SVProgressHUD

#pragma mark - Customization

+ (void)setBackgroundColor:(UIColor*)color;                 // default is [UIColor whiteColor]
+ (void)setForegroundColor:(UIColor*)color;                 // default is [UIColor blackColor]
+ (void)setRingThickness:(CGFloat)width;                    // default is 4 pt
+ (void)setFont:(UIFont*)font;                              // default is [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline]
+ (void)setInfoImage:(UIImage*)image;                       // default is the bundled info image provided by Freepik
+ (void)setSuccessImage:(UIImage*)image;                    // default is the bundled success image provided by Freepik
+ (void)setErrorImage:(UIImage*)image;                      // default is the bundled error image provided by Freepik
+ (void)setDefaultMaskType:(SVProgressHUDMaskType)maskType; // default is SVProgressHUDMaskTypeNone
+ (void)setViewForExtension:(UIView*)view;                  // default is nil, only used if #define SV_APP_EXTENSIONS is set

#pragma mark - Show Methods

+ (void)showWithMsg:(NSString *)msg;

+ (void)show;
+ (void)showWithMaskType:(SVProgressHUDMaskType)maskType;
+ (void)showWithStatus:(NSString*)status;
+ (void)showWithStatus:(NSString*)status maskType:(SVProgressHUDMaskType)maskType;

+ (void)showProgress:(float)progress;
+ (void)showProgress:(float)progress maskType:(SVProgressHUDMaskType)maskType;
+ (void)showProgress:(float)progress status:(NSString*)status;
+ (void)showProgress:(float)progress status:(NSString*)status maskType:(SVProgressHUDMaskType)maskType;

+ (void)setStatus:(NSString*)string; // change the HUD loading status while it's showing

// stops the activity indicator, shows a glyph + status, and dismisses HUD a little bit later
+ (void)showInfoWithStatus:(NSString *)string;
+ (void)showInfoWithStatus:(NSString *)string maskType:(SVProgressHUDMaskType)maskType;

+ (void)showSuccessWithStatus:(NSString*)string;
+ (void)showSuccessWithStatus:(NSString*)string maskType:(SVProgressHUDMaskType)maskType;

+ (void)showErrorWithStatus:(NSString *)string;
+ (void)showErrorWithStatus:(NSString *)string maskType:(SVProgressHUDMaskType)maskType;

// use 28x28 white pngs
+ (void)showImage:(UIImage*)image status:(NSString*)status;
+ (void)showImage:(UIImage*)image status:(NSString*)status maskType:(SVProgressHUDMaskType)maskType;

+ (void)setOffsetFromCenter:(UIOffset)offset;
+ (void)resetOffsetFromCenter;

+ (void)popActivity; // decrease activity count, if activity count == 0 the HUD is dismissed
+ (void)dismiss;

+ (BOOL)isVisible;


@end
