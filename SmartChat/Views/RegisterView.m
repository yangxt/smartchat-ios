#import "RegisterView.h"

@interface RegisterView ()

@property (nonatomic, strong) UITextField *usernameField;
@property (nonatomic, strong) UITextField *passwordField;
@property (nonatomic, strong) UITextField *passwordConfirmationField;
@property (nonatomic, strong) UITextField *emailField;

@end

@implementation RegisterView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        self.backgroundColor = [UIColor whiteColor];

        self.emailField = [[UITextField alloc] init];
        self.emailField.translatesAutoresizingMaskIntoConstraints = NO;
        self.emailField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        self.emailField.borderStyle = UITextBorderStyleRoundedRect;
        self.emailField.placeholder = NSLocalizedString(@"authentication: email", nil);
        self.emailField.accessibilityLabel = NSLocalizedString(@"authentication: email", nil);
        self.emailField.keyboardType = UIKeyboardTypeEmailAddress;
        self.emailField.spellCheckingType = UITextSpellCheckingTypeNo;

        self.usernameField = [[UITextField alloc] init];
        self.usernameField.translatesAutoresizingMaskIntoConstraints = NO;
        self.usernameField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        self.usernameField.borderStyle = UITextBorderStyleRoundedRect;
        self.usernameField.placeholder = NSLocalizedString(@"authentication: username", nil);
        self.usernameField.accessibilityLabel = NSLocalizedString(@"authentication: username", nil);
        self.usernameField.keyboardType = UIKeyboardTypeAlphabet;
        self.usernameField.spellCheckingType = UITextSpellCheckingTypeNo;

        self.passwordField = [[UITextField alloc] init];
        self.passwordField.translatesAutoresizingMaskIntoConstraints = NO;
        self.passwordField.secureTextEntry = YES;
        self.passwordField.borderStyle = UITextBorderStyleRoundedRect;
        self.passwordField.placeholder = NSLocalizedString(@"authentication: password", nil);
        self.passwordField.accessibilityLabel = NSLocalizedString(@"authentication: password", nil);
        self.passwordField.keyboardType = UIKeyboardTypeAlphabet;

        self.passwordConfirmationField = [[UITextField alloc] init];
        self.passwordConfirmationField.translatesAutoresizingMaskIntoConstraints = NO;
        self.passwordConfirmationField.secureTextEntry = YES;
        self.passwordConfirmationField.borderStyle = UITextBorderStyleRoundedRect;
        self.passwordConfirmationField.placeholder = NSLocalizedString(@"authentication: confirm password", nil);
        self.passwordConfirmationField.accessibilityLabel = NSLocalizedString(@"authentication: confirm password", nil);
        self.passwordConfirmationField.keyboardType = UIKeyboardTypeAlphabet;

        self.submitButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.submitButton.translatesAutoresizingMaskIntoConstraints = NO;
        self.submitButton.backgroundColor = [UIColor colorWithRed:119/255.0f green:205/255.0f blue:117/255.0f alpha:1.0f];
        [self.submitButton setTitle:NSLocalizedString(@"authentication: submit", nil) forState:UIControlStateNormal];
        [self.submitButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        self.signInButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.signInButton.translatesAutoresizingMaskIntoConstraints = NO;
        self.signInButton.backgroundColor = [UIColor colorWithRed:150/255.0f green:150/255.0f blue:150/255.0f alpha:1.0f];
        [self.signInButton setTitle:NSLocalizedString(@"authentication: login", nil) forState:UIControlStateNormal];
        [self.signInButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

        [self addSubview:self.emailField];
        [self addSubview:self.usernameField];
        [self addSubview:self.passwordField];
        [self addSubview:self.passwordConfirmationField];
        [self addSubview:self.submitButton];
        [self addSubview:self.signInButton];

    }
    return self;
}

#pragma mark - UIView

- (void)layoutSubviews
{
    NSDictionary *views = @{
                            @"superview": self,
                            @"emailField": self.emailField,
                            @"usernameField": self.usernameField,
                            @"passwordField": self.passwordField,
                            @"passwordConfirmationField": self.passwordConfirmationField,
                            @"submitButton": self.submitButton,
                            @"signInButton": self.signInButton
                            };

    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-88-[emailField(31)]-[usernameField(31)]-[passwordField(31)]-[passwordConfirmationField(31)]-[submitButton(44)]-[signInButton(44)]"
                                                                 options:NSLayoutFormatAlignAllCenterX
                                                                 metrics:nil
                                                                   views:views]];

    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.emailField
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0f
                                                      constant:0.0f]];

    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[emailField(200)]"
                                                                 options:NSLayoutFormatAlignAllCenterY
                                                                 metrics:nil
                                                                   views:views]];

    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[usernameField(200)]"
                                                                 options:NSLayoutFormatAlignAllCenterY
                                                                 metrics:nil
                                                                   views:views]];

    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[passwordField(200)]"
                                                                 options:NSLayoutFormatAlignAllCenterY
                                                                 metrics:nil
                                                                   views:views]];

    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[passwordConfirmationField(200)]"
                                                                 options:NSLayoutFormatAlignAllCenterY
                                                                 metrics:nil
                                                                   views:views]];

    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[submitButton(200)]"
                                                                 options:NSLayoutFormatAlignAllCenterY
                                                                 metrics:nil
                                                                   views:views]];

    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[signInButton(200)]"
                                                                 options:NSLayoutFormatAlignAllCenterY
                                                                 metrics:nil
                                                                   views:views]];
    [super layoutSubviews];
}

#pragma mark - properties

- (NSString *)username
{
    return self.usernameField.text;
}

- (NSString *)password
{
    return self.passwordField.text;
}

- (NSString *)passwordConfirmation
{
    return self.passwordConfirmationField.text;
}

- (NSString *)email
{
    return self.emailField.text;
}


@end
