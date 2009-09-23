#import <objc/runtime.h>
#import "TerminalCopyOnSelect.h"
#import "TCOSPreferences.h"

@implementation NSObject (TerminalCopyOnSelect)
- (void)
myMouseUp:(NSEvent *)theEvent
{
	[self myMouseUp:theEvent];
	if(![[NSUserDefaults standardUserDefaults] boolForKey:USER_DEFAULTS_KEY]) return;
	NSString *selectedText = [[(id)self performSelector:@selector(selectedText)] retain];
	if([selectedText length] > 0){
		[(id)self performSelector:@selector(copy:) withObject:nil];
	}
	[selectedText release];
}
@end

@implementation TerminalCopyOnSelect
+(void) load
{
	// allocate and initialize the preferences which load the user defaults
	[TCOSPreferences sharedInstance];
	
	Class class = objc_getClass("TTView");
	Method mouseUp = class_getInstanceMethod(class, @selector(mouseUp:));
	Method myMouseUp = class_getInstanceMethod(class, @selector(myMouseUp:));
	method_exchangeImplementations(mouseUp, myMouseUp);
	
	NSLog(@"TerminalCopyOnSelect installed");
}
@end