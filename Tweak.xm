#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


#define degreesToRadian(x)		(M_PI*x/180.0)

#define TAG_START_START			0x98642
#define TAG_START_LEFT			0x98643
#define TAG_START_RIGHT			0x98644
#define TAG_LEFT_START			0x98742
#define TAG_RIGHT_START			0x98842



UILabel *leftStartingLabelView = nil;

UILabel *rightStartingLabelView = nil;

UILabel *startRightwardLabelView = nil;
UILabel *startLeftwardLabelView = nil;
UILabel *startStartingLabelView = nil;


enum {
	MultitaskingGesturesAppNameStart = 0,
	MultitaskingGesturesAppNameLeft,
	MultitaskingGesturesAppNameRight,
};
typedef int MultitaskingGesturesAppNameMode;


@interface SBApplication
- (NSString *)displayName;
@end

@interface SBSwitchAppGestureView
- (UIView *)rightwardView;
- (UIView *)leftwardView;
- (UIView *)startingView;
- (SBApplication *)rightwardApp;
- (SBApplication *)leftwardApp;
- (SBApplication *)startingApp;
- (int)orientation;

- (void)setLabelView:(UIView *)view forMode:(MultitaskingGesturesAppNameMode)mode;
@end



%hook SBSwitchAppGestureView

- (void)setStartingView:(UIView *)startView {
	[self setLabelView:startView forMode:MultitaskingGesturesAppNameStart];
	
	%orig;
}

- (void)setLeftwardView:(UIView *)leftwardView {
	[self setLabelView:leftwardView forMode:MultitaskingGesturesAppNameLeft];
	
	%orig;
}

- (void)setRightwardView:(UIView *)rightwardView {
	[self setLabelView:rightwardView forMode:MultitaskingGesturesAppNameRight];
	
	%orig;
}

%new
- (void)setLabelView:(UIView *)view forMode:(MultitaskingGesturesAppNameMode)mode {
	if (view == nil) {
		if (startStartingLabelView) {
			[startStartingLabelView removeFromSuperview];
			[startStartingLabelView release];
			startStartingLabelView = nil;
		}
		if (startLeftwardLabelView) {
			[startLeftwardLabelView removeFromSuperview];
			[startLeftwardLabelView release];
			startLeftwardLabelView = nil;
		}
		if (startRightwardLabelView) {
			[startRightwardLabelView removeFromSuperview];
			[startRightwardLabelView release];
			startRightwardLabelView = nil;
		}
		if (leftStartingLabelView) {
			[leftStartingLabelView removeFromSuperview];
			[leftStartingLabelView release];
			leftStartingLabelView = nil;
		}
		if (rightStartingLabelView) {
			[rightStartingLabelView removeFromSuperview];
			[rightStartingLabelView release];
			rightStartingLabelView = nil;
		}
	} else {
		UILabel *startingLabelView = nil;
		UILabel *leftwardLabelView = nil;
		UILabel *rightwardLabelView = nil;
		
		CGFloat width = view.bounds.size.width;
		CGFloat height = [UIScreen mainScreen].bounds.size.height;
		CGRect startingLabelFrame;
		CGRect leftwardLabelFrame;
		CGRect rightwardLabelFrame;
		
		switch ([self orientation]) {
			case UIInterfaceOrientationPortraitUpsideDown:
				startingLabelFrame = CGRectMake((width-100)/2,height-60-50,100,30);
				leftwardLabelFrame = CGRectMake(width-100,height-60-50,100,30);
				rightwardLabelFrame = CGRectMake(0,height-60-50,100,30);
				break;
			case UIInterfaceOrientationLandscapeLeft:
				startingLabelFrame = CGRectMake(60-50,(height-30)/2,100,30);
				leftwardLabelFrame = CGRectMake(60-50,height-100,100,30);
				rightwardLabelFrame = CGRectMake(60-50,70,100,30);
				break;
			case UIInterfaceOrientationLandscapeRight:
				startingLabelFrame = CGRectMake(width-60-50,(height-30)/2,100,30);
				leftwardLabelFrame = CGRectMake(width-60-50,70,100,30);
				rightwardLabelFrame = CGRectMake(width-60-50,height-100,100,30);
				break;
			default:
			case UIInterfaceOrientationPortrait:
				startingLabelFrame = CGRectMake((width-100)/2,60,100,30);
				leftwardLabelFrame = CGRectMake(0,60,100,30);
				rightwardLabelFrame = CGRectMake(width-100,60,100,30);
				break;
		}
		
		switch (mode) {
			case MultitaskingGesturesAppNameStart:
				[startStartingLabelView removeFromSuperview];
				[startStartingLabelView release];
				[startLeftwardLabelView removeFromSuperview];
				[startLeftwardLabelView release];
				[startRightwardLabelView removeFromSuperview];
				[startRightwardLabelView release];
				
				startStartingLabelView = [[UILabel alloc] initWithFrame:startingLabelFrame];
				startLeftwardLabelView = [[UILabel alloc] initWithFrame:leftwardLabelFrame];
				startRightwardLabelView = [[UILabel alloc] initWithFrame:rightwardLabelFrame];
				startingLabelView = startStartingLabelView;
				leftwardLabelView = startLeftwardLabelView;
				rightwardLabelView = startRightwardLabelView;
				startingLabelView.tag = TAG_START_START;
				leftwardLabelView.tag = TAG_START_LEFT;
				rightwardLabelView.tag = TAG_START_RIGHT;
				break;
			case MultitaskingGesturesAppNameLeft:
				[leftStartingLabelView removeFromSuperview];
				[leftStartingLabelView release];
				
				leftStartingLabelView = [[UILabel alloc] initWithFrame:startingLabelFrame];
				startingLabelView = leftStartingLabelView;
				startingLabelView.tag = TAG_LEFT_START;
				break;
			case MultitaskingGesturesAppNameRight:
				[rightStartingLabelView removeFromSuperview];
				[rightStartingLabelView release];
				
				rightStartingLabelView = [[UILabel alloc] initWithFrame:startingLabelFrame];
				startingLabelView = rightStartingLabelView;
				startingLabelView.tag = TAG_RIGHT_START;
				break;
		}
		
		startingLabelView.lineBreakMode = UILineBreakModeMiddleTruncation;
		rightwardLabelView.lineBreakMode = UILineBreakModeMiddleTruncation;
		leftwardLabelView.lineBreakMode = UILineBreakModeMiddleTruncation;
		
		startingLabelView.textAlignment = UITextAlignmentCenter;
		rightwardLabelView.textAlignment = UITextAlignmentCenter;
		leftwardLabelView.textAlignment = UITextAlignmentCenter;
		
		startingLabelView.backgroundColor = [UIColor grayColor];
		rightwardLabelView.backgroundColor = [UIColor grayColor];
		leftwardLabelView.backgroundColor = [UIColor grayColor];
		
		//startingLabelView.alpha = 0.8f;
		//rightwardLabelView.alpha = 0.8f;
		//leftwardLabelView.alpha = 0.8f;
		
		startingLabelView.font = [UIFont boldSystemFontOfSize:15.0];
		rightwardLabelView.font = [UIFont boldSystemFontOfSize:15.0];
		leftwardLabelView.font = [UIFont boldSystemFontOfSize:15.0];
		
		startingLabelView.textColor = [UIColor whiteColor];
		rightwardLabelView.textColor = [UIColor whiteColor];
		leftwardLabelView.textColor = [UIColor whiteColor];
		
		startingLabelView.shadowColor = [UIColor blackColor];
		rightwardLabelView.shadowColor = [UIColor blackColor];
		leftwardLabelView.shadowColor = [UIColor blackColor];
		
		startingLabelView.shadowOffset = CGSizeMake(0, 1);
		rightwardLabelView.shadowOffset = CGSizeMake(0, 1);
		leftwardLabelView.shadowOffset = CGSizeMake(0, 1);
		
		switch (mode) {
			case MultitaskingGesturesAppNameStart:
				startingLabelView.text = [[self startingApp] displayName];
				rightwardLabelView.text = [[self rightwardApp] displayName];
				leftwardLabelView.text = [[self leftwardApp] displayName];
				break;
			case MultitaskingGesturesAppNameLeft:
				startingLabelView.text = [[self leftwardApp] displayName];
				break;
			case MultitaskingGesturesAppNameRight:
				startingLabelView.text = [[self rightwardApp] displayName];
				break;
		}
		
		if (leftwardLabelView)
			[view addSubview:leftwardLabelView];
		if (rightwardLabelView)
			[view addSubview:rightwardLabelView];
		if (startingLabelView)
			[view addSubview:startingLabelView];
		
		switch ([self orientation]) {
			case UIInterfaceOrientationPortraitUpsideDown:
				startingLabelView.layer.transform = CATransform3DMakeRotation(degreesToRadian(180), 0, 0, 1);
				leftwardLabelView.layer.transform = CATransform3DMakeRotation(degreesToRadian(180), 0, 0, 1);
				rightwardLabelView.layer.transform = CATransform3DMakeRotation(degreesToRadian(180), 0, 0, 1);
				break;
			case UIInterfaceOrientationLandscapeLeft:
				startingLabelView.layer.transform = CATransform3DMakeRotation(degreesToRadian(270), 0, 0, 1);
				leftwardLabelView.layer.transform = CATransform3DMakeRotation(degreesToRadian(270), 0, 0, 1);
				rightwardLabelView.layer.transform = CATransform3DMakeRotation(degreesToRadian(270), 0, 0, 1);
				break;
			case UIInterfaceOrientationLandscapeRight:
				startingLabelView.layer.transform = CATransform3DMakeRotation(degreesToRadian(90), 0, 0, 1);
				leftwardLabelView.layer.transform = CATransform3DMakeRotation(degreesToRadian(90), 0, 0, 1);
				rightwardLabelView.layer.transform = CATransform3DMakeRotation(degreesToRadian(90), 0, 0, 1);
				break;
			default:
			case UIInterfaceOrientationPortrait:
				break;
		}
	}
}

%end

