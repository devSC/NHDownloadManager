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
    
//    [self test];
    [self produceWeChatEmoji];
}


- (void)produceWeChatEmoji {
    
    NSArray *emojis = @[
                        @{@"name" : @"Expression_1",
                          @"encode" : @"[微笑]"},
                        @{@"name" : @"Expression_2",
                          @"encode" : @"[撇嘴]"},
                        @{@"name" : @"Expression_3",
                          @"encode" : @"[色]"},
                        @{@"name" : @"Expression_4",
                          @"encode" : @"[发呆]"},
                        @{@"name" : @"Expression_5",
                          @"encode" : @"[得意]"},
                        @{@"name" : @"Expression_6",
                          @"encode" : @"[流泪]"},
                        @{@"name" : @"Expression_7",
                          @"encode" : @"[害羞]"},
                        @{@"name" : @"Expression_8",
                          @"encode" : @"[闭嘴]"},
                        @{@"name" : @"Expression_9",
                          @"encode" : @"[睡]"},
                        @{@"name" : @"Expression_10",
                          @"encode" : @"[大哭]"},
                        @{@"name" : @"Expression_11",
                          @"encode" : @"[尴尬]"},
                        @{@"name" : @"Expression_12",
                          @"encode" : @"[发怒]"},
                        @{@"name" : @"Expression_13",
                          @"encode" : @"[调皮]"},
                        @{@"name" : @"Expression_14",
                          @"encode" : @"[呲牙]"},
                        @{@"name" : @"Expression_15",
                          @"encode" : @"[惊讶]"},
                        @{@"name" : @"Expression_16",
                          @"encode" : @"[难过]"},
                        @{@"name" : @"Expression_17",
                          @"encode" : @"[酷]"},
                        @{@"name" : @"Expression_18",
                          @"encode" : @"[冷汗]"},
                        @{@"name" : @"Expression_19",
                          @"encode" : @"[抓狂]"},
                        @{@"name" : @"Expression_20",
                          @"encode" : @"[吐]"},
                        @{@"name" : @"Expression_21",
                          @"encode" : @"[偷笑]"},
                        @{@"name" : @"Expression_22",
                          @"encode" : @"[愉快]"},
                        @{@"name" : @"Expression_23",
                          @"encode" : @"[白眼]"},
                        @{@"name" : @"Expression_24",
                          @"encode" : @"[傲慢]"},
                        @{@"name" : @"Expression_25",
                          @"encode" : @"[饥饿]"},
                        @{@"name" : @"Expression_26",
                          @"encode" : @"[困]"},
                        @{@"name" : @"Expression_27",
                          @"encode" : @"[惊恐]"},
                        @{@"name" : @"Expression_28",
                          @"encode" : @"[流汗]"},
                        @{@"name" : @"Expression_29",
                          @"encode" : @"[憨笑]"},
                        @{@"name" : @"Expression_30",
                          @"encode" : @"[悠闲]"},
                        @{@"name" : @"Expression_31",
                          @"encode" : @"[奋斗]"},
                        @{@"name" : @"Expression_32",
                          @"encode" : @"[咒骂]"},
                        @{@"name" : @"Expression_33",
                          @"encode" : @"[疑问]"},
                        @{@"name" : @"Expression_34",
                          @"encode" : @"[嘘]"},
                        @{@"name" : @"Expression_35",
                          @"encode" : @"[晕]"},
                        @{@"name" : @"Expression_36",
                          @"encode" : @"[疯了]"},
                        @{@"name" : @"Expression_37",
                          @"encode" : @"[衰]"},
                        @{@"name" : @"Expression_38",
                          @"encode" : @"[骷髅]"},
                        @{@"name" : @"Expression_39",
                          @"encode" : @"[敲打]"},
                        @{@"name" : @"Expression_40",
                          @"encode" : @"[再见]"},
                        @{@"name" : @"Expression_41",
                          @"encode" : @"[擦汗]"},
                        @{@"name" : @"Expression_42",
                          @"encode" : @"[抠鼻]"},
                        @{@"name" : @"Expression_43",
                          @"encode" : @"[鼓掌]"},
                        @{@"name" : @"Expression_44",
                          @"encode" : @"[糗大了]"},
                        @{@"name" : @"Expression_45",
                          @"encode" : @"[坏笑]"},
                        @{@"name" : @"Expression_46",
                          @"encode" : @"[左哼哼]"},
                        @{@"name" : @"Expression_47",
                          @"encode" : @"[右哼哼]"},
                        @{@"name" : @"Expression_48",
                          @"encode" : @"[哈欠]"},
                        @{@"name" : @"Expression_49",
                          @"encode" : @"[鄙视]"},
                        @{@"name" : @"Expression_50",
                          @"encode" : @"[委屈]"},
                        @{@"name" : @"Expression_51",
                          @"encode" : @"[快哭了]"},
                        @{@"name" : @"Expression_52",
                          @"encode" : @"[阴险]"},
                        @{@"name" : @"Expression_53",
                          @"encode" : @"[亲亲]"},
                        @{@"name" : @"Expression_54",
                          @"encode" : @"[吓]"},
                        @{@"name" : @"Expression_55",
                          @"encode" : @"[可怜]"},
                        @{@"name" : @"Expression_56",
                          @"encode" : @"[菜刀]"},
                        @{@"name" : @"Expression_57",
                          @"encode" : @"[西瓜]"},
                        @{@"name" : @"Expression_58",
                          @"encode" : @"[啤酒]"},
                        @{@"name" : @"Expression_59",
                          @"encode" : @"[篮球]"},
                        @{@"name" : @"Expression_60",
                          @"encode" : @"[乒乓]"},
                        @{@"name" : @"Expression_61",
                          @"encode" : @"[咖啡]"},
                        @{@"name" : @"Expression_62",
                          @"encode" : @"[饭]"},
                        @{@"name" : @"Expression_63",
                          @"encode" : @"[猪头]"},
                        @{@"name" : @"Expression_64",
                          @"encode" : @"[玫瑰]"},
                        @{@"name" : @"Expression_65",
                          @"encode" : @"[凋谢]"},
                        @{@"name" : @"Expression_66",
                          @"encode" : @"[嘴唇]"},
                        @{@"name" : @"Expression_67",
                          @"encode" : @"[爱心]"},
                        @{@"name" : @"Expression_68",
                          @"encode" : @"[心醉]"},
                        @{@"name" : @"Expression_69",
                          @"encode" : @"[蛋糕]"},
                        @{@"name" : @"Expression_70",
                          @"encode" : @"[闪电]"},
                        @{@"name" : @"Expression_71",
                          @"encode" : @"[炸弹]"},
                        @{@"name" : @"Expression_72",
                          @"encode" : @"[刀]"},
                        @{@"name" : @"Expression_73",
                          @"encode" : @"[足球]"},
                        @{@"name" : @"Expression_74",
                          @"encode" : @"[瓢虫]"},
                        @{@"name" : @"Expression_75",
                          @"encode" : @"[便便]"},
                        @{@"name" : @"Expression_76",
                          @"encode" : @"[月亮]"},
                        @{@"name" : @"Expression_77",
                          @"encode" : @"[太阳]"},
                        @{@"name" : @"Expression_78",
                          @"encode" : @"[礼物]"},
                        @{@"name" : @"Expression_79",
                          @"encode" : @"[拥抱]"},
                        @{@"name" : @"Expression_80",
                          @"encode" : @"[强]"},
                        
                        @{@"name" : @"Expression_81",
                          @"encode" : @"[弱]"},
                        @{@"name" : @"Expression_82",
                          @"encode" : @"[捂手]"},
                        @{@"name" : @"Expression_83",
                          @"encode" : @"[胜利]"},
                        @{@"name" : @"Expression_84",
                          @"encode" : @"[抱拳]"},
                        @{@"name" : @"Expression_85",
                          @"encode" : @"[勾引]"},
                        @{@"name" : @"Expression_86",
                          @"encode" : @"[拳头]"},
                        @{@"name" : @"Expression_87",
                          @"encode" : @"[差劲]"},
                        @{@"name" : @"Expression_88",
                          @"encode" : @"[爱你]"},
                        @{@"name" : @"Expression_89",
                          @"encode" : @"[NO]"},
                        @{@"name" : @"Expression_90",
                          @"encode" : @"[OK]"},
                        
                        @{@"name" : @"Expression_91",
                          @"encode" : @"[爱情]"},
                        @{@"name" : @"Expression_92",
                          @"encode" : @"[飞吻]"},
                        @{@"name" : @"Expression_93",
                          @"encode" : @"[跳跳]"},
                        @{@"name" : @"Expression_94",
                          @"encode" : @"[发抖]"},
                        @{@"name" : @"Expression_95",
                          @"encode" : @"[怄火]"},
                        @{@"name" : @"Expression_96",
                          @"encode" : @"[转圈]"},
                        @{@"name" : @"Expression_97",
                          @"encode" : @"[磕头]"},
                        @{@"name" : @"Expression_98",
                          @"encode" : @"[回头]"},
                        @{@"name" : @"Expression_99",
                          @"encode" : @"[跳绳]"},
                        @{@"name" : @"Expression_100",
                          @"encode" : @"[投降]"}
                        ];
    
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [documentPath stringByAppendingPathComponent:@"wechatemoji.plist"];
    if ([emojis writeToFile:filePath atomically:YES]) {
        NSLog(@"Success: %@", filePath);
    }
    
    
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
        
        NSArray *sortedArray = [cityKeyArray sortedArrayUsingComparator: ^(id obj1, id obj2) {
            
            if ([obj1 integerValue] > [obj2 integerValue]) {
                return (NSComparisonResult)NSOrderedDescending;//递减
            }
            
            if ([obj1 integerValue] < [obj2 integerValue]) {
                return (NSComparisonResult)NSOrderedAscending;//上升
            }
            return (NSComparisonResult)NSOrderedSame;
        }];
//        
//        NSMutableArray *array = [[NSMutableArray alloc] init];
//        for (int i=0; i<[sortedArray count]; i++) {
//            NSString *index = [sortedArray objectAtIndex:i];
//            NSArray *temp = [[dic objectForKey: index] allKeys];
//            [array addObject: [temp objectAtIndex:0]];
//        }

        for (int j = 0; j < sortedArray.count; j ++) {

            NSDictionary *cityDic = [dic objectForKey:[sortedArray objectAtIndex:j]];
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
            
            if (cityCode) {
                NSArray<NSString *> *districtArray = cityDic[selectedCity];
                
                NSMutableDictionary *districtDic = [NSMutableDictionary dictionary];
                [districtArray enumerateObjectsUsingBlock:^(NSString * _Nonnull district, NSUInteger idx, BOOL * _Nonnull stop) {
                    //
                    NSDictionary *dictionary = @{@"info" : cityDic,
                                                 @"province_index" : @(i).stringValue,
                                                 @"city_index" : @(j).stringValue,
                                                 @"district_index" : @(idx).stringValue,
                                                 };
                    //                                                 @"city_code" : cityCode};
                    [districtDic setObject:dictionary forKey:district];
                    //区//                    NSLog(@"%@", dictionary);
                    NSLog(@"省:%@, city: %@, 县区: %@", selectedProvinceName, selectedCity, district);
                }];
                [city_Dic setObject:districtDic forKey:cityCode];
            }
        }
    }
    NSDictionary *detailInfo = city_Dic;
    
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [documentPath stringByAppendingPathComponent:@"city_info.plist"];
    if ([city_Dic writeToFile:filePath atomically:YES]) {
        NSLog(@"Success: %@", filePath);
    }
    
    NSLog(@"%@", detailInfo[@"0917"]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
