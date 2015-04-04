//
//  ShopDataSource.h
//  gameShop
//
//  Created by student on 4/4/15.
//  Copyright (c) 2015 SSU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Skin.h"
@interface ShopDataSource : NSObject

-(instancetype)initWithSkins;

-(NSMutableArray *) skinArray;
-(NSMutableArray *) skinDictionaryArray;
-(NSMutableArray *) unlockedSkins;
-(NSInteger) numberOfSkins;

-(Skin *) skinAtIndex: (NSInteger) idx;

@end