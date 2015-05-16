//
//  BaseService.m
//  IB Checker
//
//  Created by Thanh on 5/11/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import "BaseService.h"
#import "AFHTTPRequestOperationManager.h"
#import "Constant.h"
#import "Item.h"
#import "NSDictionary+Extra.h"

@implementation BaseService
- (id) initWithDelegate:(id<ServiceDelegate>) delegate authtoken:(NSString *)authtoken{
    self = [super init];
    if (self) {
        _authtoken = authtoken;
        _delegate = delegate;
    }
    return self;
}

- (BOOL) parser:(NSDictionary *)data context:(NSManagedObjectContext *) context {
    return NO;
}

- (void) success:(id) response headers:(NSDictionary *)headers {

    NSString *authToken = [headers stringForKey:@"authtoken"];
    
    NSMutableDictionary *content = nil;
    if ([[response valueForKey:@"content"] isKindOfClass:[NSDictionary class]]) {
        content = [[NSMutableDictionary alloc] initWithDictionary:[response valueForKey:@"content"]];
    } else {
        content = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[response valueForKey:@"content"], @"content", nil];
    }
    
    if (authToken && ![authToken isEqualToString:@""]) {
        [content setValue:authToken forKey:@"authtoken"];
    }
    
    NSLog(@"Response: %@", content);
    if (_delegate) {
        [_delegate successRequest:self response:content];
        [_delegate finishRequest:self];
    }
}

- (void) fail:(NSError *)error {
    NSLog(@"Error: %@", error);
    if (_delegate) {
        [_delegate failRequest:self response:nil];
        [_delegate finishRequest:self];
    }
}

- (void) addParams:(NSDictionary *) params request:(AFHTTPRequestOperationManager *) manager {
    if (_delegate) {
        [_delegate startRequest:self];
    }
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    for (NSString *key in params.allKeys) {
        NSLog(@"%@", [params objectForKey:key]);
        [manager.requestSerializer setValue:[params objectForKey:key] forHTTPHeaderField:key];
    }
    if (_authtoken) {
        NSLog(@"token: %@", _authtoken);
        [manager.requestSerializer setValue:_authtoken forHTTPHeaderField:@"authtoken"];
    }
}

- (void)get:(NSString *)path params:(NSDictionary *)params {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [self addParams:params request:manager];
    [manager GET:[NSString stringWithFormat:@"%@%@", URL_SERVER, path] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self success:responseObject headers:operation.response.allHeaderFields];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self fail:error];
    }];
    
}

- (void)post:(NSString *)path params:(NSDictionary *)params {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [self addParams:params request:manager];
    [manager POST:[NSString stringWithFormat:@"%@%@", URL_SERVER, path] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self success:responseObject headers:operation.response.allHeaderFields];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self fail:error];
    }];
}

- (void)put:(NSString *)path params:(NSDictionary *)params {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [self addParams:params request:manager];
    [manager PUT:[NSString stringWithFormat:@"%@%@", URL_SERVER, path] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self success:responseObject headers:operation.response.allHeaderFields];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self fail:error];
    }];
    
}

- (void)delete:(NSString *)path params:(NSDictionary *)params {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [self addParams:params request:manager];
    [manager DELETE:[NSString stringWithFormat:@"%@%@", URL_SERVER, path] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self success:responseObject headers:operation.response.allHeaderFields];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self fail:error];
    }];
}
@end
