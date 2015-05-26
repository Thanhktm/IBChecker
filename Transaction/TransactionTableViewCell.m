//
//  TransactionTableViewCell.m
//  IB Checker
//
//  Created by Thanh on 5/16/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import "TransactionTableViewCell.h"
#import "Transaction.h"
#import "Benefit.h"
#import "Constant.h"

#define HEIGHT_VIEW 32
#define HEIGHT_VIEW_BENEFIT 53
#define HEIGHT_HEADER_VIEW_BENEFIT 15
@implementation TransactionTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (UIView *)viewBenefits:(NSArray *)benefits bellowView:(UIView *)viewBefore{
    int y = 0;
    int height= 0;
    if (viewBefore) {
        y = viewBefore.frame.size.height + viewBefore.frame.origin.y;
    }
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, y, 320, 0)];
    CGRect frame = view.frame;
    
    UIImageView *imageHeader = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, HEIGHT_HEADER_VIEW_BENEFIT)];
    imageHeader.image = [UIImage imageNamed:@"bg_span"];
    height += imageHeader.frame.size.height;
    
    UILabel *lbTitle = [[UILabel alloc] initWithFrame:CGRectMake(18, -3, 200, 21)];
    
    lbTitle.font = [UIFont boldSystemFontOfSize:11];
    lbTitle.text = NSLocalizedString(@"Benefits", @"");
    lbTitle.textColor = rgb(100, 100, 100);
    
    [view addSubview:imageHeader];
    [view addSubview:lbTitle];
    int index = 0;
    for (Benefit *b in benefits) {
        UIView *viewBenefit = [[UIView alloc] initWithFrame:CGRectMake(0, height, 320, HEIGHT_VIEW_BENEFIT)];
        if (index < [benefits count] - 1) {
            UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(0, HEIGHT_VIEW_BENEFIT - 1, 320, 1)];
            separator.backgroundColor = rgb(221, 0, 0);
            [viewBenefit addSubview:separator];
        }

        
        UILabel *lbName = [[UILabel alloc] initWithFrame:CGRectMake(18, 8, 180, 14)];
        lbName.font = [UIFont systemFontOfSize:11];
        lbName.textColor = [UIColor blackColor];
        lbName.text = [b.name uppercaseString];
        [viewBenefit addSubview:lbName];

        UILabel *lbAccountNo = [[UILabel alloc] initWithFrame:CGRectMake(18, 25, 180, 14)];
        lbAccountNo.font = [UIFont systemFontOfSize:10];
        lbAccountNo.textColor = rgb(122, 122, 122);
        lbAccountNo.text = b.accountNo;
        [viewBenefit addSubview:lbAccountNo];
        
        
        UILabel *lbAmount = [[UILabel alloc] initWithFrame:CGRectMake(200, 8, 77, 14)];
        lbAmount.font = [UIFont boldSystemFontOfSize:11];
        lbAmount.textColor = rgb(221, 0, 0);
        lbAmount.text = [Transaction formatNumber:b.amount];
        lbAmount.textAlignment = NSTextAlignmentRight;
        
        
        
        UILabel *lbCurrency = [[UILabel alloc] initWithFrame:CGRectMake(278, 8, 40, 14)];
        lbCurrency.font = [UIFont boldSystemFontOfSize:11];
        lbCurrency.textColor = rgb(122, 122, 122);
        lbCurrency.text = b.currencyCode;
        
        [viewBenefit addSubview:lbCurrency];
        [viewBenefit addSubview:lbAmount];
        [viewBenefit addSubview:lbCurrency];
        
        [view addSubview:viewBenefit];
        index++;
        height += HEIGHT_VIEW_BENEFIT;
    }
    frame.size.height = height;
    view.frame = frame;
    return view;

}

- (UIView *)viewWithTitle:(NSString *)title description:(NSString *)description info:(NSString *)info afterView:(UIView *)viewBefore isSeparator:(BOOL)isSeparator{
    int y = 0;
    if (viewBefore) {
        y = viewBefore.frame.size.height + viewBefore.frame.origin.y;
    }
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, y, 320, HEIGHT_VIEW)];
    CGRect frame = view.frame;
    [view setBackgroundColor:rgb(229, 299, 299)];
    UILabel *lbTitle = [[UILabel alloc] initWithFrame:CGRectMake(18, 8, 130, 18)];
    lbTitle.textColor = rgb(122, 122, 122);
    lbTitle.font = [UIFont systemFontOfSize:13.0];
    lbTitle.text = title;
    [view addSubview:lbTitle];
    
    UILabel *lbDesc = [[UILabel alloc] initWithFrame:CGRectMake(150, 8, 150, 18)];
    lbDesc.textColor = [UIColor blackColor];
    lbDesc.font = [UIFont systemFontOfSize:14.0];
    lbDesc.text = description;
    [view addSubview:lbDesc];

    if (info) {
        CGSize boundingSize = CGSizeMake(135.0, 500.0);
        CGSize requiredSize = [info sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:boundingSize lineBreakMode:NSLineBreakByWordWrapping];
        
        UILabel *lbInfo = [[UILabel alloc] initWithFrame:CGRectMake(150, 25, requiredSize.width, requiredSize.height)];
        lbInfo.lineBreakMode = NSLineBreakByWordWrapping;
        lbInfo.numberOfLines = 0;
        lbInfo.textColor = rgb(122, 122, 122);
        lbInfo.font = [UIFont systemFontOfSize:13.0];
        lbInfo.text = info;
        [lbInfo sizeToFit];
        [view addSubview:lbInfo];
        frame.size.height += (5 + lbInfo.frame.size.height);
    }
    if (isSeparator) {
        UIImageView *imageViewSeparator = [[UIImageView alloc] initWithFrame:CGRectMake(18, frame.size.height - 1, 282, 1)];
        imageViewSeparator.image = [UIImage imageNamed:@"separate"];
            [view addSubview:imageViewSeparator];
    }
    view.frame = frame;
    return view;
}

- (void) layoutSubviews {
    [super layoutSubviews];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    CGRect frame = _viewInfo.frame;
    CGRect frameDetail = _viewDetail.frame;
    if (_transaction.isShowTitle) {
        frame.origin.y = 15.0f;
        frameDetail.origin.y = 60;
        [_viewTitle setHidden:NO];
    } else {
        frame.origin.y = 0.0f;
        frameDetail.origin.y = 45.0f;
        [_viewTitle setHidden:YES];
    }
    
    if (_transaction.expand) {
        [_viewDetail setHidden:NO];
        int height = 0;
        UIView *viewCreateTime = [self viewWithTitle:NSLocalizedString(@"Created date", @"")
                                         description:_transaction.createTime
                                                info:nil afterView:nil
                                         isSeparator:YES];
        
        [_viewDetail addSubview:viewCreateTime];
        height += viewCreateTime.frame.size.height;
        
        UIView *viewCreateBy = [self viewWithTitle:NSLocalizedString(@"Created by", @"")
                                       description:_transaction.createBy info:nil
                                         afterView:viewCreateTime
                                       isSeparator:(_transaction.type != TransactionTypeBatch)];
        
        [_viewDetail addSubview:viewCreateBy];
        height += viewCreateBy.frame.size.height;
        
        if(_transaction.type == TransactionTypeBatch && [_transaction.benefits count] > 0) {
            UIView *viewBenifits = [self viewBenefits:_transaction.benefits bellowView:viewCreateBy];
            [_viewDetail addSubview:viewBenifits];
            height += viewBenifits.frame.size.height;
        }
        
        // Row for target account of type 0 and 1
        if((_transaction.type == TransactionTypeInternalTransfer
            || _transaction.type == TransactionTypeInterBankTransfer)
           && [_transaction.benefits count] > 0) {
            Benefit *b = (Benefit *) [_transaction.benefits objectAtIndex:0];
            UIView *viewCreateInfo = [self viewWithTitle:NSLocalizedString(@"Target account", @"")
                                           description:b.accountNo info:b.bank
                                             afterView:viewCreateBy
                                           isSeparator:NO];
            [_viewDetail addSubview:viewCreateInfo];
            height += viewCreateInfo.frame.size.height;
        }
        if (_transaction.type == TransactionTypeSaving) {
            UIView *viewInterset = [self viewWithTitle:NSLocalizedString(@"Saving acocunt", @"")
                                           description:(_transaction.interestAccount ? _transaction.interestAccount : NSLocalizedString(@"Accumulated principal", @""))
                                              info:nil afterView:viewCreateBy
                                       isSeparator:NO];
            [_viewDetail addSubview:viewInterset];
            height += viewInterset.frame.size.height;
        }
        
        
        if (_transaction.type == TransactionTypeSettlement) {
            UIView *viewTerm = [self viewWithTitle:NSLocalizedString(@"Term", @"")
                                             description:_transaction.term
                                                    info:nil afterView:viewCreateBy
                                             isSeparator:YES];
            
            [_viewDetail addSubview:viewTerm];
            height += viewTerm.frame.size.height;
            
            UIView *viewInterestRate = [self viewWithTitle:NSLocalizedString(@"Interest rate", @"")
                                       description:[Transaction formatPercent:_transaction.interestRate]
                                              info:nil afterView:viewTerm
                                       isSeparator:YES];
            
            [_viewDetail addSubview:viewInterestRate];
            height += viewInterestRate.frame.size.height;
            
            UIView *viewInterestAmount = [self viewWithTitle:NSLocalizedString(@"Interest amount", @"")
                                       description:[NSString stringWithFormat:@"%@ %@",[Transaction formatNumber:_transaction.interestAmount],_transaction.currencyCode]
                                              info:nil afterView:viewInterestRate
                                       isSeparator:NO];
            
            [_viewDetail addSubview:viewInterestAmount];
            height += viewInterestAmount.frame.size.height;
        }
        frameDetail.size.height = height;
    } else {
        [_viewDetail setHidden:YES];
        for (UIView *v in _viewDetail.subviews) {
            [v removeFromSuperview];
        }
        frameDetail.size.height = 0;
        
    }
    
    _viewDetail.frame = frameDetail;
    _viewInfo.frame = frame;
}


- (void)cellWithData:(Transaction *) transaction {
    _transaction = transaction;

    _lbInfo2.text = transaction.info2;
    switch (transaction.type) {
        case TransactionTypeInternalTransfer:
            _lbInfo1.text = NSLocalizedString(@"Internal tranfer", @"");
            _lbTitle.text = NSLocalizedString(@"Transfers", @"");
            break;
        case TransactionTypeInterBankTransfer:
            _lbInfo1.text = NSLocalizedString(@"Inter-bank tranfer", @"");
            _lbTitle.text = NSLocalizedString(@"Transfers", @"");
            break;
        case TransactionTypeBatch:
            _lbInfo1.text = transaction.info1;
            _lbInfo2.text = [NSString stringWithFormat:@"%@ %@", transaction.info2, NSLocalizedString(@"Items", @"")];
            _lbTitle.text = NSLocalizedString(@"Batchs", @"");
            break;
        case TransactionTypeSaving:
            _lbInfo1.text = NSLocalizedString(@"Open saving account", @"");
            _lbTitle.text = NSLocalizedString(@"Others", @"");
            break;
        case TransactionTypeSettlement:
            _lbInfo1.text = NSLocalizedString(@"Settlement", @"");
            _lbTitle.text = NSLocalizedString(@"Others", @"");
            break;
            
        default:
            break;
    }

    _btnCheck.selected = transaction.checked;
    _btnExpand.selected = transaction.expand;
    _lbAmount.text = [Transaction formatNumber:transaction.amount];
    _lbCurrency.text = transaction.currencyCode;
    
    [self setNeedsDisplay];
}

- (IBAction)btnCheckChangeValue:(UIButton *)button {
    button.selected = !button.selected;
    _transaction.checked = button.selected;
    if (_delegate) {
        [_delegate didChangeCheckingValue];
    }
}

- (IBAction)btnExpandChangeValue:(UIButton *)button {

    if (_transaction.isDetail) { //Check exist data
        button.selected = !button.selected;
        _transaction.expand = button.selected;
        if (_delegate) {
            [_delegate didChangeExpand];
        }
    } else {
        // Request details data
        if (_delegate) {
            [_delegate requestDetail:self transaction:_transaction];
        }
    }
    
}


+ (CGFloat)heightForCellWithData:(Transaction *)transaction
{
    float height = 45.0f;
    if (transaction.expand) {
        // Full height
        height += HEIGHT_VIEW + HEIGHT_VIEW;
        if (transaction.type == TransactionTypeBatch && [transaction.benefits count] > 0) {
            height += HEIGHT_HEADER_VIEW_BENEFIT;
            height += ([transaction.benefits count] * HEIGHT_VIEW_BENEFIT);
        }
        if ((transaction.type == TransactionTypeInterBankTransfer
             || transaction.type == TransactionTypeInternalTransfer) && [transaction.benefits count] > 0) {
            Benefit *b = (Benefit *) [transaction.benefits objectAtIndex:0];
            CGSize boundingSize = CGSizeMake(135.0, 500.0);
            CGSize requiredSize = [b.bank sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:boundingSize lineBreakMode:NSLineBreakByWordWrapping];
            height += (requiredSize.height + 5 + HEIGHT_VIEW);
            
        }
        
        if (transaction.type == TransactionTypeSaving) {
            height += HEIGHT_VIEW;
        }
        
        if (transaction.type == TransactionTypeSettlement) {
            height += HEIGHT_VIEW + HEIGHT_VIEW + HEIGHT_VIEW;
        }
    }
    
    // Normal height
    return height;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
