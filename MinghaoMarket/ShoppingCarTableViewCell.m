//
//  ShoppingCarTableViewCell.m
//  MinghaoMarket
//
//  Created by TOMSZ on 15/5/28.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import "ShoppingCarTableViewCell.h"
#import "ShoppingCarTableViewController.h"
@interface ShoppingCarTableViewCell()

@end
@implementation ShoppingCarTableViewCell
@synthesize sctvc;
- (void)awakeFromNib {
    // Initialization code
    //_textDisplay.text=@"88";
    _textDisplay.text=[NSString stringWithFormat:@"%d",_i];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

#pragma mark - 减一个商品数量
- (IBAction)deleteBtnClick:(id)sender {
    //  数量至少为1
    if (_i<=1) {
        _i=1;
    }else {
        _i--;
    }
    //
    _textDisplay.text=[NSString stringWithFormat:@"%d",_i];
    //  商品数量
    double instring=[_textDisplay.text intValue];
    //  单个商品的折扣价
    double intstring2=[_shoppingDiscountThanPrice.text floatValue];
    //  单个商品的合计价格 = 折扣价 * 商品数量
    NSString *stringint=[NSString stringWithFormat:@"%.1f",instring * intstring2];
    
    _shoppingAllPrice.text = stringint;
    
    
    
    NSLog(@"单个商品的合价 = %@",stringint);
    
    //
    id object = [self nextResponder];
    while (![object isKindOfClass:[UIViewController class]] &&
           object != nil) {
        object = [object nextResponder];
    }
    
    
    
    // 计算总金额
    ShoppingCarTableViewController *vc1=(ShoppingCarTableViewController*)object;
    vc1.tempNum = 0;
    for (int i=0; i<vc1.cellArray.count;i++)
    {
        
        ShoppingCarTableViewCell * cell = vc1.cellArray[i];
        
        vc1.tempNum += [cell.shoppingAllPrice.text floatValue];//值;
        
    }
    
    
    
    NSString *string=[NSString stringWithFormat:@"%.1f",vc1.tempNum];
    vc1.theAllMoney.text=string;
    
    

}



#pragma mark - 增加价格
- (IBAction)addBtnClick:(id)sender {
    _i++;
    _textDisplay.text=[NSString stringWithFormat:@"%d",_i];
    
    double instring=[_textDisplay.text intValue];
    double intstring2=[_shoppingDiscountThanPrice.text floatValue];
    NSString *stringint=[NSString stringWithFormat:@"%.1f",instring*intstring2];
    _shoppingAllPrice.text=stringint;
    
    
    
    id object = [self nextResponder];
    while (![object isKindOfClass:[UIViewController class]] &&
           object != nil) {
        object = [object nextResponder];
    }
    
    
    //加减计算总金额
    ShoppingCarTableViewController *vc1=(ShoppingCarTableViewController*)object;
    vc1.tempNum = 0;
    for (int i=0; i<vc1.cellArray.count; i++)
    {
        ShoppingCarTableViewCell * cell = vc1.cellArray[i];
        
        vc1.tempNum += [cell.shoppingAllPrice.text floatValue];//值;
        
    }
    //    NSLog(@"%@",cellArray);
    
    
    NSString *string=[NSString stringWithFormat:@"%.1f",vc1.tempNum];
    vc1.theAllMoney.text=string;
}



-(void)setContentWithString:(int)it{
    _i=it;
    _textDisplay.text=[NSString stringWithFormat:@"%d",it];
    //[sctvc.tableView  reloadData];
    
}

#pragma mark - 删除不想要的订单
- (IBAction)deleteGoodsBtnClick:(MyButton *)sender {
    id object = [self nextResponder];
    while (![object isKindOfClass:[UIViewController class]] &&
           object != nil) {
        object = [object nextResponder];
    }
        ShoppingCarTableViewController *vc1=(ShoppingCarTableViewController*)object;
    
    NSArray *visibleCells=[vc1.tableView visibleCells];
    for (UITableViewCell *cell in visibleCells) {
        if (cell.tag==sender.tag) {
            [vc1.cellArray removeObjectAtIndex:[cell tag]];
            [vc1.tableView reloadData];
            break;
        }
    }
    
    NSLog(@"vc1.cellarray1=%@",vc1.cellArray);
    
}




@end
