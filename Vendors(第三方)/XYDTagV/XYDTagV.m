//
//  XYDTagV.m
//  TestTagV
//
//  Created by xiong有都 on 16/3/9.
//  Copyright © 2016年 xiong有都. All rights reserved.
//

#import "XYDTagV.h"
#import "NSString+Size.h"

@interface XYDTagV () {
    UIButton *tagBtn;
}

@end

@implementation XYDTagV

+ (XYDTagV *)tagVWithTagStr:(NSString *)str {
    return [[XYDTagV alloc]initWithTagStr:str];
}

- (XYDTagV *)initWithTagStr:(NSString *)str {
    _tagStr = str;
    tagBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    tagBtn.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [tagBtn addTarget:self action:@selector(clickTagV:) forControlEvents:UIControlEventTouchUpInside];
    [tagBtn setTitle:_tagStr forState:UIControlStateNormal];
    [self addSubview:tagBtn];
    [tagBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    return self;
}

- (void)clickTagV:(UIButton *)btn {
    if (_clickTagBlock)_clickTagBlock(self.tag - tagDefine);
}

- (void)setTagVProperty:(TagViewProperty *)tagVProperty {
    _tagVProperty = tagVProperty;
    if (tagVProperty.borderColor)self.layer.borderColor = tagVProperty.borderColor.CGColor;
    if (tagVProperty.borderWidth)self.layer.borderWidth = tagVProperty.borderWidth;
    if (tagVProperty.backgroundColor)[tagBtn setBackgroundColor:tagVProperty.backgroundColor];
    if (_tagVProperty.backgroundImage) {
        UIImage *streImage = [_tagVProperty.backgroundImage resizableImageWithCapInsets:UIEdgeInsetsMake(_tagVProperty.backgroundImage.size.height * 0.5-1, _tagVProperty.backgroundImage.size.width * 0.5-1, _tagVProperty.backgroundImage.size.height * 0.5 - 1, _tagVProperty.backgroundImage.size.width * 0.5 - 1) resizingMode:UIImageResizingModeStretch];
        [tagBtn setBackgroundImage:streImage  forState:UIControlStateNormal];
    }
    if (_tagVProperty.highlightedBackgroundImage) {
        UIImage *strechImage = [_tagVProperty.highlightedBackgroundImage resizableImageWithCapInsets:UIEdgeInsetsMake(_tagVProperty.highlightedBackgroundImage.size.height * 0.5-1, _tagVProperty.highlightedBackgroundImage.size.width * 0.5-1, _tagVProperty.highlightedBackgroundImage.size.height * 0.5 - 1, _tagVProperty.highlightedBackgroundImage.size.width * 0.5 - 1) resizingMode:UIImageResizingModeStretch];
        [tagBtn setBackgroundImage:strechImage  forState:UIControlStateHighlighted];
    }
    if (tagVProperty.borderCornerRadius)self.layer.cornerRadius = tagVProperty.borderCornerRadius;
    if (!UIEdgeInsetsEqualToEdgeInsets(UIEdgeInsetsZero, tagVProperty.edgeInsets)) {
        tagBtn.contentEdgeInsets = tagVProperty.edgeInsets;
    }
    if (tagVProperty.textColor) [tagBtn setTitleColor:tagVProperty.textColor forState:UIControlStateNormal];
    if (tagVProperty.font) tagBtn.titleLabel.font = tagVProperty.font;
}

- (CGFloat)tagVWidth {
    if (_tagVProperty.tagVWidth) {
        return _tagVProperty.tagVWidth;
    }else {
        return ([_tagStr widthWithFont:_tagVProperty.font constrainedToHeight:_tagVProperty.tagVHeight] + _tagVProperty.edgeInsets.left + _tagVProperty.edgeInsets.right);
    }
}

- (CGFloat)tagVHeight {
    return _tagVProperty.tagVHeight + _tagVProperty.edgeInsets.top + _tagVProperty.edgeInsets.bottom;
}

//- (void)drawRect:(CGRect)rect {
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetLineWidth(context, 1.0);
//    CGContextSetRGBFillColor (context, 0.5, 0.5, 0.5, 0.5);
//    UIFont  *font = [UIFont boldSystemFontOfSize:18.0];
//    [_tagStr drawInRect:rect withAttributes:@{NSFontAttributeName:font}];
//}

@end
