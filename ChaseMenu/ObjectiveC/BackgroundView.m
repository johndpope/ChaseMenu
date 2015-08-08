
#import "BackgroundView.h"


@implementation NoHitBackgroundView
- (NSView *)hitTest:(NSPoint)aPoint {
    return nil;
}

@end

@implementation BackgroundView


//- (BOOL)isFlipped {
//    return YES;
//}

- (void)drawRect:(NSRect)dirtyRect {
    if (self.highlighted) {
        [self.onBgColor set];
    }
    else {
        [self.offBgColor set];
    }
    NSRectFill(dirtyRect);
}

@end

