//
//  NSString+Paths.h
//
//  Courtesy to: http://stackoverflow.com/questions/6539273/objective-c-code-to-generate-a-relative-path-given-a-file-and-a-directory

#import <Foundation/Foundation.h>

@interface NSString (Paths)
- (NSString*)stringWithPathRelativeTo:(NSString*)anchorPath;
@end
