
#import <UIKit/UIKit.h>

typedef void (^VoidBlock)(void);

@interface JZRefreshControl : UIView <UIScrollViewDelegate>

/**
 A reference to the UITableView the refresh control will be added to
 */
@property (nonatomic, strong) UITableView *tableView;

/**
 The block that will be called when a pull to refresh is detected
*/
@property (nonatomic, copy) VoidBlock refreshBlock;

/**
 Read-only property which can be used to check the state of the refresh control
 @discussion isRefreshing == YES if refresh is in progress.
 *** Note, the UITableView will have user interaction disabled during refresh.
 */
@property (nonatomic, assign, getter = isRefreshing, readonly) BOOL refreshing;

/**
 This method will be called repeatedly whenever the refresh control is visible on screen.
 @param visibility The vertical percentage of the refresh control that is currently visible (ranges from 0 - 1).
 The visibility value can be used to animate the positioning of elements in the refresh control to prepare them
 for the refresh animation.
 */
- (void)amountOfControlVisible:(CGFloat)visibility;

/**
 This method will be called at every display frame while the refresh is in progress.
 @param delta The amount of time in seconds that has passed since the last time this method was called. If the
 display is running at 60 fps, delta will be ~1/60 of a second every time the method is called.
 @discussion The refresh does not begin until the user releases the UITableView
 */
- (void)refreshingWithDelta:(CGFloat)delta;

/**
 Call this method if you would like to manually trigger a refresh.
 @discussion Upon calling this method, the UITableView will automatically scroll to reveal the refresh control.
 The refreshBlock will then be called and refreshingWithDelta: will begin firing.
 *** Note, amountOfControlVisible: will NOT be called when a manual refresh is triggered via this method.
 */
- (void)beginRefreshing;

/**
 Call this method once you have finished refreshing your content.
 @discussion Upon calling this method, the refresh control will hide itself and user interaction will be enabled
 on the UITableView.
 */
- (void)endRefreshing;

/**
 This method will be called once endRefreshing finishes. In your implementation of reset, you should reposition
 your views as they should be at the beginning of a refresh.
 */
- (void)reset;

@end
