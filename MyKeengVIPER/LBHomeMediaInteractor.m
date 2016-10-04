//
//  LBHomeMediaInteractor.m
//  MyKeengVIPER
//
//  Created by Le Van Binh on 10/3/16.
//  Copyright © 2016 LBComp. All rights reserved.
//

#import "LBHomeMediaInteractor.h"
#import <AFNetworking.h>
#import "LBMedia.h"
#import "LBSong.h"
#import "LBVideo.h"

@implementation LBHomeMediaInteractor

-(void)getListMedia:(int)page size:(int)size willGetDataType:(LBMediaType)dataType {
    
    __block NSMutableArray<LBMedia *> *medias = [[NSMutableArray alloc] init];
    __weak LBHomeMediaInteractor *weakself = self;
    
    NSDictionary *parameters = @{@"page": [NSNumber numberWithInteger:page], @"num": [NSNumber numberWithInteger:size]};
    
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:KEENG_WS_BASE_URL]];
    [manager.responseSerializer setAcceptableContentTypes:[manager.responseSerializer.acceptableContentTypes setByAddingObjectsFromSet:[NSSet setWithObjects:@"text/html", @"text/plain",nil]]];
    manager.completionQueue = dispatch_queue_create("lb.mykeeng.AFCompletionQueue", DISPATCH_QUEUE_CONCURRENT);
    
    
    NSURLSessionDataTask *task = [manager GET:KEENG_WS_API_GET_HOME parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"Get data done:%d-%d", page, size);
        
        NSError *error = nil;
        
        NSArray *results = (NSArray*)[responseObject objectForKey:@"data"];
        
        for (NSDictionary *mediaDic in results) {
            
            if ([[mediaDic valueForKey:@"item_type"] integerValue] == 1) { //song
                
                if ((dataType & LBMediaTypeSong) == LBMediaTypeSong) {
                    
                    LBSong *song = (LBSong *)[MTLJSONAdapter modelOfClass:[LBSong class] fromJSONDictionary:mediaDic error:&error];
                    
                    if (song != nil) {
                        
                        [medias addObject:song];
                    } else {
                        
                        NSLog(@"Error convert Json %@: %@", song.url, error);
                    }
                }
            } else if ([[mediaDic valueForKey:@"item_type"] integerValue] == 3) { //video
                
                if((dataType & LBMediaTypeVideo) == LBMediaTypeVideo) {
                    
                    LBVideo *video = (LBVideo *)[MTLJSONAdapter modelOfClass:[LBVideo class] fromJSONDictionary:mediaDic error:&error];
                    
                    if (video != nil)
                    {
                        
                        [medias addObject:video];
                    } else {
                        
                        NSLog(@"Error convert Json %@: %@", video.url, error);
                    }
                }
            }
        }
        
        [weakself.selfDelegate gotListMedia:medias willGetdataType:dataType error:nil];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [weakself.selfDelegate gotListMedia:nil willGetdataType:dataType error:error];
        
    }];
    
    [task resume];
}


@end
