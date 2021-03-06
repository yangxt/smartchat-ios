#import <UIKit/UIKit.h>

@class HTTPClient;
@class YBHALResource;

@interface FriendsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *recipients;

- (id)initWithHTTPClient:(HTTPClient *)client resource:(YBHALResource *)resource;
- (id)initWithHTTPClient:(HTTPClient *)client resource:(YBHALResource *)resource image:(UIImage *)image;

@end
