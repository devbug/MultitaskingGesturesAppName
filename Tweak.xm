#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


#define degreesToRadian(x)		(M_PI*x/180.0)

UILabel *rightwardLabelView = nil;
UILabel *leftwardLabelView = nil;
UILabel *startingLabelView = nil;


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
@end


%hook SBSwitchAppGestureView

- (void)setStartingView:(UIView *)startView {
	if (startingLabelView) {
		[startingLabelView removeFromSuperview];
		[startingLabelView release];
		startingLabelView = nil;
	}
	if (leftwardLabelView) {
		[leftwardLabelView removeFromSuperview];
		[leftwardLabelView release];
		leftwardLabelView = nil;
	}
	if (rightwardLabelView) {
		[rightwardLabelView removeFromSuperview];
		[rightwardLabelView release];
		rightwardLabelView = nil;
	}
	if (startView) {
		CGFloat width = startView.bounds.size.width;
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
		
		startingLabelView = [[UILabel alloc] initWithFrame:startingLabelFrame];
		rightwardLabelView = [[UILabel alloc] initWithFrame:rightwardLabelFrame];
		leftwardLabelView = [[UILabel alloc] initWithFrame:leftwardLabelFrame];
		
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
		
		startingLabelView.text = [[self startingApp] displayName];
		rightwardLabelView.text = [[self rightwardApp] displayName];
		leftwardLabelView.text = [[self leftwardApp] displayName];
		
		[startView addSubview:leftwardLabelView];
		[startView addSubview:rightwardLabelView];
		[startView addSubview:startingLabelView];
		
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
	
	%orig;
}

%end

