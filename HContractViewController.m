//
//  HContractViewController.m
//  hermes
//
//  Created by Zhen Huang on 2020/8/5.
//  Copyright © 2020 James. All rights reserved.
//

#import "HContractViewController.h"
#import <WebKit/WebKit.h>
@interface HContractViewController ()
<WKUIDelegate,
WKNavigationDelegate>
@property (nonatomic, strong) WKWebView *wkWebView;
@property (nonatomic, strong) WKWebViewConfiguration *wkConfig;
@property (nonatomic, strong) UIProgressView *progressView;
@end

@implementation HContractViewController
+(void)load {
    [self registerRoute:KRouteContract supported:@[@protocol(SelectDoctorProtocol)] withHandler:^BOOL(NSDictionary *parameters) {
        HContractViewController *vc = [[HContractViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [[UIViewController topViewController].navigationController pushViewController:vc animated:YES];
        return YES;
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kNavBackGround;
    [self.view addSubview:self.wkWebView];
    [self.wkWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.mas_offset(NavBarHeight);
        make.bottom.equalTo(self.view.mas_bottom).offset(-34);
    }];
    self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, NavBarHeight,ScreenWidth, 0.5)];
    //设置进度条的高度，下面这句代码表示进度条的宽度变为原来的1倍，高度变为原来的1.5倍.
    self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
    [self.view addSubview:self.progressView];
    /*
     *.添加KVO，WKWebView有一个属性estimatedProgress，就是当前网页加载的进度，所以监听这个属性。
     */
    [self startLoad];
}
- (WKWebViewConfiguration *)wkConfig {
    if (!_wkConfig) {
        _wkConfig = [[WKWebViewConfiguration alloc] init];
        _wkConfig.allowsInlineMediaPlayback = YES;
        _wkConfig.allowsPictureInPictureMediaPlayback = YES;
        _wkConfig.suppressesIncrementalRendering = YES;
        WKUserContentController *wkUController = [[WKUserContentController alloc] init];
        _wkConfig.userContentController = wkUController;
    }
    return _wkConfig;
}
- (WKWebView *)wkWebView {
    if (!_wkWebView) {
        _wkWebView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:self.wkConfig];
        _wkWebView.navigationDelegate = self;
        _wkWebView.UIDelegate = self;
        _wkWebView.backgroundColor = kNavWhiteColor;
        _wkWebView.autoresizesSubviews = YES;
    }
    return _wkWebView;
}
- (void)startLoad {
    NSURLRequest * request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://xd.dev.deepvision.link/app/contract.html?orderNo=%@",self.orderNo]]
                                                  cachePolicy:NSURLRequestUseProtocolCachePolicy
                                              timeoutInterval:15.0f];
    [self.wkWebView loadRequest:request];
}
- (void)dealloc {
    [self.wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.wkWebView removeObserver:self forKeyPath:@"title" context:nil];
}
- (void)viewWillAppear:(BOOL)animated {
    [self.wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [self.wkWebView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
}
#pragma mark - 监听
/*
 *在监听方法中获取网页加载的进度，并将进度赋给progressView.progress
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.progressView.progress = self.wkWebView.estimatedProgress;
        if (self.progressView.progress == 1) {
            __weak typeof (self)weakSelf = self;
            [UIView animateWithDuration:0.25f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                weakSelf.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.4f);
            } completion:^(BOOL finished) {
                weakSelf.progressView.hidden = YES;
            }];
        }
    } else if ([keyPath isEqualToString:@"title"]) {
        if (object == self.wkWebView)
        {
            self.navigationBar.title = self.wkWebView.title;
        }
        else {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - WKWKNavigationDelegate Methods

/*
 *.在WKWebViewd的代理中展示进度条，加载完成后隐藏进度条
 */

//开始加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    //开始加载网页时展示出progressView
    self.progressView.hidden = NO;
    //开始加载网页的时候将progressView的Height恢复为1.5倍
    self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
    //防止progressView被网页挡住
    [self.view bringSubviewToFront:self.progressView];
}

//加载完成
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    //加载完成后隐藏progressView
    self.progressView.hidden = YES;
}
//加载失败
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    self.progressView.hidden = YES;
}
//页面跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    decisionHandler(WKNavigationActionPolicyAllow);
    NSString *url = navigationAction.request.URL.absoluteString;
        @try {
            if ([url containsString:@"contractsignresult"]) {
                if ([[url componentsSeparatedByString:@":"][1] isEqualToString:@"success"]) {
                    //签署成功
//                    [self alert:@"签署成功"];
                }else {
                    //签署失败
//                   [self alert:[NSString stringWithFormat:@"%@",[url componentsSeparatedByString:@"message="][1]]];
                }
            }
        } @catch (NSException *exception) {
            NSLog(@"%@",exception);
    }
}
@end
