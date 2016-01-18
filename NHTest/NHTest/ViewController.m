//
//  ViewController.m
//  NHTest
//
//  Created by Wilson Yuan on 16/1/5.
//  Copyright © 2016年 Wilson-Yuan. All rights reserved.
//

#import "ViewController.h"
#import "RegexKitLite.h"

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
    
    [self howToUseRegex];
    [self howToUseRegexKitLite];
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

- (void)howToUseRegexKitLite

{
    
    NSString *searchString = @"我正在#话题#吃饭@zhangsan 你@lisi 吃了没?";
    
    NSString *regexString = @"@\\w+";
    
    
    
    // 返回所有匹配成功的结果，并存放到一个数组里
    
    NSArray *array = [searchString componentsMatchedByRegex:regexString];
    
    NSLog(@"array:%@",array); // 输出结果: ("@zhangsan","@lisi")
    
    
    
    // 透过传入一个Regex进行字符串的比对，并且会将第一组比对出来的结果以NSArray回传群组
    
    NSArray *array1 = [searchString captureComponentsMatchedByRegex:regexString];
    
    NSLog(@"array1:%@",array1); // 输出结果: ("@zhangsan")
    
    
    
    // 同上者，一样会回传Regex所比对出来的字符串群组，但会回传全部的配对组合
    
    NSArray *array2 = [searchString arrayOfCaptureComponentsMatchedByRegex:regexString];
    
    NSLog(@"array2:%@",array2); // 输出结果: (("@zhangsan"),("@lisi"))
    
    
    
    // 判断字符串是否与Regex配对
    
    BOOL isMatched = [@"@zhangsan" isMatchedByRegex:regexString];
    
    if (isMatched) {
        
        NSLog(@"配对成功");
        
    }
    
    
    
    // 取得配对出来的第一個完整字串
    
    NSString *matchedString1 = [searchString stringByMatching:regexString];
    
    NSLog(@"matchedString1:%@",matchedString1); // 输出结果: @zhangsan
    
    
    
    // 将字符串中与Regex配对的结果进行替换
    
    NSString *replaceString = @"wangwu";
    
    NSString *matchedString2 = [searchString stringByReplacingOccurrencesOfRegex:regexString withString:replaceString];
    
    NSLog(@"matchedString2:%@",matchedString2); // 输出结果: 我正在#话题#吃饭wangwu 你wangwu 吃了没?
    
    
    
    // 如果是NSMutableString，则可以直接替换，并返回替换的次数
    
    NSMutableString *mutSearchString = [NSMutableString stringWithString:@"我正在#话题#吃放@zhangsan 你@lisi 吃了没?"];
    
    NSInteger mutMatchedString2 = [mutSearchString replaceOccurrencesOfRegex:regexString withString:replaceString];
    
    NSLog(@"mutMatchedString2:%ld",mutMatchedString2); // 输出结果: 2
    
    
    
    // 返回一个拆分后的字符串数组
    
    NSArray *array3 = [searchString componentsSeparatedByRegex:regexString];
    
    NSLog(@"array3:%@",array3); // 输出结果: ("我正在#话题#吃饭"," 你"," 吃了没?")
    
}

#pragma mark RegexKitLite的使用总结

/*
 
 RegexKitLite提供的方法都是透过NSString来操作，常用的方法：
 
 1. - (NSArray *)RKL_METHOD_PREPEND(componentsMatchedByRegex):(NSString *)regex
 
 返回所有匹配成功的结果，并存放到一个数组里
 
 
 
 2. - (NSArray *)captureComponentsMatchedByRegex:(NSString *)regex;
 
 这个方法是透过传入一个Regex进行字串的比对，并且会将第一组比对出来的结果以NSArray回传群组。
 
 
 
 3. - (NSArray *)arrayOfCaptureComponentsMatchedByRegex:(NSString *)regex;
 
 這個方法如同上者，一样会回传Regex所比对出来的字串群组，但会回传全部的配对组合。
 
 
 
 4. - (BOOL)isMatchedByRegex:(NSString *)regex;
 
 判断字串是否与Regex配对，在进行资料验证的時候很实用。
 
 
 
 5. - (NSString *)stringByMatching:(NSString *)regex;
 
 这方法则是会回传配对出来的第一個完整字串。
 
 
 
 6. - (NSString *)stringByReplacingOccurrencesOfRegex:(NSString *)regex withString:(NSString *)replacement;
 
 将字串中与Regex配对的结果进行替换。
 
 
 
 7. - (NSInteger)replaceOccurrencesOfRegex:(NSString *)regex withString:(NSString *)replacement
 
 如果是NSMutableString，则可以直接替换，并返回替换的次数
 
 
 
 8. - (NSArray *)componentsSeparatedByRegex:(NSString *)regex
 
 用于拆分，返回一个拆分后的字符串数组
 
 */





//二.正则表达式的使用



- (void)howToUseRegex

{
    
#pragma mark 1.正则表达式规则
    
    
    
    /*-------------------------------1.1普通字符-------------------------------*/
    
    // 字母、数字、汉字、下划线、非特殊定义的标点符号，都是"普通字符"。表达式中的普通字符，在匹配一个字符串的时候，匹配与之相同的一个字符。
    
    
    
    NSString *searchString1_1 = @"abcde";
    
    NSString *regexString1_1 = @"c";
    
    NSString *matchedString1_1 = [searchString1_1 stringByMatching:regexString1_1];
    
    NSLog(@"matchedString1_1:%@",matchedString1_1); // 输出结果: c
    
    
    
    
    
    /*-------------------------------1.2简单的转义字符-------------------------------*/
    
    // 一些不便书写的字符，在前面加 "\",如：\n,\t,\\ 等
    
    
    
    NSString *searchString1_2 = @"abc$de";
    
    // 记住在字符串中“\”需要用“\\”表示
    
    NSString *regexString1_2 = @"\\$d";
    
    NSString *matchedString1_2 = [searchString1_2 stringByMatching:regexString1_2];
    
    NSLog(@"matchedString1_2:%@",matchedString1_2); // 输出结果: $d
    
    
    
    
    
    /*------------------------1.3能够与 '多种字符' 匹配的表达式-------------------------*/
    
    /*
     
     
     
     .     : 匹配除换行符以外的任意字符
     
     
     
     \w    : 匹配字母或数字或下划线或汉字
     
     
     
     \s    : 匹配任意的空白符
     
     
     
     \d    : 匹配数字
     
     
     
     \b    : 匹配单词的开始或结束
     
     
     
     */
    
    NSString *searchString1_3 = @"abc123";
    
    // 正则表达式有一条规则:最先开始的匹配拥有最高的优先权
    
    NSString *regexString1_3 = @"\\d\\d";
    
    NSString *matchedString1_3 = [searchString1_3 stringByMatching:regexString1_3];
    
    NSLog(@"matchedString1_3:%@",matchedString1_3); // 输出结果: 12
    
    
    
    
    
    /*---------------------1.4自定义能够匹配 '多种字符' 的表达式-------------------------*/
    
    // 使用方括号 [ ] 包含一系列字符，能够匹配其中任意一个字符。用 [^ ] 包含一系列字符，则能够匹配其中字符之外的任意一个字符。同样的道理，虽然可以匹配其中任意一个，但是只能是一个，不是多个。[]本身就隐含了“或”的关系，在[]中使用“|”表示“或”的关系是不对的，这样做只是多了一个普通字符“|”，用来匹配“|”字符本身，()也是同样道理。 如:
    
    
    
    /*
     
     
     
     [ab5@]    : 匹配 "a" 或 "b" 或 "5" 或 "@"
     
     
     
     [^abc]    : 匹配 "a","b","c" 之外的任意一个字符
     
     
     
     [f-k]     : 匹配 "f"~"k" 之间的任意一个字母
     
     
     
     [^A-F0-3] : 匹配 "A"~"F","0"~"3" 之外的任意一个字符
     
     
     
     */
    
    NSString *searchString1_4 = @"abc123";
    
    NSString *regexString1_4 = @"[bcd][bcd]";
    
    NSString *matchedString1_4 = [searchString1_4 stringByMatching:regexString1_4];
    
    NSLog(@"matchedString1_4:%@",matchedString1_4); // 输出结果: bc
    
    
    
    
    
    /*---------------------1.5修饰匹配次数的特殊符号------------------------------*/
    
    // 使用表达式再加上修饰匹配次数的特殊符号，那么不用重复书写表达式就可以重复匹配
    
    
    
    /*
     
     
     
     {n}   :  表达式重复n次
     
     
     
     {m,n} :  表达式至少重复m次，最多重复n次
     
     
     
     {m,}  :  表达式至少重复m次
     
     
     
     ?     :  匹配表达式0次或者1次，相当于 {0,1}
     
     
     
     +     :  表达式至少出现1次，相当于 {1,}
     
     
     
     *     :  表达式不出现或出现任意次，相当于 {0,}
     
     
     
     */
    
    NSString *searchString1_5 = @"It costs $12.5";
    
    NSString *regexString1_5 = @"\\d+\\.?\\d";
    
    NSString *matchedString1_5 = [searchString1_5 stringByMatching:regexString1_5];
    
    NSLog(@"matchedString1_5:%@",matchedString1_5); // 输出结果: 12.5
    
    
    
    
    
    /*---------------------1.6其他一些代表抽象意义的特殊符号--------------------------*/
    
    // 一些符号在表达式中代表抽象的特殊意义
    
    
    
    /*
     
     
     
     ^     : 与字符串开始的地方匹配，不匹配任何字符
     
     
     
     $     : 与字符串结束的地方匹配，不匹配任何字符
     
     
     
     \b    : 匹配一个单词边界，也就是单词和空格之间的位置，不匹配任何字符
     
     
     
     */
    
    // 进一步说明："\b" 与 "^" 和 "$" 类似，本身不匹配任何字符，但是它要求它在匹配结果中所处位置的左右两边，其中一边是 "\w" 范围，另一边是 非"\w" 的范围
    
    NSString *searchString1_6 = @"@@@abc";
    
    NSString *regexString1_6 = @".\\b.";
    
    NSString *matchedString1_6 = [searchString1_6 stringByMatching:regexString1_6];
    
    NSLog(@"matchedString1_6:%@",matchedString1_6); // 输出结果: @a
    
    
    
    
    
    
    
    
    
#pragma mark 2.正则表达式中的一些高级规则
    
    
    
    /*---------------------2.1匹配次数中的贪婪与非贪婪--------------------------*/
    
    // 1)在使用修饰匹配次数的特殊符号"{m,n}", "{m,}", "?", "*", "+"可以使同一个表达式能够匹配不同的次数,这种重复匹配不定次数的表达式在匹配过程中，总是尽可能多的匹配。如：
    
    NSString *searchString2_1_1 = @"dxxxdxxxd";
    
    NSString *regexString2_1_1 = @"(d)(\\w+)(d)";
    
    NSString *matchedString2_1_1 = [searchString2_1_1 stringByMatching:regexString2_1_1];
    
    NSLog(@"matchedString2_1_1:%@",matchedString2_1_1); // 输出结果: dxxxdxxxd
    
    
    
    // 2)在修饰匹配次数的特殊符号后再加上一个 "?" 号，则可以使匹配次数不定的表达式尽可能少的匹配,这种匹配原则叫作 "非贪婪" 模式，也叫作 "勉强" 模式
    
    NSString *regexString2_1_2 = @"(d)(\\w+?)(d)";
    
    NSString *matchedString2_1_2 = [searchString2_1_1 stringByMatching:regexString2_1_2];
    
    NSLog(@"matchedString2_1_2:%@",matchedString2_1_2); // 输出结果: dxxxd
    
    
    
    
    
    /*---------------------2.2反向引用--------------------------------------*/
    
    // 使用小括号指定一个子表达式后，匹配这个子表达式的文本(也就是此分组捕获的内容)可以在表达式或其它程序中作进一步的处理。默认情况下，每个分组会自动拥有一个组号，规则是：从左向右，以分组的左括号为标志，第一个出现的分组的组号为1，第二个为2，以此类推
    
    NSString *searchString2_2 = @"go go";
    
    NSString *regexString2_2 = @"\\b(\\w+)\\b\\s+\\1\\b";
    
    NSString *matchedString2_2 = [searchString2_2 stringByMatching:regexString2_2];
    
    NSLog(@"matchedString2_2:%@",matchedString2_2); // 输出结果: go go
    
    
    
    
    
    /*----------------2.3零宽断言-------------------------------------------*/
    
    // 零宽断言用于查找在某些内容(但并不包括这些内容)之前或之后的东西，也就是说它们像\b,^,$那样用于指定一个位置，这个位置应该满足一定的条件(即断言)，因此它们也被称为零宽断言
    
    /*
     
     
     
     1)捕获
     
     (exp)         : 匹配exp,并捕获文本到自动命名的组里
     
     (?<name>exp)  : 匹配exp,并捕获文本到名称为name的组里，也可以写成(?'name'exp)
     
     (?:exp)       : 匹配exp,不捕获匹配的文本，也不给此分组分配组号零宽断言,可节约性能，提高效率
     
     
     
     2)零宽断言
     
     (?=exp)       : 匹配exp前面的位置
     
     (?<=exp)      : 匹配exp后面的位置
     
     (?!exp)       : 匹配后面跟的不是exp的位置
     
     (?<!exp)      : 匹配前面不是exp的位置注释(?#comment)这种类型的分组不对正则表达式的处理产生任何影响，用于提供注释让人阅读
     
     
     
     */
    
    NSString *searchString2_3 = @"I'm singing while you're dancing.";
    
    NSString *regexString2_3 = @"\\b\\w+(?=ing\\b)";
    
    NSArray *matchedString2_3 = [searchString2_3 componentsMatchedByRegex:regexString2_3];
    
    NSLog(@"matchedString2_3:%@",matchedString2_3); // 输出结果: (sing,danc)
    
    
    
    
    
    
    
    // 3.其他通用规则
    
    /*----------------3.1------------------------------------------*/
    
    // 表达式中，可以使用 "\xXX" 和 "\uXXXX" 表示一个字符（"X" 表示一个十六进制数）
    
    /*
     
     
     
     \xXX    : 编号在 0 ~ 255 范围的字符，比如：空格可以使用 "\x20" 表示
     
     
     
     \uXXXX  : 任何字符可以使用 "\u" 再加上其编号的4位十六进制数表示，比如："\u4E2D"
     
     
     
     */
    
    
    
    /*----------------3.2------------------------------------------*/
    
    // 在表达式 "\s"，"\d"，"\w"，"\b" 表示特殊意义的同时，对应的大写字母表示相反的意义
    
    /*
     
     
     
     \S     : 匹配所有非空白字符（"\s" 可匹配各个空白字符）
     
     
     
     \D     : 匹配所有的非数字字符
     
     
     
     \W     : 匹配所有的字母、数字、下划线以外的字符
     
     
     
     \B     : 匹配非单词边界，即左右两边都是 "\w" 范围或者左右两边都不是 "\w" 范围时的字符缝隙
     
     
     
     */
    
    
    
    /*----------------3.3------------------------------------------*/
    
    // 在表达式中有特殊意义，需要添加 "\" 才能匹配该字符本身的字符汇总
    
    /*
     
     
     
     ^     : 匹配输入字符串的开始位置。要匹配 "^" 字符本身，请使用 "\^"
     
     
     
     $     : 匹配输入字符串的结尾位置。要匹配 "$" 字符本身，请使用 "\$"
     
     
     
     ( )   : 标记一个子表达式的开始和结束位置。要匹配小括号，请使用 "\(" 和 "\)"
     
     
     
     [ ]   : 用来自定义能够匹配 '多种字符' 的表达式。要匹配中括号，请使用 "\[" 和 "\]"
     
     
     
     { }   : 修饰匹配次数的符号。要匹配大括号，请使用 "\{" 和 "\}"
     
     
     
     .     : 匹配除了换行符（\n）以外的任意一个字符。要匹配小数点本身，请使用 "\."
     
     
     
     ?     : 修饰匹配次数为 0 次或 1 次。要匹配 "?" 字符本身，请使用 "\?"
     
     
     
     +     : 修饰匹配次数为至少 1 次。要匹配 "+" 字符本身，请使用 "\+"
     
     
     
     *     : 修饰匹配次数为 0 次或任意次。要匹配 "*" 字符本身，请使用 "\*"
     
     
     
     |     : 左右两边表达式之间 "或" 关系。匹配 "|" 本身，请使用 "\|"
     
     
     
     "     : 用在不带@的字符串中时，用\"来进行转义，用在带@的字符串中时，用""来进行转义
     
     
     
     注意:大部分在正则中有特殊意义、在匹配其本身时需转义的字符，在[]内是不需要转义的。必须转义的只有“\”、“[”和“]”，而“^”出现在[]开始位置，“-”前后构成范围区间时，需要转义，出现在其它位置不需要转义，如:[\^ .$^{\[(|)*+?\\-]
     
     
     
     */
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
