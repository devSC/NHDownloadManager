//
//  NSString+UUID.m
//  Being
//
//  Created by xiaofeng on 15/10/15.
//  Copyright © 2015年 Being Inc. All rights reserved.
//

#import "NSString+UUID.h"

@implementation NSString (UUID)

+ (NSString*)uuidStr {
    CFUUIDRef newUniqueID = CFUUIDCreate(kCFAllocatorDefault);
    CFStringRef newUniqueIDString = CFUUIDCreateString(kCFAllocatorDefault, newUniqueID);
    NSString *guid = [(__bridge_transfer NSString *)newUniqueIDString copy];

    CFRelease(newUniqueID);
    
    return([guid lowercaseString]);
}

@end
