//
//  ViewController.m
//  NHTest
//
//  Created by Wilson Yuan on 16/1/5.
//  Copyright © 2016年 Wilson-Yuan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) NSDictionary *areaDic;
@property (strong, nonatomic) NSArray *province;
@property (strong, nonatomic) NSArray *city;
@property (strong, nonatomic) NSArray *district;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self test];
}

- (void)test {
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *plistPath = [bundle pathForResource:@"area" ofType:@"plist"];
    self.areaDic = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    
    //
    NSString *gaodeList = [bundle pathForResource:@"cityPlist" ofType:@"plist"];
    NSMutableArray *gao_array = [NSMutableArray arrayWithArray:[[NSArray alloc] initWithContentsOfFile:gaodeList]];

    //获得所有省份
    NSArray *components = [self.areaDic allKeys];
    NSArray *sortedArray = [components sortedArrayUsingComparator: ^(id obj1, id obj2) {
        
        if ([obj1 integerValue] > [obj2 integerValue]) {
            return NSOrderedDescending;
        }
        
        if ([obj1 integerValue] < [obj2 integerValue]) {
            return NSOrderedAscending;
        }
        return NSOrderedSame;
    }];
    
    NSMutableArray *provinceTmp = [[NSMutableArray alloc] init];
    for (int i=0; i<[sortedArray count]; i++) {
        NSString *index = [sortedArray objectAtIndex:i];
        NSArray *tmp = [[self.areaDic objectForKey: index] allKeys];
        [provinceTmp addObject: [tmp objectAtIndex:0]];
    }
    //所有省份
    self.province = [[NSArray alloc] initWithArray: provinceTmp];
  
    NSMutableArray *mutalArray = [NSMutableArray array];
    NSMutableDictionary *city_Dic = [NSMutableDictionary dictionary];

    for (int i = 0; i < self.province.count; i ++) {

        NSString *index = [sortedArray objectAtIndex:i]; ///选取某个省份 0

        NSString *selectedProvinceName = [self.province objectAtIndex:i]; //当前省份 index 如: 北京

        //当前省份信息 里面包含了下一级和下下一级的信息
        NSDictionary *provinceInfo = [self.areaDic objectForKey:index];

        //选取了北京, 则北京的下一级信息
        NSDictionary *dic = [provinceInfo objectForKey:selectedProvinceName];

        //市的index 0
        NSArray *cityKeyArray = [dic allKeys];

        for (int j = 0; j < cityKeyArray.count; j ++) {

            NSDictionary *cityDic = [dic objectForKey:[cityKeyArray objectAtIndex:j]];
            NSArray *cityArray = [[NSArray alloc] initWithArray:[cityDic allKeys]];
            //市名称 
            NSString *selectedCity = [cityArray objectAtIndex:0];
            //
            
            __block NSString *cityCode = nil;
            //寻找code
            [gao_array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSString *cityName = obj[@"name"];
                if ([selectedCity containsString:cityName]) {
                    cityCode = obj[@"code"];
                    [gao_array removeObject:obj];
//                    NSLog(@"%@, sele: %@, citycode: %@", cityName, selectedCity, cityCode);
                    
                    *stop = YES;
                }
            }];
            if ([selectedCity containsString:@"济源"]) {
                cityCode = @"1391";
            }
            else if ([selectedCity containsString:@"香港"] ||
                     [selectedCity containsString:@"澳门"]) {
                cityCode = @"1852";
            }
            else if ([selectedCity containsString:@"塔城"]) {
                cityCode = @"0901";
            }
            else if ([selectedCity containsString:@"阿勒泰"]) {
                cityCode = @"0906";
            }
            
            NSArray<NSString *> *districtArray = cityDic[selectedCity];
            
            [districtArray enumerateObjectsUsingBlock:^(NSString * _Nonnull district, NSUInteger idx, BOOL * _Nonnull stop) {
                //
                if (cityCode) {
                    NSDictionary *dictionary = @{@"info" : cityDic,
                                                 @"province_index" : @(i).stringValue,
                                                 @"city_index" : @(j).stringValue,
                                                 @"district_index" : @(idx).stringValue,
                                                 @"city_code" : cityCode};
                    [city_Dic setObject:dictionary forKey:district];
                    //区
                    NSLog(@"%@", dictionary);
                }
                
            }];
        }
    }
    NSDictionary *detailInfo = city_Dic;
    
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [documentPath stringByAppendingPathComponent:@"city_info.plist"];
    if ([city_Dic writeToFile:filePath atomically:YES]) {
        NSLog(@"Success: %@", filePath);
    }
    
    NSLog(@"%@", detailInfo[@"岐山县"]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
