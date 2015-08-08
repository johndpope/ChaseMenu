#import "AbstractOSXCell.h"
#import "Theme.h"

#define fireNotification(I)  [[NSNotificationCenter defaultCenter] performSelectorOnMainThread: @selector(postNotification:) withObject:[NSNotification notificationWithName:I object:self userInfo:nil] waitUntilDone: NO];



@implementation AbstractOSXCell

- (BOOL)isFlipped {
    return YES;
}

- (id)initWithFrame:(NSRect)frame navDelegate:(id)_navDelegate {
    self = [super initWithFrame:frame];
    if (self) {
        navDelegate = _navDelegate;
        //optimise speed
        bg = [[BackgroundView alloc]initWithFrame:frame];
        bg.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
        bg.offBgColor = [Theme bgColor];
        bg.onBgColor =  [Theme bgOnColor];
        [self addSubview:bg];
        
        self.title = [[JPNohitLablel alloc] initWithFrame:CGRectMake(10, 5, frame.size.width, 30)];
        self.title.autoresizingMask = NSViewWidthSizable;
       // self.title.lineBreakMode = UILineBreakModeWordWrap;
        self.title.font = [NSFont systemFontOfSize:17];
        self.title.textColor =  [NSColor blackColor];
        self.title.backgroundColor = [NSColor clearColor];
        
        [self addSubview:self.title];
        
        self.subTitle = [[JPNohitLablel alloc] initWithFrame:CGRectMake(10, 30, frame.size.width, 30)];
        //self.subTitle.lineBreakMode = UILineBreakModeWordWrap;
        self.subTitle.autoresizingMask = NSViewWidthSizable;
        self.subTitle.font = [NSFont systemFontOfSize:15];//[NSFont systemFontOfSize:15];
        self.subTitle.textColor =  [NSColor lightGrayColor];
        self.subTitle.backgroundColor = [NSColor clearColor];
        [self addSubview:self.subTitle];
        
        int opts = (NSTrackingMouseEnteredAndExited | NSTrackingActiveAlways);
        trackingArea = [[NSTrackingArea alloc] initWithRect:[self bounds]
                                                    options:opts
                                                      owner:self
                                                   userInfo:nil];
        [self addTrackingArea:trackingArea];
        
        
        //
    }
    return self;
}

- (void)dealloc {
    [self removeTrackingArea:trackingArea];
}

- (void)mouseEntered:(NSEvent *)theEvent {
    //draw rollover
    //NSLog(@"mouseEntered");
    
    bg.highlighted = YES;
    [bg setNeedsDisplay:YES];
}

- (void)mouseExited:(NSEvent *)theEvent {
    //draw normal
    //  NSLog(@"mouseExited");
    
    bg.highlighted = NO;
    [bg setNeedsDisplay:YES];
}

- (void)mouseDown:(NSEvent *)theEvent {
    NSLog(@"mouseDown");
    //self.title.textColor = IOS7RED;
    [navDelegate performSelector:@selector(cellSelected:) withObject:self afterDelay:0];
}

- (void)mouseUp:(NSEvent *)theEvent {
    NSLog(@"mouseUp");
}

@end



@implementation TransparentCell
- (void)drawBackgroundInRect:(NSRect)dirtyRect
{
    [[NSColor clearColor] setFill];
    NSRectFill(dirtyRect);
}

- (void)drawRect:(NSRect)dirtyRect
{
    [[NSColor clearColor] setFill];
    NSRectFill(dirtyRect);
    [super drawRect:dirtyRect];

}
-(BOOL)isOpaque{
    return NO;
}

//- (BOOL)isFlipped {
//    return YES;
//}

- (id)initWithFrame:(NSRect)frame navDelegate:(id)_navDelegate row:(NSInteger)row {
    self = [super initWithFrame:frame];
    if (self) {
        navDelegate = _navDelegate;
   
        self.wantsLayer = YES;
        self.layer.backgroundColor = [NSColor clearColor].CGColor;
    
        
        self.title = [[JPNohitLablel alloc] initWithFrame:CGRectMake(10, 5, frame.size.width, 30)];
        self.title.autoresizingMask = NSViewWidthSizable;
        // self.title.lineBreakMode = UILineBreakModeWordWrap;
        self.title.font = [NSFont systemFontOfSize:17];
        self.title.textColor =  [NSColor blackColor];
        self.title.backgroundColor = [NSColor clearColor];
        [self addSubview:self.title];
        
        self.subTitle = [[JPNohitLablel alloc] initWithFrame:CGRectMake(10, 30, frame.size.width, 30)];
        //self.subTitle.lineBreakMode = UILineBreakModeWordWrap;
        self.subTitle.autoresizingMask = NSViewWidthSizable;
        self.subTitle.font = [NSFont systemFontOfSize:15];//[NSFont systemFontOfSize:15];
        self.subTitle.textColor =  [NSColor lightGrayColor];
        self.subTitle.backgroundColor = [NSColor clearColor];
        [self addSubview:self.subTitle];
        
        int opts = (NSTrackingMouseEnteredAndExited | NSTrackingActiveAlways);
        trackingArea = [[NSTrackingArea alloc] initWithRect:[self bounds]
                                                    options:opts
                                                      owner:self
                                                   userInfo:nil];
        [self addTrackingArea:trackingArea];
        self.row = row;
        
        //
    }
    return self;
}



- (void)dealloc {
    [self removeTrackingArea:trackingArea];
}

- (void)mouseEntered:(NSEvent *)theEvent {
    //draw rollover
    //NSLog(@"mouseEntered");
    
//    bg.highlighted = YES;
//    [bg setNeedsDisplay:YES];
   // NSPoint pt2 =[self convertPoint:[theEvent locationInWindow] fromView:nil];
    NSLog(@"self.row:%d",(int)self.row);
    NSPoint pt = [theEvent locationInWindow];//
    //NSLog(@"NSControl mouseDow x:%f y:%f   x:%f y:%f", pt.x, pt.y, self.frame.origin.x, self.frame.origin.y);
    NSValue *vPoint = [NSValue valueWithPoint:pt];
    NSDictionary *d0 = [NSDictionary dictionaryWithObjectsAndKeys:vPoint,@"point",[NSNumber numberWithInteger:self.row],@"row", nil];
    
    [[NSNotificationCenter defaultCenter] performSelectorOnMainThread: @selector(postNotification:) withObject:[NSNotification notificationWithName:@"chaseMenu" object:self userInfo:d0] waitUntilDone: NO];
}

- (void)mouseExited:(NSEvent *)theEvent {
    //draw normal
    //  NSLog(@"mouseExited");
    
//    bg.highlighted = NO;
//    [bg setNeedsDisplay:YES];
}

- (void)mouseDown:(NSEvent *)theEvent {
    NSLog(@"mouseDown");
    //self.title.textColor = IOS7RED;
//    [navDelegate performSelector:@selector(cellSelected:) withObject:self afterDelay:0];
}

- (void)mouseUp:(NSEvent *)theEvent {
    NSLog(@"mouseUp");
}

@end



@implementation ChaseCell

- (void)drawRect:(NSRect)rect {
    [[NSColor clearColor] set];
    NSRectFillUsingOperation(rect, NSCompositeSourceOver);
    // do other drawings
}

- (BOOL)isFlipped {
    return YES;
}

- (id)initWithFrame:(NSRect)frame navDelegate:(id)_navDelegate {
    self = [super initWithFrame:frame];
    if (self) {
        navDelegate = _navDelegate;

        
        self.wantsLayer = YES;
        self.layer.borderWidth      = 2.0f;
        self.layer.borderColor      = [NSColor whiteColor].CGColor;
        self.layer.cornerRadius      = 6;
        self.layer.backgroundColor = [NSColor clearColor].CGColor;
//

        
        int opts = (NSTrackingMouseEnteredAndExited | NSTrackingActiveAlways);
        trackingArea = [[NSTrackingArea alloc] initWithRect:[self bounds]
                                                    options:opts
                                                      owner:self
                                                   userInfo:nil];
        [self addTrackingArea:trackingArea];
        
        
        //
    }
    return self;
}

- (void)dealloc {
    [self removeTrackingArea:trackingArea];
}

- (void)mouseEntered:(NSEvent *)theEvent {
    //draw rollover
    //NSLog(@"mouseEntered");
//    
//    bg.highlighted = YES;
//    [bg setNeedsDisplay:YES];
}

- (void)mouseExited:(NSEvent *)theEvent {
    //draw normal
    //  NSLog(@"mouseExited");
    
//    bg.highlighted = NO;
//    [bg setNeedsDisplay:YES];
}

- (void)mouseDown:(NSEvent *)theEvent {
    NSLog(@"mouseDown");
    //self.title.textColor = IOS7RED;
    [navDelegate performSelector:@selector(cellSelected:) withObject:self afterDelay:0];
}

- (void)mouseUp:(NSEvent *)theEvent {
    NSLog(@"mouseUp");
}

@end


