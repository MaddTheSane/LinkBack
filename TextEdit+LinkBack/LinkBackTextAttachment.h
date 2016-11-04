//
//  LinkBackTextAttachment.h
//  TextEdit
//
//  Created by Charles Jolley on Tue Jun 15 2004.
//  Copyright (c) 2004 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface LinkBackTextAttachment : NSTextAttachment {
    id _linkBackData ;
    id _linkBackItemKey ;
}

@property (copy) id linkBackData ;
@property (nonatomic, copy) id linkBackItemKey ;

@end
