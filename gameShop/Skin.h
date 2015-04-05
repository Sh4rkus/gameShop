//
//  Skin.h
//  gameShop
//
//  Created by student on 4/4/15.
//  Copyright (c) 2015 SSU. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Skin : NSObject

-(void) addValue: (NSString *) attrVal forAttribute: (NSString *) attrName;
-(id) initWithDictionary: (NSDictionary *) dictionary;
-(void) print;

-(NSString *) name;
-(NSAttributedString *) nameForListEntry;
-(NSString *) description;
-(NSAttributedString *) descriptionForListEntry;
-(NSString *) price;
-(NSAttributedString *) skinForListEntry;



@end
