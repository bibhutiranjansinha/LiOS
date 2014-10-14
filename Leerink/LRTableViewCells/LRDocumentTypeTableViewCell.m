//
//  LRDocumentTypeTableViewCell.m
//  Leerink
//
//  Created by Ashish on 13/08/2014.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "LRDocumentTypeTableViewCell.h"
@interface LRDocumentTypeTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *documentTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorTitleLabel;
@end
@implementation LRDocumentTypeTableViewCell

- (void)fillDataForDocumentCellwithTitle:(NSString *)title andDateTime:(NSString *)date andAuthor:(NSString *)author
{
    self.documentTitleLabel.text = title;
    self.dateLabel.text = date;
    self.authorTitleLabel.text = author;    
    
    self.documentTitleLabel.numberOfLines = 0;
    self.documentTitleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.documentTitleLabel.preferredMaxLayoutWidth = 260;
}

@end