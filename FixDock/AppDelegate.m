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
@property(nonatomic, strong) IBOutlet NSMenu *statusMenu;
@property(nonatomic, strong) NSStatusItem *statusItem;
@end

@implementation AppDelegate
-(void)applicationWillTerminate:(NSNotification *)notification
{
    [NSEvent removeMonitor:self.eventMonitor];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSSquareStatusItemLength];
//    self.statusItem.title = @"FixDock";
    self.statusItem.menu = self.statusMenu;
    NSImage *image = [NSImage imageNamed:@"statusIcon"];
    self.statusItem.image = image;
    
    Boolean isTrusted = AXIsProcessTrustedWithOptions(CFDictionaryCreate(NULL,(const void * []){kAXTrustedCheckOptionPrompt},(const void * []){kCFBooleanTrue} ,1,NULL,NULL));
    if (isTrusted) {
        // Insert code here to initialize your application
        self.eventMonitor = [NSEvent addGlobalMonitorForEventsMatchingMask:NSEventMaskKeyDown
                                               handler:^(NSEvent *event){
                                                   NSEventModifierFlags flags = [event modifierFlags] & NSEventModifierFlagDeviceIndependentFlagsMask;

                                                   NSString *key = [event charactersIgnoringModifiers];
                                                   BOOL isD = [key compare:@"D"] == 0;
                                                   if (flags == 1179648 && isD) {
                                                       
                                                       NSString *killDock = @"killall -KILL Dock";
                                                       NSTask *task = [[NSTask alloc] init];
                                                       [task setLaunchPath:@"/bin/sh"];
                                                       [task setArguments:@[ @"-c", killDock ]];
                                                       
                                                       [task launch];
                                                   }
                                               }];

    }
}

-(IBAction)quitAction:(id)sender
{
    [NSApplication.sharedApplication terminate:self];
    
}

@end
