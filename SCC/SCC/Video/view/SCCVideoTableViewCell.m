//
//  SCCVideoTableViewCell.m
//  SCC
//
//  Created by E69DA8 on 2019/1/4.
//  Copyright © 2019年 E69DA8. All rights reserved.
//

#import "SCCVideoTableViewCell.h"
#import "SCCVideoModel.h"

@interface SCCVideoTableViewCell()

@property(weak,nonatomic)UIView *bgView;
@property(weak,nonatomic)UIImageView *pictureImageView;
@property(weak,nonatomic)UILabel *titleLabel;

@end

@implementation SCCVideoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

#pragma mark - UI
- (void)setupUI {
    self.contentView.backgroundColor = SCCBgColor;
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.equalTo(self.contentView.mas_left).offset(SCCWidth(20));
        make.right.equalTo(self.contentView.mas_right).offset(-SCCWidth(20));
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-SCCWidth(20));
    }];
    
    [self.pictureImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.bgView);
        make.height.offset(SCCWidth(189));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView.mas_left).offset(SCCWidth(20));
        make.bottom.equalTo(self.bgView.mas_bottom).offset(SCCWidth(-15));
    }];
    
    
//    self.pictureImageView.image = [UIImage imageNamed:@"btn_article_detail_sel_like"];
//    self.titleLabel.text = @"开什么玩笑";

}

-(void)setModel:(SCCVideoModel *)model{
    _model = model;
    [self.pictureImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",self.iconPath,model.cover_url]] placeholderImage:[UIImage imageNamed:@"user_2"]];
    self.titleLabel.text = model.title;

}


#pragma mark - 懒加载
- (UIView *)bgView{
    if(!_bgView){
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor whiteColor];
        //        view.layer.shadowColor = [UIColor blackColor].CGColor;//阴影的颜色
        //        view.layer.shadowOpacity = 0.2f;//阴影的透明度
        //        view.layer.shadowRadius = 4.f;//阴影的圆角
        //        view.layer.shadowOffset = CGSizeMake(4,4);//阴影偏移量
        //        view.layer.cornerRadius = 12; //圆角
        //        view.frame = CGRectMake(20,97,335,279.5);
        view.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1].CGColor;
        view.layer.cornerRadius = 12;
        view.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.04].CGColor;
        view.layer.shadowOffset = CGSizeMake(0,8);
        view.layer.shadowOpacity = 1;
        view.layer.shadowRadius = 12;
        view.layer.masksToBounds = YES;
        [self.contentView addSubview:view];
        _bgView = view;
    }
    return _bgView;
}

- (UIImageView *)pictureImageView{
    if(!_pictureImageView){
        UIImageView *imageV = [[UIImageView alloc]init];
        [self.bgView addSubview:imageV];
        _pictureImageView = imageV;
    }
    return _pictureImageView;
}

- (UILabel *)titleLabel{
    if(!_titleLabel){
        UILabel *lab = [UILabel r_labelWithText:nil fontSize:16 color:SCCColor(0x333333)];
        [self.bgView addSubview:lab];
        _titleLabel = lab;
        
    }
    return _titleLabel;
}

@end

