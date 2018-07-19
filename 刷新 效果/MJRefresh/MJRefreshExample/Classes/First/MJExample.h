
#import <Foundation/Foundation.h>

@interface MJExample : NSObject
@property (copy, nonatomic) NSString *header;//section标题
@property (strong, nonatomic) NSArray *titles;//cell标题
@property (strong, nonatomic) NSArray *methods;//方法
@property (assign, nonatomic) Class vcClass;//类
@end
