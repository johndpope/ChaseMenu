#import <Cocoa/Cocoa.h>
#import "AbstractOSXCell.h"
#import "BackgroundView.h"

@class AlphaBlackCloseMenuView;

#define MENU_WIDTH 260


@interface ListVC : NSViewController <NSTableViewDataSource, NSTableViewDelegate> {

    NSWindow *superWindow;
    NSMutableArray *_tableContents0;
    
    
    NSIndexPath *selectedIndex;
    NSScrollView *tableContainer0;
    
    NSTrackingArea *trackingArea0;
    NSTrackingArea *trackingArea1;
    int rowGroup;
    float w;
    BOOL isMenuHidden;
    NSScrollView *tableContainer;
    NSTrackingArea *trackingArea2;
    BOOL isMouseOver;
    AlphaBlackCloseMenuView *bg;
    
    ChaseCell *chaseCell;
    NSDateFormatter *df;
    NSMutableArray *rows;
    int chaseRow;
    NSView *bgContainer;
    BOOL goingUp;
    CGFloat chaseOpacity;
    int scrollingState;
}

@property (nonatomic, strong) NSTableView *tableView;
- (id)initWithWindow:(NSWindow*)window;

@end

@interface AlphaBlackCloseMenuView : BackgroundView
@property (nonatomic) BOOL isRight;
@end