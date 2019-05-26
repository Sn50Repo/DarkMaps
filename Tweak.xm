#import "UIView.h"
// #import "MSDGoogleMapAdapter.h"
// #import "GMSMapStyle.h"

// static NSString *kNightStyle = @"[{\"elementType\": \"geometry\", \"stylers\": [{\"color\": \"#242f3e\"} ] }, {\"elementType\": \"labels.text.fill\", \"stylers\": [{\"color\": \"#746855\"} ] }, {\"elementType\": \"labels.text.stroke\", \"stylers\": [{\"color\": \"#242f3e\"} ] }, {\"featureType\": \"administrative.locality\", \"elementType\": \"labels.text.fill\", \"stylers\": [{\"color\": \"#d59563\"} ] }, {\"featureType\": \"poi\", \"elementType\": \"labels.text.fill\", \"stylers\": [{\"color\": \"#d59563\"} ] }, {\"featureType\": \"poi.park\", \"elementType\": \"geometry\", \"stylers\": [{\"color\": \"#263c3f\"} ] }, {\"featureType\": \"poi.park\", \"elementType\": \"labels.text.fill\", \"stylers\": [{\"color\": \"#6b9a76\"} ] }, {\"featureType\": \"road\", \"elementType\": \"geometry\", \"stylers\": [{\"color\": \"#38414e\"} ] }, {\"featureType\": \"road\", \"elementType\": \"geometry.stroke\", \"stylers\": [{\"color\": \"#212a37\"} ] }, {\"featureType\": \"road\", \"elementType\": \"labels.text.fill\", \"stylers\": [{\"color\": \"#9ca5b3\"} ] }, {\"featureType\": \"road.highway\", \"elementType\": \"geometry\", \"stylers\": [{\"color\": \"#746855\"} ] }, {\"featureType\": \"road.highway\", \"elementType\": \"geometry.stroke\", \"stylers\": [{\"color\": \"#1f2835\"} ] }, {\"featureType\": \"road.highway\", \"elementType\": \"labels.text.fill\", \"stylers\": [{\"color\": \"#f3d19c\"} ] }, {\"featureType\": \"transit\", \"elementType\": \"geometry\", \"stylers\": [{\"color\": \"#2f3948\"} ] }, {\"featureType\": \"transit.station\", \"elementType\": \"labels.text.fill\", \"stylers\": [{\"color\": \"#d59563\"} ] }, {\"featureType\": \"water\", \"elementType\": \"geometry\", \"stylers\": [{\"color\": \"#17263c\"} ] }, {\"featureType\": \"water\", \"elementType\": \"labels.text.fill\", \"stylers\": [{\"color\": \"#515c6d\"} ] }, {\"featureType\": \"water\", \"elementType\": \"labels.text.stroke\", \"stylers\": [{\"color\": \"#17263c\"} ] } ]";

%hook UIView
	- (void) layoutSubviews {
		%orig;

		if (self._mapKit_mapView != nil) {
			[self._mapKit_mapView _setShowsNightMode:true];
		}
	}
%end

// %hook MSDGoogleMapAdapter
// - (void) mapStyle:(GMSMapStyle*)arg1 {
// 	NSError *error;
// 	GMSMapStyle *style = [GMSMapStyle styleWithJSONString:kNightStyle error:&error];
// 	%orig(style);
// }
// %end

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
					%init
				}
			}
		}
	}
}