//
//  NSString+Syou.h
//  SyouInfomationPublish
//
//  Created by nplus on 14-4-21.
//  Copyright (c) 2014年 Syousoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Syou)
-(id)JsonValue;
+(NSString *)NowTimeStringWithFormatter:(NSString *)formatter;
+(NSString *)timeFormateSecond:(int)second;
+(NSString *)dateStringFromSecond:(int)second WithFormatter:(NSString *)formatter;
-(NSString *)dateStringFromOriginalFormatter:(NSString *)originalFormatter
                           ToTargetFormatter:(NSString *)targetFormatter;
+(NSString *)stringFromDate:(NSDate *)date WithFormatter:(NSString *)formatter;

//计算文本的size
-(CGSize)boundingRectWithSize:(CGSize)size
                 withTextFont:(UIFont *)font
              withLineSpacing:(CGFloat)lineSpacing;
-(CGSize)boundingRectWithSize:(CGSize)size
                 withTextFont:(UIFont *)font
              withLineSpacing:(CGFloat)lineSpacing
      withFirstLineHeadindent:(CGFloat)firstLineHeadindent;
- (NSString *)URLEncodedString;
//sting转AttributedString
-(NSMutableAttributedString *)attributedStringFromStingWithFont:(UIFont *)font
                                                withLineSpacing:(CGFloat)lineSpacing;
-(NSMutableAttributedString *)attributedStringFromStingWithFont:(UIFont *)font
                                                withLineSpacing:(CGFloat)lineSpacing
                                        withFirstLineHeadindent:(CGFloat)firstLineHeadindent;
- (NSString *)removeRetureKey;
+(NSString*)unicodeStringFromEmoji:(NSString *)emoji;
+(NSString *)emojiStringFromUnicodeString:(NSString *)unicode;
+(BOOL)hasEmoji:(NSString *)string;
-(BOOL)determineWhetherIsEmpty;
-(NSString*)removeWhitespaceAndNewline;
-(NSString*)removeWhitespaceAndNewlineAndConvertToEmojiString;
-(NSString *)removeNSNullString;
//-(BOOL)isEmpty;
@end
