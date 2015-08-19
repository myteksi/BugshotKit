//  BSKLogViewController.m
//  See included LICENSE file for the (MIT) license.
//  Created by Marco Arment on 1/17/14.

#import "BSKLogViewController.h"
#import "BugshotKit.h"

@interface BSKLogViewController ()
@property (nonatomic) UIImageView *consoleView;
@property (nonatomic) UITextView *consoleTextView;
@end

static int markerNumber = 0;

@implementation BSKLogViewController

- (instancetype)init
{
    if ( (self = [super init]) ) {
        self.title = @"Debug Log";
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addMarkerButtonTapped:)];
    }
    return self;
}

- (void)addMarkerButtonTapped:(id)sender
{
    [BugshotKit addLogMessage:[NSString stringWithFormat:@"----------- marker #%d -----------", markerNumber]];
    markerNumber++;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIView *console = ([BugshotKit.sharedManager displayConsoleTextInLogViewer] ? self.consoleTextView : self.consoleView);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[c]|" options:0 metrics:nil views:@{ @"c" : console }]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[top][c]|" options:0 metrics:nil views:@{ @"c" : console, @"top" : self.topLayoutGuide }]];
}

- (void)loadView
{
    CGRect frame = UIScreen.mainScreen.applicationFrame;
    frame.origin = CGPointZero;
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    view.autoresizesSubviews = YES;

    if ([BugshotKit.sharedManager displayConsoleTextInLogViewer]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.consoleTextView = [[UITextView alloc] initWithFrame:frame];
        self.consoleTextView.translatesAutoresizingMaskIntoConstraints = NO;
        self.consoleTextView.editable = NO;
        self.consoleTextView.font = [BugshotKit consoleFontWithSize:(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? 13.0f : 9.0f)];
        [view addSubview:self.consoleTextView];
    }
    else {
        self.consoleView = [[UIImageView alloc] initWithFrame:frame];
        self.consoleView.translatesAutoresizingMaskIntoConstraints = NO;
        [view addSubview:self.consoleView];
    }

    self.view = view;
}

@end
