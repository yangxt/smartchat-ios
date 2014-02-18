#import "CameraViewController.h"

#import <HyperBek/HyperBek.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

#import "UIAlertView+NSError.h"
#import "CameraView.h"
#import "CameraController.h"
#import "HTTPClient.h"
#import "Credentials.h"
#import "LoginView.h"
#import "FriendsViewController.h"

@interface CameraViewController ()
@property (nonatomic, strong) HTTPClient *client;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) YBHALResource *resource;
@property (nonatomic, strong) CameraView *cameraView;
@property (nonatomic, strong) CameraController *cameraController;
@property (nonatomic, strong) LoginView *loginView;
@property (nonatomic, strong) NSArray *recipients;
@end

@implementation CameraViewController

- (BOOL)shouldAutorotate
{
    return !self.cameraController.recording;
}

- (id)initWithHTTPClient:(HTTPClient *)client
{
    self = [self init];
    if(self){
        self.client = client;
    }
    return self;
}

- (id)initWithHTTPClient:(HTTPClient *)client resource:(YBHALResource *)resource
{
    self = [self init];
    if(self){
        self.client = client;
        self.resource = resource;
    }
    return self;
}

- (void)loadView
{
    self.cameraView = [[CameraView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.cameraView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.cameraController = [[CameraController alloc] initWithViewController:self camearView:self.cameraView];
    [self.cameraController setupObservers];

    self.loginView = [[LoginView alloc] initWithFrame:self.view.frame];
    [[self.loginView.submitButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *sender) {
        [self authenticate];
    }];

    [RACObserve(self.cameraController, image) subscribeNext:^(UIImage *image){
        if(image){
            [self.client upload:[self.resource linkForRelation:@"http://smartchat.smartlogic.io/relations/media"]
                     recipients:@[@1]
                           file:image
                        overlay:nil
                            ttl:10.0f
                        success:^(YBHALResource *resource) {
                            // The resource here has no use, but we need to update the UI
                        }
                        failure:^(AFHTTPRequestOperation *task, NSError *error) {
                            NSLog(@"error: %@", error);
                        }];
        }
    }];

    if(self.resource){
        // NOTE: Guard with defaults check to see if the device has been registered already
        [self.client registerDevice:[self.resource linkForRelation:@"http://smartchat.smartlogic.io/relations/devices"]
                            success:^(YBHALResource *resource) {
                                // This resource has no use, but the UI should respond if the device cannot be registered
                            }
                            failure:^(AFHTTPRequestOperation *task, NSError *error) {
                                NSLog(@"error: %@", error);
                            }];
    } else {
        [self.client getRootResource:^(YBHALResource *resource) {
            self.resource = resource;

            if (!self.client.authenticated) {
                NSLog(@"we are NOT authenticated");
                [self.loginView presentInView:self.view];
            }

        } failure:^(AFHTTPRequestOperation *task, NSError *error) {
            NSLog(@"error: %@", error);
        }];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    NSLog(@"CameraViewController#didReceiveMemoryWarning");
}

- (void)authenticate
{
    NSString *username = self.loginView.username;
    NSString *password = self.loginView.password;

    __weak CameraViewController *weakSelf = self;
    [self.client authenticate:[self.resource linkForRelation:@"http://smartchat.smartlogic.io/relations/user-sign-in"]
                     username:username
                     password:password
                      success:^(YBHALResource *resource, NSString *privateKey){

                          NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                          [defaults setObject:username forKey:kDefaultsUsername];
                          [defaults setObject:password forKey:kDefaultsPassword];
                          [defaults setObject:privateKey forKey:kDefaultsPrivateKey];
                          [defaults synchronize];

                          Credentials *credentials = [[Credentials alloc] initWithUserDefaults:defaults];
                          HTTPClient *client = [HTTPClient clientWithClient:weakSelf.client credentials:credentials];
                          weakSelf.client = client;

                          [client getRootResource:^(YBHALResource *resource) {
                              weakSelf.resource = resource;

                              [weakSelf registerDeviceIfNecessary];
                              [weakSelf.loginView removeFromView];
                          } failure:^(AFHTTPRequestOperation *task, NSError *error) {
                              [[UIAlertView alertViewWithError:error] show];
                              NSLog(@"error: %@", error);
                          }];
                      }
                      failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                          [[UIAlertView alertViewWithError:error] show];
                          NSLog(@"error: %@", error);
                      }];
}

@end