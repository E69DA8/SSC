//
//  SCCVideoPlayViewController.m
//  SCC
//
//  Created by E69DA8 on 2019/1/4.
//  Copyright © 2019年 E69DA8. All rights reserved.
//

#import "SCCVideoPlayViewController.h"
#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

@interface SCCVideoPlayViewController ()
/*
 * 中奖广告视频
 */
@property (nonatomic, weak) AVPlayerLayer *videoPlayer;

@property(weak,nonatomic)UIView *glView;

@property(weak,nonatomic)UILabel *hintLabel;

@property(weak,nonatomic)UIButton *closeButton;

@end

@implementation SCCVideoPlayViewController

-(void)setupUI{
    
    self.view.backgroundColor = [UIColor blackColor];
    
    CGFloat height = ScreenWidth /16.0 * 9.0;
    
    [self.glView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth, height));
    }];
    
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(SCCWidth(44));
        make.right.equalTo(self.view).offset(SCCWidth(-20));
        make.size.mas_equalTo(CGSizeMake(SCCWidth(32), SCCWidth(32)));
    }];
    
    [self.hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
    
}

-(void)setVideoUrl:(NSString *)videoUrl{
    _videoUrl = videoUrl;
    
    if (videoUrl == nil) {
        return;
    }
    
    AVAsset *asset = [AVAsset assetWithURL:[[NSURL alloc] initWithString:videoUrl]];
    //    创建播放项目   读取播放状态&查看当前播放时间&管理播放队列
    AVPlayerItem *item = [AVPlayerItem playerItemWithAsset:asset];
    
    //创建媒体资源对象  代表播放的文件(文件大小&文件播放码率)http://flv2.bn.netease.com/videolib3/1604/28/fVobI0704/SD/fVobI0704-mobile.mp4,@"http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"
    
    AVPlayer *avp = [[AVPlayer alloc] initWithPlayerItem:item];
    //视图也需要自己添加
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:avp];
    //添加到视图的主layer中
    [self.glView.layer addSublayer:playerLayer];
    
    //设置尺寸
    CGFloat height = ScreenWidth /16.0 * 9.0;
    playerLayer.frame = CGRectMake(0,0, ScreenWidth, height);
    //        playerLayer.frame = self.glView.bounds;
    //    (ScreenHeight - height)/2
    //    playerLayer.center = self.view.center;
    
    avp.volume = 1.0f;
    self.videoPlayer = playerLayer;
    //        self.videoPlayer.frame = self.glView.bounds;
    //    _curVideoUrl = model.videoUrl;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"AVPlayerItemDidPlayToEndTimeNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:) name:@"AVPlayerItemDidPlayToEndTimeNotification" object:nil];
    
    [self.videoPlayer.player play];
}

-(void)playbackFinished:(NSNotification *)notification{
    NSLog(@"视频播放完成.");
    // 播放完成后重复播放
    // 跳到最新的时间点开始播放
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)closeButtonClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIView *)glView{
    if(!_glView){
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:view];
        _glView = view;
    }
    return _glView;
}

- (UILabel *)hintLabel{
    if(!_hintLabel){
        UILabel *lab = [UILabel r_labelWithText:@"视频加载中。。。" fontSize:14 color:SCCColor(0x555555)];
        
        [self.glView addSubview:lab];
        
        _hintLabel = lab;
        
    }
    return _hintLabel;
}

- (UIButton *)closeButton{
    if(!_closeButton){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"btn_close_page"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(closeButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        _closeButton = btn;
    }
    return _closeButton;
}

@end
