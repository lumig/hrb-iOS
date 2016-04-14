//
//  RecipentAddressTableViewCell.m
//  GuoHongHui
//
//  Created by mac on 15/7/2.
//  Copyright (c) 2015年 LuMig. All rights reserved.
//

#import "RecipentAddressTableViewCell.h"

@implementation RecipentAddressTableViewCell

- (void)awakeFromNib {

    [self.leftImgView setImage:[UIImage imageNamed:@"i_currentnode.png"]];

}

- (void)cellFillWithAddressModel:(AddressModel *)model
{
//    if(model == nil)
//    {
//        self.consigneeNameLabel.hidden = YES;
//        
//        UILabel *newAddress = [[UILabel alloc] initWithFrame:CGRectMake(30, 35/2.0, SCREEN_WIDTH - 70, 25)];
//        
//        [newAddress setText:@"添加收货人地址"];
//        [newAddress setFont:[UIFont systemFontOfSize:17]];
//        
//        newAddress.textAlignment = NSTextAlignmentCenter;
//        [self addSubview:newAddress];
//    }
//    else
//    {
    
        [self.consigneeLabel setText:model.consignee];
        [self.phoneLabel setText:model.cellPhone];
    
    
//        [self.addressLabel setText:[NSString stringWithFormat:@"%@%@%@%@",model.province,model.city,model.county,model.street]];
    
    [self.addressLabel setText:model.address];
//        }
    
}

+(CGFloat)cellHeight
{
    return 60;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
