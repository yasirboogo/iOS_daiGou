// The MIT License (MIT)
//


@import UIKit;

FOUNDATION_EXPORT double UITextView_PlaceholderVersionNumber;
FOUNDATION_EXPORT const unsigned char UITextView_PlaceholderVersionString[];

@interface UITextView (Placeholder)

@property (nonatomic, readonly) UILabel *placeholderLabel;

@property (nonatomic, strong) IBInspectable NSString *placeholder;
@property (nonatomic, strong) IBInspectable UIColor *placeholderColor;
@property (nonatomic, strong) IBInspectable UIFont *placeholderFont;

@property (nonatomic, strong) NSAttributedString *attributedPlaceholder;

+ (UIColor *)defaultPlaceholderColor;

@end
