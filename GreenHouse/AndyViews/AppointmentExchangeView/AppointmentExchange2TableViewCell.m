//
//  AppointmentExchange2TableViewCell.m
//  AndyCoder
//
//  Created by lingnet on 16/4/27.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "AppointmentExchange2TableViewCell.h"

#import "AppointmentExchange2Model.h"
@interface AppointmentExchange2TableViewCell()<UITextViewDelegate>
@property(nonatomic,retain)UITextView* beizhuTV;

@end
@implementation AppointmentExchange2TableViewCell

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style
                      reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    return self;
}
- (void)makeUI{
    self.beizhuTV = [[UITextView alloc] init];
    [self.contentView addSubview:self.beizhuTV];
    self.beizhuTV.font = [UIFont systemFontOfSize:14]; //注意先设置字体,再设置placeholder
//    self.beizhuTV.placeholder = @"请在此输入您的备注信息";
    self.beizhuTV.layer.borderColor = [[UIColor grayColor] CGColor];
    self.beizhuTV.delegate = self;
    self.beizhuTV.layer.borderWidth = 0.5;
    self.beizhuTV.alpha = 0.4;
    
    [self.beizhuTV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.right.mas_equalTo(-5);
        make.height.mas_offset(60);
        make.top.mas_equalTo(5);
    }];
    
    self.hyb_lastViewInCell = self.beizhuTV;
    self.hyb_bottomOffsetToCell = 10;
}
- (void)configCellWithModel:(AppointmentExchange2Model *)model{
    if (model.isNoEditable) {
        self.beizhuTV.editable = NO;
        self.beizhuTV.placeholder = @"";
    }else{
        self.beizhuTV.editable = YES;
        self.beizhuTV.placeholder = @"";//@"请在此输入您的备注信息";
    }
    self.beizhuTV.text = model.beizhuStr;
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    [self.AppointmentExchange2TableViewCellDelegate sendBackBeizhu:textView.text];
}
@end
