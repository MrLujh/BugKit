//
//  BugKitLogInfoViewController.m
//  BugKitExample
//
//  Created by lujh on 2018/3/20.
//  Copyright © 2018年 lujh. All rights reserved.
//

#import "BugKitLogInfoViewController.h"
#import <CocoaLumberjack/CocoaLumberjack.h>

@interface BugKitLogInfoViewController ()
/** textView */
@property (nonatomic,strong) UITextView *textView;
/** fileLogger */
@property (nonatomic,weak) DDFileLogger * fileLogger;
@end

@implementation BugKitLogInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.textView];
    NSArray *logs = [DDLog sharedInstance].allLoggers;
    for ( id<DDLogger> log in logs) {
        if ([log isKindOfClass:[DDFileLogger class]])
        {
            self.fileLogger = (DDFileLogger*)log;
        }
    }
    
    NSData *logData = [NSData dataWithContentsOfFile:self.fileLogger.currentLogFileInfo.filePath];
    NSString *logText = [[NSString alloc] initWithData:logData encoding:NSUTF8StringEncoding];
    
    self.textView.text = logText;
    self.textView.font = [UIFont systemFontOfSize:7];
    self.textView.layoutManager.allowsNonContiguousLayout = NO;
    self.textView.editable = NO;
    [self scrollTextViewToBottom:self.textView];
}

- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 64,[UIScreen mainScreen].bounds.size.width , [UIScreen mainScreen].bounds.size.height - 64)];
    }
    return _textView;
}

-(void)scrollTextViewToBottom:(UITextView *)textView {
    if(textView.text.length > 0 ) {
        NSRange bottom = NSMakeRange(textView.text.length -1, 1);
        [textView scrollRangeToVisible:bottom];
    }
    
}

@end
