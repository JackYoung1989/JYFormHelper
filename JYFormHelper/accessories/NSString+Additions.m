//
//  NSString+Additions.m
//  Addtions
//
//  Created by Hilen on 12/20/13.
//  Copyright (c) 2013 Yunyouhulian. All rights reserved.
//

#import "NSString+Additions.h"
#include <sys/socket.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#import <CommonCrypto/CommonDigest.h>


@implementation NSString (Additions)

- (NSString*)removeFloatAllZero{
    NSString * outNumber = [NSString stringWithFormat:@"%@",@(self.floatValue)];
    return outNumber;
}

- (NSString*)MD5
{
    // Create pointer to the string as UTF8
    const char *ptr = [self UTF8String];
    
    // Create byte array of unsigned chars
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    
    // Create 16 bytes MD5 hash value, store in buffer
    CC_MD5(ptr, (unsigned int)strlen(ptr), md5Buffer);
    
    // Convert unsigned char buffer to NSString of hex values
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x",md5Buffer[i]];
    
    return output;
}

+ (NSString *)cutStringByRule:(NSString *)oldString {
    NSMutableString *oldMutableStr = [NSMutableString stringWithString:oldString];
    for (int i = ceil(oldMutableStr.length / 4.0 - 1.0); i > 0; i--) {
        [oldMutableStr insertString:@" " atIndex:i * 4];
    }
    return [NSString stringWithString:oldMutableStr];
}

+ (NSString *)GetUUID {
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
    return (__bridge NSString *)(string);
}

- (NSComparisonResult)versionStringCompare:(NSString *)other {
    NSArray *oneComponents = [self componentsSeparatedByString:@"a"];
    NSArray *twoComponents = [other componentsSeparatedByString:@"a"];
    
    // The parts before the "a"
    NSString *oneMain = [oneComponents objectAtIndex:0];
    NSString *twoMain = [twoComponents objectAtIndex:0];
    
    // If main parts are different, return that result, regardless of alpha part
    NSComparisonResult mainDiff;
    if ((mainDiff = [oneMain compare:twoMain]) != NSOrderedSame) {
        return mainDiff;
    }
    
    // At this point the main parts are the same; just deal with alpha stuff
    // If one has an alpha part and the other doesn't, the one without is newer
    if ([oneComponents count] < [twoComponents count]) {
        return NSOrderedDescending;
        
    } else if ([oneComponents count] > [twoComponents count]) {
        return NSOrderedAscending;
        
    } else if ([oneComponents count] == 1) {
        // Neither has an alpha part, and we know the main parts are the same
        return NSOrderedSame;
    }
    
    // At this point the main parts are the same and both have alpha parts. Compare the alpha parts
    // numerically. If it's not a valid number (including empty string) it's treated as zero.
    NSNumber *oneAlpha = [NSNumber numberWithInt:[[oneComponents objectAtIndex:1] intValue]];
    NSNumber *twoAlpha = [NSNumber numberWithInt:[[twoComponents objectAtIndex:1] intValue]];
    return [oneAlpha compare:twoAlpha];
}

///////////////////////////////////////////////////////////////////////////////////////////////////

- (NSString*)mdPhoneNo {
    if (self.length >= 7) {
        NSString *str = self;
        NSString *header = [str substringWithRange:NSMakeRange(0, 3)];
        NSString *footer = [str substringWithRange:NSMakeRange(7, str.length-7)];
        NSString *phone = [NSString stringWithFormat:@"%@****%@",header,footer];
        return phone;
    }
    return self;
}

//清理url !xxxxx 这种通配符
- (NSString*)clearThumbnail {
    if (self.length >0 && [self containString:@"!"]) {
        NSString *str = self;
        NSRange range = [str rangeOfString:@"!"];//匹配得到的下标
        NSString *url = [str substringWithRange:NSMakeRange(0, range.location)];
        
        return url;
    }
    return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)isWhitespaceAndNewlines {
    NSCharacterSet* whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    for (NSInteger i = 0; i < self.length; ++i) {
        unichar c = [self characterAtIndex:i];
        if (![whitespace characterIsMember:c]) {
            return NO;
        }
    }
    return YES;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)isEmptyOrWhitespace {
    return  ![self isKindOfClass:[NSString class]] ||  self == nil || !([self length] > 0) || [[self trimmedWhitespaceString] length] == 0;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
-(BOOL) isEmail{
    NSString *emailRegEx =
    @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
    @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
    @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    return [regExPredicate evaluateWithObject:[self lowercaseString]];
}

-(BOOL)isIncludeSpecialCharact {
    //***需要过滤的特殊字符：~￥#&*<>《》()[]{}【】^@/￡¤￥|§¨「」『』￠￢￣~@#￥&*（）——+|《》$_€。
    
    NSRange urgentRange = [self rangeOfCharacterFromSet: [NSCharacterSet characterSetWithCharactersInString: @"~￥#&*<>《》()[]{}【】^@/￡¤￥|§¨「」『』￠￢￣~@#￥&*（）——+|《》$_€"]];
    
    if (urgentRange.location == NSNotFound){
        return NO;
    }
    return YES;
    
}

- (BOOL)isLegalPrice{
    if([self isEmptyOrWhitespace]){
        return NO;
    }
    
    NSString *integerOrFloatPointRegEx = @"0|[1-9]+[0-9]*|(0|[1-9]+[0-9]*).[0-9]*[1-9]+$";
    
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", integerOrFloatPointRegEx];
    return [regExPredicate evaluateWithObject:[self lowercaseString]];
}

-(BOOL)isNumber{
    if([self isEmptyOrWhitespace]){
        return NO;
    }
    
    NSString *integerOrFloatPointRegEx = @"[0-9]+$";
    
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", integerOrFloatPointRegEx];
    return [regExPredicate evaluateWithObject:[self lowercaseString]];
}

-(BOOL)isLegalName{
    if([self isEmptyOrWhitespace]){
        return NO;
    }
    
    NSString *integerOrFloatPointRegEx = @"^\\w+$";
    
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", integerOrFloatPointRegEx];
    return [regExPredicate evaluateWithObject:[self lowercaseString]];
}

/////////////////////////////////////////////////////////////////////////// unicodeEncode
- (NSString*)unicodeEncode{
    NSMutableString *result = [[NSMutableString alloc] init];
    NSInteger length = [self length];
    unichar *buffer = calloc( [self length ], sizeof( unichar ) );
    [self getCharacters:buffer];
    
    for (NSInteger i = 0; i < length; i++){
        unichar ch = buffer[i];
        
        if ((ch & 0xff80) == 0){
            if ([self isCharSafe:ch] == YES){
                [result appendFormat:@"%c", ch];
            } else if (ch == ' '){
                [result appendString:@"+"];
            } else{
                [result appendString:@"%"];
                [result appendFormat:@"%c", [self intToHex:((ch >> 4) & '\x000f')]];
                [result appendFormat:@"%c", [self intToHex:(ch & '\x000f')]];
            }
        }	else{
            [result appendString:@"%u"];
            [result appendFormat:@"%c", [self intToHex:((ch >> 12) & '\x000f')]];
            [result appendFormat:@"%c", [self intToHex:((ch >> 8) & '\x000f')]];
            [result appendFormat:@"%c", [self intToHex:((ch >> 4) & '\x000f')]];
            [result appendFormat:@"%c", [self intToHex:(ch & '\x000f')]];
        }
    }
    free(buffer);
    if (result) {
        return result;
    }
    return @"";
}

-(unichar) intToHex:(int)n{
    if (n <= 9){
        return (unichar)(n + 0x30);
    }
    return (unichar)((n - 10) + 0x61);
}

-(BOOL) isCharSafe:(unichar)ch{
    if (((ch >= 'a') && (ch <= 'z')) || ((ch >= 'A') && (ch <= 'Z')) || ((ch >= '0') && (ch <= '9')))	{
        return YES;
    }
    switch (ch){
        case '\'':
        case '(':
        case ')':
        case '*':
        case '-':
        case '.':
        case '_':
        case '!':
            return YES;
    }
    return NO;
}

- (BOOL)isOnlyContainNumberOrLatter{
    for (NSInteger i = 0; i < self.length; i++) {
        unichar ch = [self characterAtIndex:i];
        if (!(((ch >= 'a') && (ch <= 'z')) || ((ch >= 'A') && (ch <= 'Z')) || ((ch >= '0') && (ch <= '9')))){ //0=48
            return NO;
        }
    }
    return YES;
}

-(BOOL)containString:(NSString *)string{
    if (!self) {
        return NO;
    }
    return [self rangeOfString:string].location != NSNotFound;
}

-(NSString *)removeSpace{
    if(![self containString:@" "]){
        return self;
    }
    
    NSMutableString *mString = [NSMutableString stringWithString:self];
    [mString replaceCharactersInRange:[self rangeOfString:@" "] withString:@""];
    
    NSString *string = [mString removeSpace];
    
    return string;
}

- (NSString *)replaceSpaceWithUnderline{
    if(![self containString:@" "]){
        return self;
    }
    
    NSMutableString *mString = [NSMutableString stringWithString:self];
    [mString replaceCharactersInRange:[self rangeOfString:@" "] withString:@"_"];
    
    NSString *string = [mString replaceSpaceWithUnderline];
    
    return string;
}

- (NSString *)replaceDotWithUnderline{
    if(![self containString:@"."]){
        return self;
    }
    
    NSMutableString *mString = [NSMutableString stringWithString:self];
    [mString replaceCharactersInRange:[self rangeOfString:@"."] withString:@"_"];
    
    NSString *string = [mString replaceDotWithUnderline];
    
    return string;
}

+ (NSString *)replaceStringsFromDictionary:(NSDictionary *)dict stringName:(NSString *)name
{
    NSMutableString *string = [NSMutableString stringWithString:name];
    for (NSString *target in dict) {
        [string replaceOccurrencesOfString:target
                                withString:[dict objectForKey:target]
                                   options:0
                                     range:NSMakeRange(0, [string length])];
    }
    return string;
}

- (NSString *)encodeString{
    CFStringRef stringRef = CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                    (__bridge CFStringRef)self,
                                                                    NULL,
                                                                    (CFStringRef)@";/?:@&=$+{}<>,",
                                                                    kCFStringEncodingUTF8);
    NSString *result = [NSString stringWithString:(__bridge NSString *)stringRef];
    CFRelease(stringRef);
    
    return result;
}

-(NSString *)trimmedWhitespaceString{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

-(NSString *)trimmedWhitespaceAndNewlineString{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)insertString:(NSString *)aString forEachIndexs:(NSUInteger)indexs {
    NSMutableString *oldMutableStr = [NSMutableString stringWithString:self];
    for (int i = ceil(1.0 * oldMutableStr.length / indexs - 1.0); i > 0; i--) {
        [oldMutableStr insertString:@" " atIndex:i * 4];
    }
    return [NSString stringWithString:oldMutableStr];
}

- (NSDate*)date{
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
	[formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
	NSDate *date = [formatter dateFromString:self];
	return date;
}

- (NSDate*)dateWithFormate:(NSString*) formate {
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
	[formatter setDateFormat:formate];
	NSDate *date = [formatter dateFromString:self];
	return date;
}

+ (NSDate *)dateFromString:(NSString *)string{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [formatter dateFromString:string];
    
    return date;
}

-(NSString *)dateFromStringWithOriginalFormat:(NSString*)originalFormat targetFormat:(NSString *)targetFormat{
    //[dateFormatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"];
    NSDateFormatter* fmt = [[NSDateFormatter alloc] init];
    fmt.dateStyle = NSDateFormatterFullStyle;
    fmt.dateFormat = originalFormat;
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    NSDate *date = [fmt dateFromString:self];
    
    if(date == nil) return @"";
    NSDateFormatter* targetFmt = [[NSDateFormatter alloc] init];
    targetFmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    targetFmt.dateFormat = targetFormat;
    return  [targetFmt stringFromDate:date];
}

+ (NSString *)convertDictionaryToJSON:(NSDictionary *)jsonObject{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonObject options:NSJSONWritingPrettyPrinted error:nil];
    NSString *json =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return json;
}

- (NSDictionary *)toDictionary {
    if (self) {
        NSData *resData = [[NSData alloc] initWithData:[self dataUsingEncoding:NSUTF8StringEncoding]];
        //系统自带JSON解析
        NSDictionary *info = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
        return info;
    } else {
        return nil;
    }
}


- (NSDictionary *)parseURLParams{
	NSArray *pairs = [self componentsSeparatedByString:@"&"];
    NSMutableDictionary *muDic = [NSMutableDictionary dictionaryWithCapacity:[pairs count]];
	for(NSString *aPair in pairs){
		NSArray *keyAndValue = [aPair componentsSeparatedByString:@"="];
		if([keyAndValue count] != 2) continue;
        [muDic setObject:[keyAndValue objectAtIndex:1] forKey:[keyAndValue objectAtIndex:0]];
	}
    
	return muDic;
}

- (NSString *)getValueStringFromUrlForParam:(NSString *)param {
    NSUInteger location = [self rangeOfString:@"?"].location;
    NSString *params = nil;
    if (location != NSNotFound) {
        params = [self substringFromIndex:location+1];
    }else{
        params = self;
    }
    
    NSDictionary *dic = [params parseURLParams];
    return dic[param];
}

#define MINUTES 60
#define HOURS 3600
#define DAYS 86400
- (NSString *)StringFromTimestamp {
    
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
	[formatter setDateFormat:@"dd MMM yyyy, HH:mm zzz"];
	NSDate *date = [formatter dateFromString:[self stringByAppendingString:@" GMT"]];
	[formatter setLocale:[NSLocale currentLocale]];
	NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit fromDate:[NSDate date]];
	[components setHour: 23];
	[components setMinute: 59];
	[components setSecond:59];
	NSDate *today = [[NSCalendar currentCalendar] dateFromComponents:components];
	NSTimeInterval seconds = [today timeIntervalSinceDate:date];
	
	if(seconds/HOURS < 24) {
		[formatter setTimeStyle:NSDateFormatterShortStyle];
		[formatter setDateStyle:NSDateFormatterNoStyle];
	} else if(seconds/DAYS < 2) {
		[formatter setDateFormat:NSLocalizedString(@"'Yesterday'", @"Yesterday date format string")];
	} else if(seconds/DAYS < 7) {
		[formatter setDateFormat:@"EEEE"];
	} else {
		[formatter setDateStyle:NSDateFormatterShortStyle];
	}
	
	NSString *output = [formatter stringFromDate:date];
	return output;
}

- (NSString *)StringFromUTS {
	
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
	[formatter setDateFormat:@"dd MMM yyyy, HH:mm zzz"];
	NSDate *date = [NSDate dateWithTimeIntervalSince1970: [self doubleValue]];
	[formatter setLocale:[NSLocale currentLocale]];
	NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit fromDate:[NSDate date]];
	[components setHour: 23];
	[components setMinute: 59];
	[components setSecond:59];
	NSDate *today = [[NSCalendar currentCalendar] dateFromComponents:components];
	NSTimeInterval seconds = [today timeIntervalSinceDate:date];
	
	if(seconds/HOURS < 24) {
		[formatter setTimeStyle:NSDateFormatterShortStyle];
		[formatter setDateStyle:NSDateFormatterNoStyle];
	} else if(seconds/DAYS < 2) {
		[formatter setDateFormat:NSLocalizedString(@"'Yesterday'", @"Yesterday date format string")];
	} else if(seconds/DAYS < 7) {
		[formatter setDateFormat:@"EEEE"];
	} else {
		[formatter setDateStyle:NSDateFormatterShortStyle];
	}
	
	NSString *output = [formatter stringFromDate:date];
	return output;
}

- (NSString *)shortDateStringFromUTS {
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
	[formatter setDateFormat:@"dd MMM yyyy, HH:mm zzz"];
	NSDate *date = [NSDate dateWithTimeIntervalSince1970: [self doubleValue]];
	[formatter setLocale:[NSLocale currentLocale]];
	NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit fromDate:[NSDate date]];
	[components setHour: 23];
	[components setMinute: 59];
	[components setSecond:59];
	NSDate *today = [[NSCalendar currentCalendar] dateFromComponents:components];
	NSTimeInterval seconds = [today timeIntervalSinceDate:date];
	
	if(seconds/HOURS < 24) {
		[formatter setTimeStyle:NSDateFormatterShortStyle];
		[formatter setDateStyle:NSDateFormatterNoStyle];
	} else {
		[formatter setDateStyle:NSDateFormatterShortStyle];
	}
	
	NSString *output = [formatter stringFromDate:date];
	return output;
}

//判断是否为浮点类型
- (BOOL)isPureFloat {
    if (self == nil) {
        return NO;
    }
    NSScanner* scan = [NSScanner scannerWithString:self];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}

- (CGFloat)heightOfString:(NSString *)text textFontSize:(float)size widthSize:(float)width //计算文字高度
{
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:size], NSFontAttributeName,nil];
    CGSize  stringSize =[text boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:tdic context:nil].size;

    return stringSize.height;
}

- (CGFloat)stringHeight:(NSString *)text textFontSize:(UIFont *)font widthSize:(float)width {
    
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,nil];
    CGSize  stringSize =[text boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:tdic context:nil].size;
    
    return stringSize.height;
}

///计算文字高度 含有 间距
- (CGFloat)stringHeightFontSize:(UIFont *)font widthSize:(float)width lineSpace:(CGFloat)space {
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = space;
    
    NSDictionary * tdic = @{NSFontAttributeName: font,
                            NSParagraphStyleAttributeName: paragraphStyle};
    CGSize stringSize =[self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:tdic context:nil].size;
    return stringSize.height;
}

- (CGFloat)stringHeightFontSize:(UIFont *)font widthSize:(float)width {
    
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,nil];
    CGSize  stringSize =[self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:tdic context:nil].size;
    
    return stringSize.height;
}

- (CGFloat)widthOfString:(NSString *)string withFont:(UIFont *)font {
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
    return [[[NSAttributedString alloc] initWithString:string attributes:attributes] size].width;
}

- (CGFloat)widthOfStringFont:(UIFont *)font {
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
    return [[[NSAttributedString alloc] initWithString:self attributes:attributes] size].width;
}

- (NSMutableAttributedString *)getAttributedBySpace:(int)space {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];//调整行间距
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, self.length)];
    
    return attributedString;
}

- (NSString *)replace:(NSString *)source to:(NSString *)str {
    return [self stringByReplacingOccurrencesOfString:source withString:str];
}


+ (NSString *)getMacAddress {
    
    return @"02:00:00:00:00:00";
//    int                 mgmtInfoBase[6];
//    char                *msgBuffer = NULL;
//    size_t              length;
//    unsigned char       macAddress[6];
//    struct if_msghdr    *interfaceMsgStruct;
//    struct sockaddr_dl  *socketStruct;
//    NSString            *errorFlag = NULL;
//    
//    // Setup the management Information Base (mib)
//    mgmtInfoBase[0] = CTL_NET;        // Request network subsystem
//    mgmtInfoBase[1] = AF_ROUTE;       // Routing table info
//    mgmtInfoBase[2] = 0;
//    mgmtInfoBase[3] = AF_LINK;        // Request link layer information
//    mgmtInfoBase[4] = NET_RT_IFLIST;  // Request all configured interfaces
//    
//    // With all configured interfaces requested, get handle index
//    if ((mgmtInfoBase[5] = if_nametoindex("en0")) == 0){
//        errorFlag = @"if_nametoindex failure";
//    } else {
//        // Get the size of the data available (store in len)
//        if (sysctl(mgmtInfoBase, 6, NULL, &length, NULL, 0) < 0){
//            errorFlag = @"sysctl mgmtInfoBase failure";
//        } else {
//            // Alloc memory based on above call
//            if ((msgBuffer = malloc(length)) == NULL){
//                errorFlag = @"buffer allocation failure";
//            } else {
//                // Get system information, store in buffer
//                if (sysctl(mgmtInfoBase, 6, msgBuffer, &length, NULL, 0) < 0){
//                    errorFlag = @"sysctl msgBuffer failure";
//                }
//            }
//        }
//    }
//    
//    // Befor going any further...
//    if (errorFlag != NULL) {
//        NSLog(@"Error: %@", errorFlag);
//        return errorFlag;
//    }
//    
//    // Map msgbuffer to interface message structure
//    interfaceMsgStruct = (struct if_msghdr *) msgBuffer;
//    
//    // Map to link-level socket structure
//    socketStruct = (struct sockaddr_dl *) (interfaceMsgStruct + 1);
//    
//    // Copy link layer address data in socket structure to an array
//    memcpy(&macAddress, socketStruct->sdl_data + socketStruct->sdl_nlen, 6);
//    
//    // Read from char array into a string object, into traditional Mac address format
//    NSString *macAddressString = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
//                                  macAddress[0], macAddress[1], macAddress[2],
//                                  macAddress[3], macAddress[4], macAddress[5]];
//    NSLog(@"Mac Address: %@", macAddressString);
//    
//    // Release the buffer memory
//    free(msgBuffer);
//    
//    return macAddressString;
}

- (BOOL)isContainStr:(NSString *)str {
    NSRange range = [self rangeOfString:str];//判断字符串是否包含
    
    return (range.location != NSNotFound);
}

//获取label数字尺寸
- (CGSize)getSizeWithFont:(UIFont *)font Size:(CGSize)size LineSpace:(int)space {
    UILabel *label       = [[UILabel alloc]init];
    label.font           = font;
    label.numberOfLines  = 0;
    label.textAlignment  = NSTextAlignmentLeft;
    label.lineBreakMode  = NSLineBreakByCharWrapping;
    if (space == 0) {
        label.text = self;
    } else {
        label.attributedText = [self getAttributedBySpace:space];
    }
    CGSize labelSize = [label sizeThatFits:size];
    CGSize newSize = CGSizeMake(labelSize.width, (int)labelSize.height+1);
    
    return newSize;
}

- (NSString *)trim {
    NSCharacterSet *whiteSpace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    return [[NSString alloc]initWithString:[self stringByTrimmingCharactersInSet:whiteSpace]];
}

- (NSString *)trimAll{
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}

//- (NSString *)removeLineSpace {
//    if(![self containString:@"\n\n\n"]){
//        return self;
//    }
//
//    NSMutableArray *array = [self componentsSeparatedByString:@"\n"].mutableCopy;
//    NSMutableArray *newArray = [NSMutableArray new];
//    for (int i = 0 ; i < array.count; i++) {
//        NSString *componentString = array[i];
//        NSString *nextString = @"1";
//        if (i < array.count -1) {
//           nextString = array[i+1];
//        }
//        if (!kStringIsEmpty(componentString) || (kStringIsEmpty(componentString) && kStringIsEmpty(nextString))) {
//            [newArray addObject:componentString];
//        }
//    }
//    NSString *newString = [[newArray componentsJoinedByString:@"\n"] trim];
//    newString = [newString removeLineSpace];
//    return newString;
//}
- (NSString *)removeLineSpace {
    NSString *match = @"(\\n{3,})";
    NSString *newString = self;
    NSRange range = [self rangeOfString:match options:NSRegularExpressionSearch];
    if (range.location != NSNotFound) {
        newString = [[self stringByReplacingCharactersInRange:range withString:@"\n\n"] removeLineSpace];
    }
    return [newString trim];

}

#pragma mark - 转换为金额类型
- (NSString *)toMoney {
    CGFloat money = [self intValue];
    if (money == (int)money) {//如果是整数
        return [NSString stringWithFormat:@"%d",(int)money];
    } else {//如果是float类型 要去除末尾的0 没法用金额格式化计算的时候都转成float类型了。
        //剩余可能性 .0x  .x0 如果.x0 添加# 删除0# 如果.0x
        NSString *string = [NSString stringWithFormat:@"%.2f#",money];
        if ([string containString:@"0#"]) {
            return [string replace:@"0#" to:@""];
        } else {//包含#
            return [string replace:@"#" to:@""];
        }
    }
    return nil;
}

#pragma mark - 获取字符串里面的数字
- (NSInteger)getNumberByString {
    NSScanner *scanner = [NSScanner scannerWithString:self];
    [scanner scanUpToCharactersFromSet:[NSCharacterSet decimalDigitCharacterSet] intoString:nil];
    int number;
    [scanner scanInt:&number];
    return number;
}

- (NSNumber *)toNumberStyle{
    
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    return [f numberFromString:self];
}

+(NSString *) jsonStringWithString:(NSString *) string{
    return [NSString stringWithFormat:@"\"%@\"",[string stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"]];
}

+(NSString *) jsonStringWithArray:(NSArray *)array {
    NSMutableString *reString = [NSMutableString string];
    
    [reString appendString:@"["];
    
    NSMutableArray *values = [NSMutableArray array];
    
    for (id valueObj in array) {
        NSString *value = [NSString jsonStringWithObject:valueObj];
        if (value) {
            [values addObject:[NSString stringWithFormat:@"%@",value]];
        }
    }
    [reString appendFormat:@"%@",[values componentsJoinedByString:@","]];
    [reString appendString:@"]"];
    
    return reString;
}


+(NSString *) jsonStringWithDictionary:(NSDictionary *)dictionary{
    
    NSArray *keys = [dictionary allKeys];
    
    NSMutableString *reString = [NSMutableString string];
    
    [reString appendString:@"{"];
    
    NSMutableArray *keyValues = [NSMutableArray array];
    
    for (int i=0; i<[keys count]; i++) {
        
        NSString *name = [keys objectAtIndex:i];
        
        id valueObj = [dictionary objectForKey:name];
        
        NSString *value = [NSString jsonStringWithObject:valueObj];
        
        if (value) {
            
            [keyValues addObject:[NSString stringWithFormat:@"\"%@\":%@",name,value]];
            
        }
        
    }
    
    [reString appendFormat:@"%@",[keyValues componentsJoinedByString:@","]];
    
    [reString appendString:@"}"];
    
    return reString;
    
}


+(NSString *) jsonStringWithObject:(id) object{
    
    NSString *value = nil;
    
    if (!object) {
        
        return value;
        
    }
    
    if ([object isKindOfClass:[NSString class]]) {
        
        value = [NSString jsonStringWithString:object];
        
    }else if([object isKindOfClass:[NSDictionary class]]){
        
        value = [NSString jsonStringWithDictionary:object];
        
    }else if([object isKindOfClass:[NSArray class]]){
        
        value = [NSString jsonStringWithArray:object];
        
    }
    
    return value;
    
}

- (BOOL)isValidateRealName{
    NSPredicate *realNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^[\u4e00-\u9fa5]{0,}"];
    return [realNamePredicate evaluateWithObject:self];
}


- (BOOL)isValidateByRegex:(NSString *)regex{
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pre evaluateWithObject:self];
}
//手机号分服务商
- (BOOL)isMobileNumberClassification{
    /**
     15      * 手机号码
     16      * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188,1705
     17      * 联通：130,131,132,152,155,156,185,186,1709
     18      * 电信：133,1349,153,180,189,1700
     19      */
    //    NSString * MOBILE = @"^1((3//d|5[0-35-9]|8[025-9])//d|70[059])\\d{7}$";//总况
    /**
     23      10         * 中国移动：China Mobile
     24      11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188，1705
     25      12         */
    NSString *CM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(17[2,8])|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
//    NSString *CM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
//    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|78|8[278])\\d|705)\\d{7}$";
    /**
     28      15         * 中国联通：China Unicom
     29      16         * 130,131,132,152,155,156,185,186,1709
     30      17         */
    NSString *CU = @"^((13[0-2])|(145)|(15[5-6])|(17[1,5,6])|(18[5,6]))\\d{8}|(1709)\\d{7}$";
//    NSString *CU = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
//    NSString * CU = @"^1((3[0-2]|5[256]|8[56])\\d|709)\\d{7}$";
    /**
     33      20         * 中国电信：China Telecom
     34      21         * 133,1349,153,180,189,1700
     35      22         */
    NSString *CT = @"^((133)|(149)|(153)|(17[3,7])|(18[0,1,9]))\\d{8}$";
//    NSString *CT = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
//    NSString * CT = @"^1((33|53|8[09])\\d|349|700)\\d{7}$";
    /**
     40      25         * 大陆地区固话及小灵通
     41      26         * 区号：010,020,021,022,023,024,025,027,028,029
     42      27         * 号码：七位或八位
     43      28         */
    NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    //    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    if (([self isValidateByRegex:CM])
        || ([self isValidateByRegex:CU])
        || ([self isValidateByRegex:CT])
        || ([self isValidateByRegex:PHS]))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

//#define ALPHANUM
-(BOOL)isValidateIDNo{
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"] invertedSet];
    NSString *filtered = [[self componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    return [self isEqualToString:filtered];
}

-(BOOL)isValidateNum{
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    NSString *filtered = [[self componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    return [self isEqualToString:filtered];
}


//判断是否是纯汉字
- (BOOL)isChinese{
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
}
//判断是否含有汉字
- (BOOL)includeChinese{
    for(int i=0; i< [self length];i++)
    {
        int a =[self characterAtIndex:i];
        if( a >0x4e00&& a <0x9fff){
            return YES;
        }
    }
    return NO;
}

/**时间戳转字符串*/
- (NSString *)getTimeDateWithFormat:(NSString *)formatString{
    
    if ([self isEqualToString:@"0"] || [self longValue] < 20 ) {
        return @"";
    }
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[self longLongValue]/1000];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];// 创建一个时间格式化对象
    [dateFormatter setDateFormat:formatString]; //设定时间的格式
    
     NSString* string=[dateFormatter stringFromDate:confromTimesp];
    
    return string;
}

//判断是否含有表情符号 yes-有 no-没有
+ (BOOL)stringContainsEmoji:(NSString *)string {
    __block BOOL returnValue =NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        const unichar hs = [substring characterAtIndex:0];
        if (0xd800) {
            if (0xd800 <= hs && hs <= 0xdbff) {
                if (substring.length > 1) {
                    const unichar ls = [substring characterAtIndex:1];
                    const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                    if (0x1d000 <= uc && uc <= 0x1f77f) {
                        returnValue =YES;
                    }
                }
            }else if (0x2100 <= hs && hs <= 0x27ff){
               returnValue =YES;
            }else if (0x2B05 <= hs && hs <= 0x2b07) {
                returnValue =YES;
            }else if (0x2934 <= hs && hs <= 0x2935) {
                returnValue =YES;
            }else if (0x3297 <= hs && hs <= 0x3299) {
                returnValue =YES;
            }else{
                if (substring.length > 1) {
                    const unichar ls = [substring characterAtIndex:1];
                    if (ls == 0x20e3) {
                        returnValue =YES;
                    }
                }
            }
            if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50 || hs == 0xd83e) {
                returnValue =YES;
            }
            
      }
    }];
    return returnValue;
}
//是否是系统自带九宫格输入 yes-是 no-不是
+ (BOOL)isNineKeyBoard:(NSString *)string {
    NSString *other = @"➋➌➍➎➏➐➑➒";
    int len = (int)string.length;
    for(int i=0;i<len;i++){
       if(!([other rangeOfString:string].location != NSNotFound))
          return NO;
    }
    return YES;
}
//判断第三方键盘中的表情
+ (BOOL)hasEmoji:(NSString*)string {
    NSString *pattern = @"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:string];
    return isMatch;
}
//去除表情
+ (NSString *)disableEmoji:(NSString *)text {
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]"options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:text options:0 range:NSMakeRange(0, [text length]) withTemplate:@""];
    return modifiedString;
}

@end
