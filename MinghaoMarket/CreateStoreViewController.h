//
//  CreateStoreViewController.h
//  MinghaoMarket
//
//  Created by TOMSZ on 15/4/20.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateStoreViewController : UIViewController{

}

@property (strong, nonatomic) IBOutlet UITextField *theStoreName;


@property (strong, nonatomic) IBOutlet UITextField *thePayNumber;


@property (copy,nonatomic) NSString *imageName;


@property (copy,nonatomic) NSString *theStoreImageName;


@property(retain,nonatomic)NSMutableArray *userMsg;

@property(retain,nonatomic)NSMutableArray *storeMsg;
@end
