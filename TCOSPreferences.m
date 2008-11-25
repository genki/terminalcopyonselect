#import "TCOSPreferences.h"

@implementation TCOSPreferences
+(TCOSPreferences*)sharedInstance
{
	static TCOSPreferences* pref = nil;
	if (pref == nil) {
		pref = [[TCOSPreferences alloc] init];
	}
	return pref;
}

-(id)init
{
	self = [super init];

	[NSBundle loadNibNamed:@"TCOSPreferences.nib" owner:self];
	return self;
}

-(void)awakeFromNib
{
	BOOL copyOnSelect = [[NSUserDefaults standardUserDefaults] boolForKey:USER_DEFAULTS_KEY];
	NSMenu* applicationMenu = [[[[NSApplication sharedApplication] mainMenu] itemAtIndex: 0] submenu];
	for(NSMenuItem* menuItem in [terminalMenuAdditions itemArray]){
		menuItem.state = copyOnSelect;
		[terminalMenuAdditions removeItem:menuItem];
		[applicationMenu insertItem:menuItem atIndex:3];
	}
}

-(IBAction)
toggle:(NSMenuItem *)sender
{
	sender.state = 1 - sender.state;
	[[NSUserDefaults standardUserDefaults] setBool:sender.state forKey:USER_DEFAULTS_KEY];
}
@end