//
//  NHTestTests.m
//  NHTestTests
//
//  Created by Wilson Yuan on 16/1/5.
//  Copyright © 2016年 Wilson-Yuan. All rights reserved.
//

#import <XCTest/XCTest.h>

typedef NS_OPTIONS(NSUInteger, Arrows) {
    ArrowNone      = 0,
    ArrowRight     = 1 << 0,
    ArrowBottom    = 1 << 1,
    ArrowLeft      = 1 << 2,
    ArrowTop       = 1 << 3
};


@interface NHTestTests : XCTestCase

@end

@implementation NHTestTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    Arrows a = (ArrowLeft | ArrowRight);
    if (a & ArrowBottom) {
        NSLog(@"arrow bottom code here");
    }
    
    if (a & ArrowLeft) {
        NSLog(@"arrow left code here");
    }
    
    if (a & ArrowRight) {
        NSLog(@"arrow right code here");
    }
    
    if (a & ArrowTop) {
        NSLog(@"arrow top code here");
    }
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
