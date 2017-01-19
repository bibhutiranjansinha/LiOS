//
//  LRDocumentViewController.h
//  Leerink
//
//  Created by Ashish on 11/09/2014.
//  Copyright (c) 2014 leerink. All rights reserved.
//

#import "LRLoadDataDelegate.h"
#import <AVFoundation/AVFoundation.h>
#import "DBManager.h"

@interface LRDocumentViewController : UIViewController<LRLoadDataDelegate,UIDocumentInteractionControllerDelegate,NSURLSessionDataDelegate,UIWebViewDelegate,AVAudioPlayerDelegate>

@property (nonatomic, assign) id <LRLoadDataDelegate> delegate;
@property (nonatomic, strong) NSString *documentTitleToBeSavedAsPdf;
@property (nonatomic, strong) NSString *documentId;
@property (nonatomic, assign) BOOL isAudioFilePlayed;
@property (nonatomic, assign) eLRDocumentTypeWebView documentTypeWebView;
@property (nonatomic, strong) NSString *documentType;
@property (nonatomic, strong) NSString *documentPath;
@property (nonatomic, strong) NSString *mp3Content;
- (void)fetchDocument;
- (void)setAudioToPause;
@end
