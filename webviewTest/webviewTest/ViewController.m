//
//  ViewController.m
//  webviewTest
//
//  Created by Gino Shen on 2019/4/16.
//  Copyright © 2019年 Gino Shen. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WKWebView.h>
#import <WebKit/WebKit.h>

@interface ViewController ()
<WKScriptMessageHandler, WKNavigationDelegate>
@property (weak, nonatomic) IBOutlet WKWebView *theWebView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)loadWebView:(NSString *)urlString {

    NSURL* url = [NSURL URLWithString:urlString];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    self.theWebView.navigationDelegate = self;
    [self.theWebView loadRequest:requestObj];
    self.theWebView.opaque = NO; //set webview transparent

}
#pragma mark - WKWebKit DELEGATE METHODS
//https://medium.freecodecamp.org/how-to-build-cross-origin-communication-bridges-in-ios-and-andriod-7baef82b3f02
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    //Handle incoming messages from Javascript

}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    // This error might occures. So need to handle in info.plist
    // Error - "The resource could not be loaded because the App Transport Security policy requires the use of a secure connection"
    NSDictionary *userInfo = error.userInfo;
    [self showBlockError:[userInfo objectForKey:@"NSLocalizedDescription"]];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    [self showBlockError:NSLocalizedString(@"error_msg_common", @"")];
}

- (void) showBlockError:(NSString *)msg {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:msg
                                                                   message:@""
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *retryAction = [UIAlertAction actionWithTitle:@"OK"
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction *action) {
                                                        }];
    [alert addAction:retryAction];
    [self presentViewController:alert animated:YES completion:nil];
}


- (IBAction)tapToDisplayEMQcom:(id)sender {
    [self loadWebView:@"https://www.emq.com/app_terms.htm"];
}

- (IBAction)tapToDisplayEMQSENDcom:(id)sender {
    [self loadWebView:@"https://staging.emqsend.com/app/terms-and-conditions?payinCountry=twn&lang=en&color=000000"];
}


@end
