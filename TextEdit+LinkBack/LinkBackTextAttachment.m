//
//  LinkBackTextAttachment.m
//  TextEdit
//
//  Created by Charles Jolley on Tue Jun 15 2004.
//  Copyright (c) 2004 __MyCompanyName__. All rights reserved.
//

#import "LinkBackTextAttachment.h"
#import <LinkBack/LinkBack.h> 

@implementation LinkBackTextAttachment
@synthesize linkBackData = _linkBackData;
@synthesize linkBackItemKey = _linkBackItemKey;

- (void)dealloc
{
    if (_linkBackData) [_linkBackData release]; 
    if (_linkBackItemKey) [_linkBackItemKey release] ;
    [super dealloc] ;
}

- (id)linkBackItemKey 
{
    if (!_linkBackItemKey) [self setLinkBackItemKey: LinkBackUniqueItemKey()] ;
    return _linkBackItemKey ;
}

@end
