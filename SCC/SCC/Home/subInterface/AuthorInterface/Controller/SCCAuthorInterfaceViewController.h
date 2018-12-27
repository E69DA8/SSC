//
//  SCCAuthorInterfaceViewController.h
//  SCC
//
//  Created by E69DA8 on 2018/11/7.
//  Copyright © 2018年 E69DA8. All rights reserved.
//

#import "SCCBaseViewController.h"

@interface SCCAuthorInterfaceViewController : SCCBaseViewController
@property(nonatomic,copy) NSString *autherId;//作者id
@property(nonatomic,assign) BOOL isThumbsUp;//是否点赞

@end
