
#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

static BOOL USE_DARK_THEME;

@interface Theme : NSObject


+ (void)useDarkTheme:(int)bDark;

+ (BOOL)isDarkTheme;
+ (NSColor *)fadedBgColor;
+ (NSColor *)bgColor;
+ (NSColor *)borderColor;
+ (NSColor *)bgOnColor;
+ (NSColor *)folderBG;
+ (NSColor *)iosdetail;
+ (NSColor *)iosMailBlueOrBlack;
+ (NSColor *)lineColor;
+ (NSColor *)iosBlueOrPrimary;
+ (NSColor *)iosGreenOrSecondary;
+ (NSColor *)iosHeaderColor;
+ (NSColor *)headerBlueOr;
+ (NSColor *)blackNoteOrWhite;
+ (NSColor *)whiteButtonOr;
+ (NSColor *)folderText;
+ (NSColor *)iosHeaderTitleColor;
+ (NSColor *)successColor;
+ (NSColor *)noteColor0;
+ (NSColor *)noteColor1;
+ (NSColor *)separatorColor;
+ (NSColor *)clearFolderOrGrey;
+ (NSColor *)blueTextOrWhite;
+ (NSColor *)blueHighlightOr;
+ (NSColor *)clearSwitchBgOrAdobeBlack;
+ (void)toggleTheme;
+ (NSColor *)menuBackground;
+ (NSColor *)menuOnBackground;
+ (NSColor *)logo1;
+ (NSColor *)logo2;
+ (NSColor *)headerBar;
+ (NSColor *)infoColor;
+ (NSColor *)headerText;
+ (Theme *)shared;
+ (NSColor *)treeBackground;
+ (NSColor *)treeHighlightedCell;
@end
