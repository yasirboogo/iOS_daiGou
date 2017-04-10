//
//  YNUpdatePswordTableView.h
//  AgentSsales
//
//  Created by innofive on 17/1/2.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YNUpdatePswordTableView : UITableView

@property (nonatomic,strong) NSArray<NSDictionary*> *inforArray;

@property (nonatomic,copy) NSString * oldPasswod;

@property (nonatomic,copy) NSString * firPasswod;

@property (nonatomic,copy) NSString * secPasswod;

@end
