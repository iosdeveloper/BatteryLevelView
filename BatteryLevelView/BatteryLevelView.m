//
//  BatteryLevelView.m
//  Created by http://github.com/iosdeveloper
//

#import "BatteryLevelView.h"

@implementation BatteryLevelView

- (id)initWithCoder:(NSCoder *)aDecoder {
	self = [super initWithCoder:aDecoder];
	
	if (self) {
		[self setContentMode:UIViewContentModeCenter];
		
#if TARGET_IPHONE_SIMULATOR
		[self setImage:[UIImage imageNamed:@"BatteryBG_16.png"]];
#else
		NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
		[notificationCenter addObserver:self selector:@selector(updateLevel) name:UIDeviceBatteryLevelDidChangeNotification object:nil];
		[notificationCenter addObserver:self selector:@selector(updateLevel) name:UIDeviceBatteryStateDidChangeNotification object:nil];
		
		[[UIDevice currentDevice] setBatteryMonitoringEnabled:YES];
#endif
	}
	
	return self;
}

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	
	if (self) {
		[self setContentMode:UIViewContentModeCenter];
		
#if TARGET_IPHONE_SIMULATOR
		[self setImage:[UIImage imageNamed:@"BatteryBG_16.png"]];
#else
		NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
		[notificationCenter addObserver:self selector:@selector(updateLevel) name:UIDeviceBatteryLevelDidChangeNotification object:nil];
		[notificationCenter addObserver:self selector:@selector(updateLevel) name:UIDeviceBatteryStateDidChangeNotification object:nil];
		
		[[UIDevice currentDevice] setBatteryMonitoringEnabled:YES];
#endif
	}
	
	return self;
}

- (void)updateLevel {
	UIDevice *currentDevice = [UIDevice currentDevice];
	
	if ([currentDevice batteryState] == UIDeviceBatteryStateFull) {
		[self setImage:[UIImage imageNamed:@"BatteryBG_17.png"]];
	} else {
		float batteryLevel = lroundf([currentDevice batteryLevel] * 16.0);
		
		if (batteryLevel != -1.0) {
			[self setImage:[UIImage imageNamed:[NSString stringWithFormat:@"BatteryBG_%.f.png", batteryLevel]]];
		}
	}
}

@end