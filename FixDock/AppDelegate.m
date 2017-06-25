//
//  AppDelegate.m
//  FixDock
//
//  Created by John Hsu on 2017/5/21.
//  Copyright © 2017年 john. All rights reserved.
//

#import "AppDelegate.h"
@interface AppDelegate ()
@property(nonatomic,strong) id eventMonitor;
@end

@implementation AppDelegate
-(void)applicationWillTerminate:(NSNotification *)notification
{
    [NSEvent removeMonitor:self.eventMonitor];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    Boolean isTrusted = AXIsProcessTrustedWithOptions(CFDictionaryCreate(NULL,(const void * []){kAXTrustedCheckOptionPrompt},(const void * []){kCFBooleanTrue} ,1,NULL,NULL));
    if (isTrusted) {
        // Insert code here to initialize your application
        self.eventMonitor = [NSEvent addGlobalMonitorForEventsMatchingMask:NSEventMaskKeyDown
                                               handler:^(NSEvent *event){
                                                   // Activate app when pressing cmd+ctrl+alt+T
                                                   NSEventModifierFlags flags = [event modifierFlags] & NSEventModifierFlagDeviceIndependentFlagsMask;
//                                                   BOOL hasCommand = flags & NSEventModifierFlagCommand;
//                                                   BOOL hasShift = flags & NSEventModifierFlagShift;
                                                   NSString *key = [event charactersIgnoringModifiers];
                                                   BOOL isD = [key compare:@"D"] == 0;
                                                   if (flags == 1179648 && isD) {
                                                       
//                                                       NSLog(@"xd");
                                                       NSString *killDock = @"killall -KILL Dock";
                                                       NSTask *task = [[NSTask alloc] init];
                                                       [task setLaunchPath:@"/bin/sh"];
                                                       [task setArguments:@[ @"-c", killDock ]];
//                                                       NSPipe *pipe = [[NSPipe alloc] init];
//                                                       [task setStandardOutput:pipe];
//                                                       NSFileHandle *readingFileHandle = [pipe fileHandleForReading];
//                                                       [readingFileHandle readToEndOfFileInBackgroundAndNotify];
                                                       
                                                       
                                                       [task launch];
                                                   }
                                               }];

    }
}



@end
