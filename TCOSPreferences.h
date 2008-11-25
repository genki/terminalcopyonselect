#import <Cocoa/Cocoa.h>

#define USER_DEFAULTS_KEY @"Copy On Select"

@interface TCOSPreferences : NSObject
{
	IBOutlet NSMenu *terminalMenuAdditions;
}
+(TCOSPreferences*)sharedInstance;
-(id)init;
-(IBAction)toggle:(NSMenuItem *)sender;
@end