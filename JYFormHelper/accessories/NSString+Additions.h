//
//  NSString+Additions.h
//  Addtions
//
//  Created by Hilen on 12/20/13.
//  Copyright (c) 2013 Yunyouhulian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CLLocation.h>
#import <UIKit/UIKit.h>

@interface NSString (Additions)
@property (nonatomic, readonly) NSString *md5Hash;
@property (nonatomic, readonly) NSString *mdPhoneNo;
@property (nonatomic, readonly) NSString *clearThumbnail;

- (NSString*)removeFloatAllZero;

- (NSString *)MD5;
+ (NSString *)GetUUID; //获取唯一id
- (NSComparisonResult)versionStringCompare:(NSString *)other;
- (BOOL)isWhitespaceAndNewlines;
- (BOOL)isEmptyOrWhitespace;
- (BOOL)isEmail;
- (BOOL)isIncludeSpecialCharact;//是否包含特殊字符v3.0.2
- (BOOL)isLegalPrice;
- (BOOL)isNumber;
- (BOOL)isLegalName;
- (BOOL)isOnlyContainNumberOrLatter;
- (unichar)intToHex:(int)n;
- (BOOL)isCharSafe:(unichar)ch;
- (BOOL)containString:(NSString *)string;
- (NSString *)removeSpace;
- (NSString *)replaceSpaceWithUnderline;
- (NSString *)replaceDotWithUnderline;
+ (NSString *)replaceStringsFromDictionary:(NSDictionary *)dict stringName:(NSString *)name;
- (NSString *)encodeString;
- (NSString *)trimmedWhitespaceString;
- (NSString *)trimmedWhitespaceAndNewlineString;
// 日期格式转换
-(NSString *)dateFromStringWithOriginalFormat:(NSString*)originalFormat targetFormat:(NSString *)targetFormat;
// 字符串限定十个 多出部分...
-(NSString *)formatStringLimit;
// 数字字符串按每四位切割中间填充空格 
+ (NSString *)cutStringByRule:(NSString *)oldString;

/**
 *  在每n位插入指定字符串
 *
 *  @param aString  插入字符串
 *  @param indexs   间隔位数
 *
 *  @return 结果字符串
 */
- (NSString *)insertString:(NSString *)aString forEachIndexs:(NSUInteger)indexs;


+ (NSDate *)dateFromString:(NSString *)string;
+ (NSString *)convertDictionaryToJSON:(NSDictionary *)jsonObject;


- (NSDictionary *)parseURLParams;
- (NSDictionary *)toDictionary;
- (NSString *)getValueStringFromUrlForParam:(NSString *)param;
- (NSDate *)date;

- (NSString *)StringFromTimestamp;
- (NSString *)StringFromUTS;
- (NSString *)shortDateStringFromUTS;
- (BOOL)isPureFloat;
- (CGFloat)heightOfString:(NSString *)text textFontSize:(float)size widthSize:(float)width; //计算文字高度

/**
 *  计算文字高度 根据字体 宽度
 *
 *  @param text
 *  @param font
 *  @param width
 *
 *  @return
 */

//- (CGFloat)stringHeight:(NSString *)text textFontSize:(UIFont *)font widthSize:(float)width; //计算文字高度
- (CGFloat)stringHeightFontSize:(UIFont *)font widthSize:(float)width;
//- (CGFloat)widthOfString:(NSString *)string withFont:(UIFont *)font;
- (CGFloat)widthOfStringFont:(UIFont *)font;

///计算文字高度 含有 间距
- (CGFloat)stringHeightFontSize:(UIFont *)font widthSize:(float)width lineSpace:(CGFloat)space;

- (NSMutableAttributedString *)getAttributedBySpace:(int)space;
- (NSString *)replace:(NSString *)source to:(NSString *)str;
+ (NSString *)getMacAddress;
- (BOOL)isContainStr:(NSString *)str;
//获取label数字尺寸
- (CGSize)getSizeWithFont:(UIFont *)font Size:(CGSize)size LineSpace:(int)space;
- (NSString *)trim;// 去掉两端空格
- (NSString *)trimAll;//去掉所有空格
- (NSString *)removeLineSpace;//去掉多余换行符

- (NSString *)toMoney;
- (NSInteger)getNumberByString;
- (NSNumber *)toNumberStyle;

+(NSString *) jsonStringWithDictionary:(NSDictionary *)dictionary;
+(NSString *) jsonStringWithArray:(NSArray *)array;
+(NSString *) jsonStringWithString:(NSString *) string;
+(NSString *) jsonStringWithObject:(id) object;

#pragma mark - 正则相关

- (BOOL)isChinese;//判断是否是纯汉字
- (BOOL)includeChinese;//判断是否含有汉字
- (BOOL)isValidateRealName;
- (BOOL)isValidateByRegex:(NSString *)regex;
//手机号分服务商
- (BOOL)isMobileNumberClassification;

// 校验身份证号只能为字母和数字 yes 符合  NO 不符合
-(BOOL)isValidateIDNo;
//  0-9纯数字
-(BOOL)isValidateNum;

/**时间戳转字符创*/
- (NSString *)getTimeDateWithFormat:(NSString *)formatString;

+ (BOOL)stringContainsEmoji:(NSString *)string;
//是否是系统自带九宫格输入 yes-是 no-不是
+ (BOOL)isNineKeyBoard:(NSString *)string;
//判断第三方键盘中的表情
+ (BOOL)hasEmoji:(NSString*)string;
//去除表情
+ (NSString *)disableEmoji:(NSString *)text;

@end
