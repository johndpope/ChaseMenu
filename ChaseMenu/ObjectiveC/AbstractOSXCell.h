#import <Cocoa/Cocoa.h>
#import "BackgroundView.h"
#import "JPLabel.h"
#import "RMAlphaAnimationBlurredView.h"

@interface AbstractOSXCell : NSTableCellView {
    NSTrackingArea *trackingArea;
    BackgroundView *bg;
    id navDelegate;
}
@property (nonatomic) int row;

@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) JPNohitLablel *title;
@property (nonatomic, strong) JPNohitLablel *subTitle;
- (id)initWithFrame:(NSRect)frame navDelegate:(id)navDelegate;
@end

@interface TransparentCell : NSTableCellView {
    NSTrackingArea *trackingArea;

    id navDelegate;
}
@property (nonatomic) NSInteger row;

@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) JPNohitLablel *title;
@property (nonatomic, strong) JPNohitLablel *subTitle;

- (id)initWithFrame:(NSRect)frame navDelegate:(id)_navDelegate row:(NSInteger)row;
@end


@interface ChaseCell : RMAlphaAnimationBlurredView {
    NSTrackingArea *trackingArea;
    RMAlphaAnimationBlurredView *bg;
    id navDelegate;
}
@property (nonatomic) int row;


- (id)initWithFrame:(NSRect)frame navDelegate:(id)navDelegate;
@end