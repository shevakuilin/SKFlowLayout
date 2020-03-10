//
//  ConferenceCell.m
//  FlowLayout
//
//  Created by ShevaKuilin on 2020/3/10.
//  Copyright © 2020 ShevaKuilin. All rights reserved.
//

#import "ConferenceCell.h"

@implementation ConferenceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = Color16Hex(0x5CDBD3);
    }
    return self;
}

@end
