//
//  AppDelegate.m
//  Silence
//
//  Created by Bartlomiej Siemieniuk on 01/03/2015.
//  Copyright (c) 2015 TeamGoat. All rights reserved.
//

#import "AppDelegate.h"
#import <PubNub/PubNub+Subscription.h>
#import <pubnub/PubNub+Messaging.h>
#import <PubNub/PNConfiguration.h>
#import <PubNub/PNChannel.h>
#import <PubNub/PNMessage.h>

@interface AppDelegate () <NSNetServiceBrowserDelegate, NSStreamDelegate>

/* UI */
@property (strong, nonatomic) NSStatusItem *statusItem;
@property (strong, nonatomic) PNChannel *channel;

@end

@implementation AppDelegate

@synthesize statusItem, channel;


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{

    [self initMenuBar];
    [self setupMenu];
    [self setPubNub];
}



- (void)initMenuBar
{
    
    statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    statusItem.title = @"";
    statusItem.image = [NSImage imageNamed:@"control"];
    
    // The highlighted image, use a white version of the normal image
    //    _statusItem.alternateImage = [NSImage imageNamed:@""];
    
    statusItem.highlightMode = YES;
    
}
- (void)setupMenu
{
    NSMenu *menu = [[NSMenu alloc] init];
    
    NSSlider * slider = [self setSlider];
    
    NSMenuItem * item = [[NSMenuItem alloc] initWithTitle: @"Volume" action:nil keyEquivalent:@""];
    
    [item setView:slider];
    [menu addItem:item];
    
    [menu addItem:[NSMenuItem separatorItem]];
    [menu addItemWithTitle:@"Quit" action:@selector(terminate:) keyEquivalent:@""];

    statusItem.menu = menu;
    
}

- (NSSlider *) setSlider
{
    
    NSSlider * slider = [[NSSlider alloc] initWithFrame:NSMakeRect(45, 15, 200, 30)];
    
    [slider setTarget:self];
    [slider setAction:@selector(sliderAction:)];

    
    [slider setMinValue:0];
    [slider setMaxValue:25];
    
    return slider;
}

- (void)applicationWillTerminate:(NSNotification *)aNotification
{
    // Insert code here to tear down your application
}

#pragma mark - Menu Actions

- (void)terminate:(id)sender
{
    [[NSApplication sharedApplication] terminate:self.statusItem.menu];
}

#pragma mark - Slider Actions
- (IBAction)sliderAction:(NSSlider *)sender
{
    NSLog(@"slider value = %d", [sender intValue]);
    NSString * string = [NSString stringWithFormat:@"%d", [sender intValue]];
    [PubNub sendMessage:string toChannel:channel];
}

#pragma mark - Bonjour
-(void)setPubNub
{
    PNConfiguration * myConfig = [PNConfiguration configurationForOrigin:@"pubsub.pubnub.com"
                                                             publishKey:@"your-key"
                                                           subscribeKey:@"your-key"
                                                              secretKey:nil];
    [PubNub setConfiguration: myConfig];
    
    [PubNub connect];
    
    
    //Define a channel
    channel = [PNChannel channelWithName:@"connect" shouldObservePresence:YES];
    
    //Subscribe to the channel
    [PubNub subscribeOnChannel:channel];
    
    //Publish on the channel

   
}

//(In AppDelegate.m, define didReceiveMessage delegate method:)
- (void)pubnubClient:(PubNub *)client didReceiveMessage:(PNMessage *)message {
    NSLog( @"%@", [NSString stringWithFormat:@"received: %@", message.message] );
}


@end
