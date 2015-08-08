#import "ListVC.h"
#import "AbstractOSXCell.h"
#import "Theme.h"
#import <QuartzCore/QuartzCore.h>

@interface JPTableRowView:NSTableRowView
@end
@implementation JPTableRowView


-(BOOL)isOpaque{
    return NO;
}

//- (BOOL)isFlipped {
//    return YES;
//}

- (void)drawBackgroundInRect:(NSRect)dirtyRect
{
    [[NSColor clearColor] setFill];
    NSRectFill(dirtyRect);
}
@end

@interface JPScrollView:NSScrollView
@end

@implementation JPScrollView

- (void) drawRect:(NSRect)rect
{
    [super drawRect: rect];
    //NSEraseRect([self bounds]);
    
}
- (BOOL)isOpaque {
    
    return NO;
}
- (void)drawBackgroundInClipRect:(NSRect)clipRect {
    
    // don't draw a background rect
}

@end
@interface JPTableView:NSTableView
@end
@implementation JPTableView

- (void)drawBackgroundInClipRect:(NSRect)clipRect {
    
    // don't draw a background rect
}

//-(void)drawGridInClipRect:(NSRect)clipRect {
//   // [super drawGridInClipRect:clipRect];
//     NSEraseRect(clipRect);
//}
//
- (void) drawRect:(NSRect)rect
{
  [super drawRect: rect];
}
//
- (BOOL)isOpaque {
    
    return NO;
}
//- (void)drawBackgroundInClipRect:(NSRect)clipRect {
//     NSEraseRect(clipRect);
//    
//    // don't draw a background rect
//}


@end
@interface ListVC ()
{

}
@end


@implementation ListVC

- (id)initWithWindow:(NSWindow*)window {
    self = [super init];
    superWindow = window;
    df = [[NSDateFormatter alloc] init];
    [df setFormatterBehavior:NSDateFormatterBehavior10_4];
    [df setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    rows = [[NSMutableArray alloc]init];
    return self;
}

- (void)mouseEntered:(NSEvent *)theEvent {
    //draw rollover
    // NSLog(@"mouseEntered");
}

- (void)mouseExited:(NSEvent *)theEvent {
    //draw normal
    //NSLog(@"mouseExited");
}

- (void)mouseDown:(NSEvent *)theEvent {
    //  NSLog(@"mouseDown");
}

- (void)mouseUp:(NSEvent *)theEvent {
    //NSLog(@"mouseUp");
}

- (void)loadView {
  //  NSLog(@"loadView className: %@", self.className);

    _tableContents0 = [[NSMutableArray alloc] init];

    CGRect winRect = ((NSView*)superWindow.contentView).bounds;
    self.view = [[NSView alloc]initWithFrame:winRect];
    [self.view setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
    self.view.wantsLayer = YES;
    self.view.layer.backgroundColor = [NSColor whiteColor].CGColor;
    
    // BACKGROUND SCROLL VIEWS
    //add 2 images into container
    NSImage *img =[NSImage imageNamed:@"128159.png"];
   // NSImage *img =[NSImage imageNamed:@"maxresdefault.jpg"];
     NSImageView *mybg = [[NSImageView alloc]initWithFrame:winRect];
    [mybg setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
    mybg.image = img;
    mybg.frame = NSMakeRect(0, 0, mybg.image.size.width,mybg.image.size.height);
   
    NSImageView *mybg1 = [[NSImageView alloc]initWithFrame:winRect];
    [mybg1 setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
    mybg1.image = img;
    mybg1.frame = NSMakeRect(mybg.image.size.width, 0, mybg.image.size.width,mybg.image.size.height);
    NSRect containerFrame = NSMakeRect(0, 0, mybg.image.size.width*2,mybg.image.size.height);
    bgContainer = [[NSView alloc]initWithFrame:containerFrame];
    [bgContainer addSubview:mybg];
    [bgContainer addSubview:mybg1];
    [self.view addSubview:bgContainer];
    
//    int opts = (NSTrackingMouseEnteredAndExited | NSTrackingActiveAlways);
//    trackingArea2 = [[NSTrackingArea alloc] initWithRect:self.view.bounds
//                                                 options:opts
//                                                   owner:self
//                                                userInfo:nil];
//    [self.view addTrackingArea:trackingArea2];
    
    // Chase Cell
    chaseOpacity = 0.3f;
    chaseCell = [[ChaseCell alloc] initWithFrame:NSMakeRect(2, 2, self.view.bounds.size.width-4, 76) navDelegate:nil];
    chaseCell.tintColor = [NSColor clearColor];
    chaseCell.blurRadius = 15;
    chaseCell.saturationFactor = 4;
    chaseCell.autoresizingMask = NSViewWidthSizable ;
    chaseCell.alphaValue = chaseOpacity;
    [self.view addSubview:chaseCell];
    
    w = self.view.bounds.size.width;
    NSRect rect = CGRectMake(0, self.view.bounds.size.height - 50, self.view.bounds.size.width, 50);
    rect = CGRectMake(0, 0, w, self.view.bounds.size.height);
    NSRect rect0 = CGRectMake(0, 0, w, self.view.bounds.size.height - 200);
    tableContainer = (NSScrollView*)[[JPScrollView alloc]initWithFrame:rect0];
    tableContainer.drawsBackground = NO;
    tableContainer.wantsLayer = YES;
    tableContainer.layer.backgroundColor = [NSColor clearColor].CGColor;
    tableContainer.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    tableContainer.borderType = NSNoBorder;
    tableContainer.enclosingScrollView.borderType = NSNoBorder;
    tableContainer.enclosingScrollView.drawsBackground = NO;
    [tableContainer setFocusRingType:NSFocusRingTypeNone];


    self.tableView = [[JPTableView alloc] initWithFrame:self.view.bounds];
    _tableView.wantsLayer = YES;
    _tableView.backgroundColor = [NSColor clearColor];
    _tableView.enclosingScrollView.drawsBackground = NO;
    _tableView.enclosingScrollView.drawsBackground = NO;
    _tableView.enclosingScrollView.borderType = NSNoBorder;
    _tableView.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.gridColor =[[NSColor lightGrayColor] colorWithAlphaComponent:0.25];; // remove the cell spacing
    _tableView.gridStyleMask = NSTableViewSolidHorizontalGridLineMask;
    _tableView.intercellSpacing = NSMakeSize(0, 0);
    _tableView.enclosingScrollView.borderType = NSNoBorder;
    _tableView.focusRingType = NSFocusRingTypeNone;
    NSRect frame = _tableView.headerView.frame;
    frame.size.height = 0;
    _tableView.headerView.frame = frame;
    tableContainer.documentView =_tableView;
    tableContainer.hasVerticalScroller = YES;
    [self.view addSubview:tableContainer];
    self.view.enclosingScrollView.borderType = NSNoBorder;
    [self.view setFocusRingType:NSFocusRingTypeNone];
    
    
    [self populateTable];
    [self.tableView reloadData];
    
    __block int x =0;
    [[NSNotificationCenter defaultCenter] addObserverForName:NSViewBoundsDidChangeNotification object:[[_tableView enclosingScrollView] contentView] queue:[NSOperationQueue mainQueue] usingBlock: ^(NSNotification *note) {
        NSLog(@"scrolling %@:",note);
        scrollingState = 1;
        // hide chase cell
        [[NSAnimationContext currentContext] setDuration:0.2];
        [[NSAnimationContext currentContext] setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        
        [NSAnimationContext runAnimationGroup: ^(NSAnimationContext *context) {
            [[chaseCell animator] setAlphaValue:0];
        } completionHandler: ^{
            scrollingState = 0;
        }];

    }];
   
    
    [[NSNotificationCenter defaultCenter] addObserverForName:@"chaseMenu" object:nil queue:[NSOperationQueue mainQueue] usingBlock: ^(NSNotification *note) {
        NSDictionary *user = note.userInfo;
        NSNumber *row = [user objectForKey:@"row"];
        if (row.intValue > chaseRow ){
            goingUp = NO;
        }else{
            goingUp = YES;
        }
        chaseRow = row.intValue;
        
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(chaseMenu) object:nil];
        [self performSelector:@selector(chaseMenu) withObject:nil afterDelay:0.1];
 
    }];

    [self scrollBackground];
    
}
-(void)scrollBackground{

    [[NSAnimationContext currentContext] setDuration:180];
    [[NSAnimationContext currentContext] setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    
    [NSAnimationContext runAnimationGroup: ^(NSAnimationContext *context) {
        NSRect r2 = NSMakeRect(-bgContainer.frame.size.width/2, 0, bgContainer.frame.size.width,bgContainer.frame.size.height);
        [[bgContainer animator] setFrame:r2];
        
    } completionHandler: ^{
        NSRect r2 = NSMakeRect(0, 0, bgContainer.frame.size.width,bgContainer.frame.size.height);
        [bgContainer  setFrame:r2];
        [self scrollBackground];
    }];
    
}

-(void)chaseMenu{

    if (scrollingState){ // we're scrolling - there's a defect with mouse wheel - try again a bit later
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(chaseMenu) object:nil];
        [self performSelector:@selector(chaseMenu) withObject:nil afterDelay:0.1];
        return;
    }
    // Chase!!
    //chaseCell.alphaValue = 0;
    [[NSAnimationContext currentContext] setDuration:0.5];
    [[NSAnimationContext currentContext] setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
        
    [NSAnimationContext runAnimationGroup: ^(NSAnimationContext *context) {

             [[chaseCell animator] setAlphaValue:chaseOpacity];
            NSRect r0 =  [_tableView rectOfRow:chaseRow];
            r0 = [_tableView convertRect:r0 toView:self.view];
            r0.origin.y +=2; // add spacer
            r0.origin.x +=2; // add spacer
            NSRect r1 = chaseCell.frame;
            r1.origin = r0.origin;
            [[chaseCell animator] setFrame:r1];

    } completionHandler: ^{
            //chaseCell.alphaValue = 0;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"cellLocked" object:nil];
    }];
  
    
}



- (void)viewDidLoad{
    [super viewDidLoad];


}
- (void)populateTable {
    for (int i = 0; i < 30; i++) {
        NSString *row = [NSString stringWithFormat:@"Row - %d",i];
        NSDictionary *d0 = @{ @"title":row };
        [_tableContents0 addObject:d0];
    }
}

#pragma mark NSTableView datasource
- (void)tableViewSelectionDidChange:(NSNotification *)notification {
    NSTableView *tv = (NSTableView *)[notification object];
    int row = [[notification object] selectedRow];
    //[self rowSelected:row];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return [_tableContents0 count];
}

#pragma mark NSTableView delegate

- (nullable NSTableRowView *)tableView:(NSTableView *)tableView rowViewForRow:(NSInteger)row {
    
    return [[JPTableRowView alloc]init]; //force translucency
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    NSDictionary *d0 = _tableContents0[row];
    TransparentCell *cellView = [[TransparentCell alloc] initWithFrame:NSMakeRect(0, 0, self.view.bounds.size.width, 82) navDelegate:self row:row];
    cellView.title.text = d0[@"title"];
    cellView.title.textColor  = [NSColor whiteColor];
    cellView.title.font  = [NSFont boldSystemFontOfSize:18];
    
    return cellView;
}



- (BOOL)tableView:(NSTableView *)tableView isGroupRow:(NSInteger)row {
    return YES;
}

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row {
    return 80;
}

-(void)chaseMenu:(NSNotification *)note{
    
}


#pragma mark NSTableView datasource

@end



@implementation AlphaBlackCloseMenuView

- (void)mouseMoved:(NSEvent *)theEvent {
    //draw rollover
    //NSLog(@"mouseEntered");
    //fireNotification(@"closeMenu");
    NSPoint pt = [self convertPoint:[theEvent locationInWindow] fromView:nil];
    //  NSLog(@"NSControl mouseDow x:%f y:%f   x:%f y:%f", pt.x, pt.y, self.frame.origin.x, self.frame.origin.y);
    if (self.isRight) {
        if (pt.x < self.bounds.size.width -  MENU_WIDTH) {
            //fireNotification(@"closeMenuRight");
        }
    }
    else {
        if (pt.x > MENU_WIDTH) {
           // fireNotification(@"closeMenu");
        }
    }
}

- (void)mouseExited:(NSEvent *)theEvent {
    //draw normal
    NSLog(@"mouseExited");
}

@end
