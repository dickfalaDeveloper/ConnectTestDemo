//
//  ViewController.m
//  ConnectTelnetDemo
//
//  Created by James on 2015/1/7.
//  Copyright (c) 2015年 yu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    
    NSMutableData *rawData;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    asyncSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    [asyncSocket connectToHost:@"ptt.cc" onPort:23 error:nil];
    [asyncSocket readDataToData:[GCDAsyncSocket CRLFData] withTimeout:30.0 tag:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port{
    NSLog(@"did connect to host");
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    NSLog(@"did read data: %@",data);
    
    
    NSString* message = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    //        NSString* message = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"message is: \n%@",message);

    rawData = [[NSMutableData alloc] initWithData:data];
    [asyncSocket readDataToData:[GCDAsyncSocket CRLFData] withTimeout:30.0 tag:0];
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err
{
    NSLog(@"socket disconnect to host");
    
}
@end
