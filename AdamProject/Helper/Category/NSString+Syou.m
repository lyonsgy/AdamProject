//
//  NSString+Syou.m
//  SyouInfomationPublish
//
//  Created by nplus on 14-4-21.
//  Copyright (c) 2014年 Syousoft. All rights reserved.
//

#import "NSString+Syou.h"
#import <CoreText/CoreText.h>
@implementation NSString (Syou)

-(id)JsonValue;{
    NSError *errorJson;
    id jsonDict = [NSJSONSerialization JSONObjectWithData:[self dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&errorJson];
    if (errorJson != nil) {
#ifdef DEBUG
        NSLog(@"fail to get dictioanry from JSON: %@, error: %@", self, errorJson);
#endif
    }
    return jsonDict;
}

- (NSString *)URLEncodedString
{
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                            (CFStringRef)self,
                                            (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
                                            NULL,
                                            kCFStringEncodingUTF8));
    return encodedString;
}
+(NSString *)NowTimeStringWithFormatter:(NSString *)formatterString
{
    NSDate *date=[NSDate date];
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    formatter.dateFormat=formatterString;
    NSString *dateStr=[formatter stringFromDate:date];
    return dateStr;
}
+(NSString *)timeFormateSecond:(int)second
{
    NSString *str=@"";
    int h=second/3600;
    int m=(second-h*3600)/60;
    int s=second%60;
    str=[NSString stringWithFormat:@"%.2d:%.2d:%.2d",h,m,s];
    return str;
}

+(NSString *)dateStringFromSecond:(int)second WithFormatter:(NSString *)formatter
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:second];
    NSDateFormatter *aformatter = [[NSDateFormatter alloc] init];
    aformatter.dateFormat=formatter;
    return [aformatter stringFromDate:date];
}
+(NSString *)stringFromDate:(NSDate *)date WithFormatter:(NSString *)formatter;
{
    NSDateFormatter * dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:formatter];
    NSString * dateString=[dateFormatter stringFromDate:date];
    return dateString;
}
-(NSString *)dateStringFromOriginalFormatter:(NSString *)originalFormatter ToTargetFormatter:(NSString *)targetFormatter
{
    NSDateFormatter * odateFormatter=[[NSDateFormatter alloc]init];
    [odateFormatter setDateFormat:originalFormatter];
    NSDate * date=[odateFormatter dateFromString:self];
    
    NSDateFormatter *tdateFormatter =[[NSDateFormatter alloc]init];
    [tdateFormatter setDateFormat:targetFormatter];
    return [tdateFormatter stringFromDate:date];
    
}

//计算文本的size
-(CGSize)boundingRectWithSize:(CGSize)size
                 withTextFont:(UIFont *)font
              withLineSpacing:(CGFloat)lineSpacing
{
    NSMutableAttributedString *attributedText = [self attributedStringFromStingWithFont:font
                                                                        withLineSpacing:lineSpacing];
    CGSize textSize = [attributedText boundingRectWithSize:size
                                                   options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                                   context:nil].size;
    
    
  
    return CGSizeMake(textSize.width, ceil(textSize.height));
}
-(CGSize)boundingRectWithSize:(CGSize)size
                 withTextFont:(UIFont *)font
              withLineSpacing:(CGFloat)lineSpacing
      withFirstLineHeadindent:(CGFloat)firstLineHeadindent
{
    NSMutableAttributedString *attributedText = [self attributedStringFromStingWithFont:font
                                                                        withLineSpacing:lineSpacing withFirstLineHeadindent:firstLineHeadindent];
    CGSize textSize = [attributedText boundingRectWithSize:size
                                                   options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                                   context:nil].size;
    return CGSizeMake(textSize.width, ceil(textSize.height));
    
}
//sting转AttributedString
-(NSMutableAttributedString *)attributedStringFromStingWithFont:(UIFont *)font
                                                withLineSpacing:(CGFloat)lineSpacing
{
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:self attributes:@{NSFontAttributeName:font}];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing];
    [paragraphStyle setParagraphSpacingBefore:0];
    [paragraphStyle setParagraphSpacing:0];
    //[paragraphStyle setLineBreakMode:NSLineBreakByTruncatingTail];
//    paragraphStyle.maximumLineHeight=font.lineHeight;
//    paragraphStyle.minimumLineHeight=font.lineHeight;
    [attributedStr addAttribute:NSParagraphStyleAttributeName
                          value:paragraphStyle
                          range:NSMakeRange(0, [self length])];
    return attributedStr;
}
-(NSMutableAttributedString *)attributedStringFromStingWithFont:(UIFont *)font
                                                withLineSpacing:(CGFloat)lineSpacing withFirstLineHeadindent:(CGFloat)firstLineHeadindent
{
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:self attributes:@{NSFontAttributeName:font}];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing];
    [paragraphStyle setFirstLineHeadIndent:firstLineHeadindent];
//    [paragraphStyle setParagraphSpacingBefore:0];
//    [paragraphStyle setParagraphSpacing:1];
    paragraphStyle.maximumLineHeight=font.lineHeight;
    paragraphStyle.minimumLineHeight=font.lineHeight;
    [attributedStr addAttribute:NSParagraphStyleAttributeName
                          value:paragraphStyle
                          range:NSMakeRange(0, [self length])];
    return attributedStr;
}
-(NSString *)removeRetureKey
{
    NSString *string=self;
    NSString *regTags = @"[\n]+";
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regTags options:NSRegularExpressionUseUnixLineSeparators error:&error];
    NSArray *matches = [regex matchesInString:string options:0 range:NSMakeRange(0, [string length])];
    for (int i=0; i<matches.count; i++)
    {
        NSRange matchRange = [regex rangeOfFirstMatchInString:string options:0 range:NSMakeRange(0, [string length])];
        string=[string stringByReplacingCharactersInRange:matchRange withString:@"  "];
    }
    return string;
}
+(NSString*)unicodeStringFromEmoji:(NSString *)emoji
{
    NSString *uniText = [NSString stringWithUTF8String:[emoji UTF8String]];
    NSData *uniData = [uniText dataUsingEncoding:NSNonLossyASCIIStringEncoding];
    NSString *unicodeString = [[NSString alloc] initWithData:uniData encoding:NSUTF8StringEncoding];
    if([unicodeString isEqual:[NSNull null]]||unicodeString==nil)
        return emoji;
    return unicodeString;
}
+(NSString *)emojiStringFromUnicodeString:(NSString *)unicode
{
    const char *jsonString = [unicode UTF8String];
    NSData *jsonData = [NSData dataWithBytes:jsonString length:strlen(jsonString)];
    NSString *emojiStr = [[NSString alloc] initWithData:jsonData encoding:NSNonLossyASCIIStringEncoding];
    if([emojiStr isEqual:[NSNull null]]||emojiStr==nil)
        return unicode;
    return emojiStr;
}
+(BOOL)hasEmoji:(NSString *)string
{
    __block BOOL returnValue = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         
         const unichar hs = [substring characterAtIndex:0];
         // surrogate pair
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     returnValue = YES;
                 }
             }
         } else{
             // non surrogate
             if (0x2100 <= hs && hs <= 0x27ff) {
                 returnValue = YES;
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 returnValue = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 returnValue = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 returnValue = YES;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                 returnValue = YES;
             }
             if(substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 if (ls == 0x20e3) {
                     returnValue = YES;
                 }
                 
             }
         }
     }];

    return returnValue;
}
-(BOOL)determineWhetherIsEmpty
{
    if ([[self removeWhitespaceAndNewline] isEqualToString:@""])
        return YES;
    else
        return NO;
}
-(NSString*)removeWhitespaceAndNewline
{
    return [[self removeRetureKey] stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
}
-(NSString*)removeWhitespaceAndNewlineAndConvertToEmojiString
{
    return [NSString unicodeStringFromEmoji:[self removeWhitespaceAndNewline]];
}
-(NSString *)removeNSNullString
{
    NSString *string=@"";
    string= [self stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
    if([string isEqualToString:@""])
    {
        string=nil;
    }
    return string;
}
-(BOOL)isEmpty
{
    if(!self||[[self removeWhitespaceAndNewline] isEqualToString:@""])
        return YES;
    else
        return NO;
}
@end
