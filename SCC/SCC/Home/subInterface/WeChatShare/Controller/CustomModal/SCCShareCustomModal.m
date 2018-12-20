//
//  SCCShareCustomModal.m
//  JYHLLiveRoom
//
//  Created by 任永乐 on 17/1/20.
//  Copyright © 2017年 9yu. All rights reserved.
//

#import "SCCShareCustomModal.h"
#import "SCCSharePresentC.h"

@implementation SCCShareCustomModal

- (nullable UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source{
    SCCSharePresentC *present = [[SCCSharePresentC alloc]initWithPresentedViewController:presented presentingViewController:presenting];
    
    
    
    return present;
    
}

@end
