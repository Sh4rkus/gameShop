//
//  ShopDataSource.m
//  gameShop
//
//  Created by student on 4/4/15.
//  Copyright (c) 2015 SSU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShopDataSource.h"


@interface ShopDataSource()

@property(nonatomic) NSMutableArray *skinDictionaryArray;

@property(nonatomic) NSMutableArray *skinArray;
@property(nonatomic) NSMutableArray *unlockedSkins;


@end

@implementation ShopDataSource

-(instancetype)initWithSkins
{
    if((self = [super init]) == nil)
        return nil;
    
    [self createSkin:@"Skin1" withDescription:@"Skin1 Description" withPrice:@"777"];
    [self createSkin:@"Skin2" withDescription:@"Skin2 Description" withPrice:@"123"];
    [self createSkin:@"Skin3" withDescription:@"Skin3 Description" withPrice:@"999"];
    [self createSkin:@"Skin4" withDescription:@"Skin4 Description" withPrice:@"999"];
    [self createSkin:@"Skin5" withDescription:@"Skin5 Description" withPrice:@"999"];
    [self createSkin:@"Skin6" withDescription:@"Skin6 Description" withPrice:@"999"];
    [self createSkin:@"Skin7" withDescription:@"Skin7 Description" withPrice:@"999"];
    [self createSkin:@"Skin8" withDescription:@"Skin8 Description" withPrice:@"999"];
    [self createSkin:@"Skin9" withDescription:@"Skin9 Description" withPrice:@"999"];
    
    return self;
    
}

-(NSMutableArray *) skinArray
{
    if(!_skinArray){
        _skinArray = [[NSMutableArray alloc] init];
    }
    return _skinArray;
}

-(void) createSkin:(NSString *) name withDescription:(NSString *)desc withPrice:(NSString *)price
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:name forKey:@"name"];
    [dict setObject:desc forKey:@"description"];
    [dict setObject:price forKey:@"price"];
   // [dict setObject:img forKey@"image"];
    
    NSLog(@"Created Skin %@", dict);
    
    Skin *skin = [[Skin alloc] initWithDictionary:dict];
    
    [skin print];
    
    [self.skinArray addObject:skin];
    
    NSLog(@"Skin Array Count %lu", (unsigned long)[self.skinArray count]);
    
}

-(Skin *) skinAtIndex: (NSInteger) idx
{
    if( idx >= [self.skinArray count] )
        return nil;
    return [self.skinArray objectAtIndex: idx];
}

-(NSInteger) numberOfSkins
{
    return [self.skinArray count];
}







@end