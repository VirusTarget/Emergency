//
//  EmergencyViewController.m
//  aaaaa
//
//  Created by 陈晋添 on 2018/3/1.
//  Copyright © 2018年 陈晋添. All rights reserved.
//

#import "EmergencyViewController.h"

@interface EmergencyViewController ()
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) UIImage *image;
@end

@implementation EmergencyViewController

- (instancetype)initWithUrl:(NSURL *)url {
    if (self = [self init]) {
        self.url = url;
    }
    return self;
}

- (instancetype)initWithPic:(UIImage *)image {
    if (self = [self init]) {
        self.image = image;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.url) {
        [self loadUrl];
    }
    if (self.image) {
        [self loadPic];
    }
    // Do any additional setup after loading the view.
}

- (void)loadUrl {
    self.webView = [[UIWebView alloc] init];
    [self.webView loadRequest:[NSURLRequest requestWithURL:self.url]];
    [self.view addSubview:self.webView];
    self.webView.frame = self.view.bounds;
}

- (void)loadPic {
    self.imageView = [[UIImageView alloc] init];
    [self.view addSubview:self.imageView];
    self.imageView.contentMode = UIViewContentModeCenter;
    self.imageView.image = self.image;
}

@end
