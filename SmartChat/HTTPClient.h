#import <Foundation/Foundation.h>

@class Credentials;
@class AFHTTPRequestOperation;
@class YBHALResource;
@class YBHALLink;

@interface HTTPClient : NSObject

@property (nonatomic, strong) Credentials *credentials;

- (NSString *)passphrase;
+ (id)clientWithClient:(HTTPClient *)client credentials:(Credentials *)credentials;
- (id)initWithBaseURL:(NSURL *)baseURL credentials:(Credentials *)credentials;
- (id)initWithClient:(HTTPClient *)client credentials:(Credentials *)credentials;
- (void)getRootResource:(void (^)(YBHALResource *resource))success
                failure:(void (^)(AFHTTPRequestOperation *task, NSError *error))failure;
- (void)authenticate:(YBHALLink *)link
            username:(NSString *)username
            password:(NSString *)password
             success:(void (^)(YBHALResource *resource, NSString *privateKey))success
             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
- (void)registerUser:(YBHALLink *)link
            username:(NSString *)username
            password:(NSString *)password
               email:(NSString *)email
             success:(void (^)(YBHALResource *resource, NSString *privateKey))success
             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void)upload:(YBHALLink *)link
    recipients:(NSArray *)recipients
          file:(UIImage *)file
       overlay:(UIImage *)overlay
           ttl:(NSUInteger)ttl
       success:(void (^)(YBHALResource *resource))success
       failure:(void (^)(AFHTTPRequestOperation *task, NSError *error))failure;

- (void)friends:(YBHALLink *)link
        success:(void (^)(YBHALResource *resource, NSArray *friends))success
        failure:(void (^)(AFHTTPRequestOperation *task, NSError *error))failure;

- (void)search:(YBHALLink *)link
        emails:(NSArray *)emails
        phones:(NSArray *)phones
       success:(void (^)(YBHALResource *resource, NSArray *matches))success
       failure:(void (^)(AFHTTPRequestOperation *task, NSError *error))failure;

- (void)addFriend:(YBHALLink *)link
          success:(void (^)(YBHALResource *resource))success
          failure:(void (^)(AFHTTPRequestOperation *task, NSError *error))failure;

- (void)media:(YBHALLink *)link
      success:(void (^)(YBHALResource *resource, NSArray *chats))success
      failure:(void (^)(AFHTTPRequestOperation *task, NSError *error))failure;

- (void)registerDevice:(YBHALLink *)link
                device:(NSString *)device
               success:(void (^)(YBHALResource *resource))success
               failure:(void (^)(AFHTTPRequestOperation *task, NSError *error))failure;

- (void)file:(YBHALLink *)link
     success:(void (^)(NSURL *filePath, NSString *key, NSString *iv))success
     failure:(void (^)(AFHTTPRequestOperation *task, NSError *error))failure;

- (NSString *)signedPath:(NSString *)path;

- (BOOL)authenticated;

@end