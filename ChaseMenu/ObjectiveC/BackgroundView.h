
#import <Cocoa/Cocoa.h>

@interface BackgroundView : NSView {
}
@property (nonatomic)    BOOL highlighted;
@property (atomic, readwrite) int myTag;
@property (nonatomic, strong)    NSColor *offBgColor;
@property (nonatomic, strong)    NSColor *onBgColor;
@end

@interface NoHitBackgroundView : BackgroundView
@end

