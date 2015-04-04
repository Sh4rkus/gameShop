//
//  Skin.m
//  gameShop
//
//  Created by student on 4/4/15.
//  Copyright (c) 2015 SSU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Skin.h"

enum { VIEW_HEIGHT = 90 };

@interface Skin()

@property (nonatomic) NSMutableDictionary *allSkins;

@end

@implementation Skin


//Init with dictionary of skins from SkinDataSource
-(NSMutableDictionary *) allSkins{
    if(! _allSkins )
        _allSkins = [[NSMutableDictionary alloc] init];
    return _allSkins;
    
}

-(id) initWithDictionary: (NSDictionary *) dictionary
{
    if( (self = [super init]) == nil )
        return nil;
    self.allSkins = [NSMutableDictionary dictionaryWithDictionary:dictionary];
    
    
    return self;
}

-(void) addValue: (NSString *) attrVal forAttribute: (NSString *) attrName;
{
    [self.allSkins setObject: attrVal forKey: attrName];
}

-(NSString *) getValueForAttribute: (NSString *) attr
{
    return [self.allSkins valueForKey: attr ];
}

-(NSString *) name
{
    return [self.allSkins valueForKey: @"name"];
}

-(NSString *) description
{
    return [self.allSkins valueForKey:@"description"];
}

-(NSString *) price
{
    return [self.allSkins valueForKey:@"price"];
}

-(CGSize) sizeOfListEntryView
{
    CGRect bounds = [[UIScreen mainScreen] applicationFrame];
    return CGSizeMake( bounds.size.width, VIEW_HEIGHT);
}


/*-(UIImage *)  imageForListEntry
{
    NSString *imageName = [self getValueForAttribute:@"smallImageURL"];
}*/


-(NSAttributedString *) compose: (NSString *) str withBoldPrefix: (NSString *) prefix
{
    const CGFloat fontSize = 13;
    UIFont *boldFont = [UIFont boldSystemFontOfSize:fontSize];
    UIFont *regularFont = [UIFont systemFontOfSize:fontSize];
    UIFont *italicFont = [UIFont italicSystemFontOfSize:fontSize];
    UIColor *foregroundColor = [UIColor blackColor];
    
    // Create the attributes
    NSMutableDictionary *attrs = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  regularFont, NSFontAttributeName,
                                  foregroundColor, NSForegroundColorAttributeName, nil];
    
    NSDictionary *boldAttrs = [NSDictionary dictionaryWithObjectsAndKeys:
                               boldFont, NSFontAttributeName, nil];
    
    NSMutableAttributedString *attrString = nil;
    if( [prefix isEqualToString: @""] ) {
        [attrs setObject:italicFont forKey:NSFontAttributeName];
        attrString = [[NSMutableAttributedString alloc] initWithString:str attributes:attrs];
    } else {
        NSString *text = [NSString stringWithFormat:@"%@: %@", prefix, str];
        attrString = [[NSMutableAttributedString alloc] initWithString:text attributes:attrs];
        NSRange range = NSMakeRange(0, prefix.length);
        [attrString setAttributes:boldAttrs range:range];
    }
    return attrString;
}

-(NSAttributedString *) skinForListEntry
{
    NSMutableAttributedString *name = [[self nameForListEntry] mutableCopy];
    NSMutableAttributedString *description = [[self descriptionForListEntry] mutableCopy];
    NSMutableAttributedString *price = [[self priceForListEntry] mutableCopy];
    [name replaceCharactersInRange: NSMakeRange(name.length, 0) withString: @"\n"];
    [description replaceCharactersInRange: NSMakeRange(description.length, 0) withString:@"\n"];
    [price replaceCharactersInRange: NSMakeRange(price.length, 0) withString:@"\n"];
    [name appendAttributedString:description];
    [name appendAttributedString:price];
    
    return name;
}

-(NSAttributedString *) nameForListEntry
{
    NSString *name = [self name];
    
    return [self compose:name withBoldPrefix:@""];
}

-(NSAttributedString *) descriptionForListEntry {
   
    NSString *description = [self description];
    return [self compose:description withBoldPrefix:@"Description"];
}

-(NSAttributedString *) priceForListEntry
{
    NSString *price = [self price];
    return [self compose:price withBoldPrefix:@"Price"];
}


-(void) print
{
    NSEnumerator *mEnum = [self.allSkins keyEnumerator];
    NSString *attrName;
    while( attrName = (NSString *) [mEnum nextObject] ) {
        NSLog( @"Attribute Name:  %@", attrName );
        NSLog( @"Atrribute Value: %@", [self.allSkins objectForKey: attrName] );
    }
}


@end
