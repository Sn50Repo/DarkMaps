#import "MKMapView.h"
#import "UIView.h"

%hook MKMapView
- (void) _setShowsNightMode:(BOOL)arg1 {
	%orig(true);
}

- (BOOL) _showsNightMode {
	return true;
}
%end

%hook UIView
	- (void) layoutSubviews {
		%orig;

		if (self._mapKit_mapView != nil) {
			[self._mapKit_mapView _setShowsNightMode:true];
		}
	}
%end

%ctor {
	@autoreleasepool {
		NSArray *args = [[NSClassFromString(@"NSProcessInfo") processInfo] arguments];
		NSUInteger count = args.count;
		if (count != 0) {
			NSString *executablePath = args[0];
			if (executablePath) {
				NSString *processName = [executablePath lastPathComponent];
				BOOL isSpringBoard = [processName isEqualToString:@"SpringBoard"];
				BOOL isApplication = [executablePath rangeOfString:@"/Application/"].location != NSNotFound || [executablePath rangeOfString:@"/Applications/"].location != NSNotFound;

				if (isSpringBoard || isApplication) {
					%init;
				}
			}
		}
	}
}