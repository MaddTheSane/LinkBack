// SKTDrawWindowController.m
// Sketch Example
//

#import "SKTDrawWindowController.h"
#import "SKTGraphicView.h"
#import "SKTGraphic.h"
#import "SKTToolPaletteController.h"

@implementation SKTDrawWindowController

- (id)init {
    self = [super initWithWindowNibName:@"DrawWindow"];
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (NSSize)documentSize {
    if ([self document]) {
        return [[self document] documentSize];
    } else {
        NSPrintInfo *printInfo = [NSPrintInfo sharedPrintInfo];
        NSSize paperSize = [printInfo paperSize];
        paperSize.width -= ([printInfo leftMargin] + [printInfo rightMargin]);
        paperSize.height -= ([printInfo topMargin] + [printInfo bottomMargin]);
        return paperSize;
    }
}

- (void)setUpGraphicView {
    NSSize paperSize = [self documentSize];

    [graphicView setFrameSize:paperSize];
    [graphicView setNeedsDisplay:YES];
}

- (void)selectedToolDidChange:(NSNotification *)notification {
    // Just set the correct cursor
    Class theClass = [[SKTToolPaletteController sharedToolPaletteController] currentGraphicClass];
    NSCursor *theCursor = nil;
    if (theClass) {
        theCursor = [theClass creationCursor];
    }
    if (!theCursor) {
        theCursor = [NSCursor arrowCursor];
    }
    [[graphicView enclosingScrollView] setDocumentCursor:theCursor];
}

- (void)windowDidLoad {
    NSScrollView *enclosingScrollView;
    
    [super windowDidLoad];
    
    [graphicView setDrawWindowController:self];
    [self setUpGraphicView];

    enclosingScrollView = [graphicView enclosingScrollView];
    [enclosingScrollView setHasHorizontalRuler:YES];
    [enclosingScrollView setHasVerticalRuler:YES];
    [enclosingScrollView setBorderType:((NSInterfaceStyleForKey(nil, enclosingScrollView) == NSWindows95InterfaceStyle) ? NSBezelBorder : NSNoBorder)];

    [[self window] makeFirstResponder:graphicView];

    [self selectedToolDidChange:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectedToolDidChange:) name:SKTSelectedToolDidChangeNotification object:[SKTToolPaletteController sharedToolPaletteController]];
}

- (void)setDocument:(NSDocument *)document {
    [super setDocument:document];
    [self setUpGraphicView];
}

- (SKTGraphicView *)graphicView {
    return graphicView;
}

- (void)invalidateGraphic:(SKTGraphic *)graphic {
    [graphicView invalidateGraphic:graphic];
}

@end

/*
 IMPORTANT:  This Apple software is supplied to you by Apple Computer, Inc. ("Apple") in
 consideration of your agreement to the following terms, and your use, installation,
 modification or redistribution of this Apple software constitutes acceptance of these
 terms.  If you do not agree with these terms, please do not use, install, modify or
 redistribute this Apple software.

 In consideration of your agreement to abide by the following terms, and subject to these
 terms, Apple grants you a personal, non-exclusive license, under Apple's copyrights in
 this original Apple software (the "Apple Software"), to use, reproduce, modify and
 redistribute the Apple Software, with or without modifications, in source and/or binary
 forms; provided that if you redistribute the Apple Software in its entirety and without
 modifications, you must retain this notice and the following text and disclaimers in all
 such redistributions of the Apple Software.  Neither the name, trademarks, service marks
 or logos of Apple Computer, Inc. may be used to endorse or promote products derived from
 the Apple Software without specific prior written permission from Apple. Except as expressly
 stated in this notice, no other rights or licenses, express or implied, are granted by Apple
 herein, including but not limited to any patent rights that may be infringed by your
 derivative works or by other works in which the Apple Software may be incorporated.

 The Apple Software is provided by Apple on an "AS IS" basis.  APPLE MAKES NO WARRANTIES,
 EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION THE IMPLIED WARRANTIES OF NON-INFRINGEMENT,
 MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS
 USE AND OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.

 IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL OR CONSEQUENTIAL
 DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
          OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE,
 REPRODUCTION, MODIFICATION AND/OR DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED AND
 WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE), STRICT LIABILITY OR
 OTHERWISE, EVEN IF APPLE HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */
