//
//  WKLanguageTool.m
//  STONotice
//
//  Created by Ke Wang on 2019/1/10.
//  Copyright © 2019年 Bankrous.inc. All rights reserved.
//


#define LANGUAGE_SET @"langeuageset"

#import "WKLanguageTool.h"
#import "AppDelegate.h"
#import "WKMainViewController.h"


static WKLanguageTool *sharedTool = nil;

@interface WKLanguageTool ()

@property(nonatomic,strong)NSBundle *bundle;
@property(nonatomic,copy)NSString *language;



@end

@implementation WKLanguageTool

+ (id)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedTool = [[WKLanguageTool alloc]init];
        [sharedTool initLanguage];
    });
    return sharedTool;
}

-(void)initLanguage
{
    NSString *tmp = [[NSUserDefaults standardUserDefaults] objectForKey:LANGUAGE_SET];
    NSString *path;
    //默认是英文
    if (!tmp)
    {
        tmp = EN;
    }
    
    self.language = tmp;
    path = [[NSBundle mainBundle] pathForResource:self.language ofType:@"lproj"];
    self.bundle = [NSBundle bundleWithPath:path];
}

- (NSString *)getStringForKey:(NSString *)key withTable:(NSString *)table
{
    if ([table isEmpty]) {
        table = @"Localizable";
    }
    if (self.bundle)
    {
        return NSLocalizedStringFromTableInBundle(key, table, self.bundle, @"");
    }
    
    return NSLocalizedStringFromTable(key, table, @"");
}


-(void)changeNowLanguage
{
    if ([self.language isEqualToString:EN])
    {
        [self setNewLanguage:CNS];
    }
    else
    {
        [self setNewLanguage:EN];
    }
}

-(void)setNewLanguage:(NSString *)language
{
    if ([language isEqualToString:self.language])
    {
        return;
    }
    
    if ([language isEqualToString:EN] || [language isEqualToString:CNS] || [language isEqualToString:CNF] || [language isEqualToString:KOR] || [language isEqualToString:JP] || [language isEqualToString:FR] || [language isEqualToString:XBY])
    {
        NSString *path = [[NSBundle mainBundle]pathForResource:language ofType:@"lproj"];
        self.bundle = [NSBundle bundleWithPath:path];
    }
    
    self.language = language;
    [[NSUserDefaults standardUserDefaults]setObject:language forKey:LANGUAGE_SET];
    [[NSUserDefaults standardUserDefaults]synchronize];
 
    [self resetRootViewController];
}

//重新设置
-(void)resetRootViewController
{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    WKMainViewController *mainVC = [[WKMainViewController alloc] init];
    delegate.window.rootViewController = mainVC;
}


@end
