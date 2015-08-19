//  BSKScreenshotViewController.h
//  See included LICENSE file for the (MIT) license.
//  Created by Marco Arment on 6/28/13.

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@import MessageUI;

@class BSKScreenshotViewController;

@protocol BSKScreenshotViewControllerDelegate

- (void)screenshotViewControllerDidClose:(BSKScreenshotViewController *)screenshotViewController;

@end

@interface BSKScreenshotViewController : UIViewController <MFMailComposeViewControllerDelegate>

- (id)initWithImage:(UIImage *)image annotations:(NSArray *)annotations;

@property (nonatomic, weak) id<BSKScreenshotViewControllerDelegate> delegate;
@property (nonatomic, retain) IBOutlet UIImageView *screenshotImageView;

@end


