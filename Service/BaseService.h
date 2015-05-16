//
//  BaseService.h
//  IB Checker
//
//  Created by Thanh on 5/11/15.
//  Copyright (c) 2015 Puganda_Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@class BaseService;
@protocol ServiceDelegate <NSObject>

- (void) startRequest:(BaseService *)service;
- (void) finishRequest:(BaseService *)service;
- (void) successRequest:(BaseService *)service response:(NSDictionary *) data;
- (void) failRequest:(BaseService *)service response:(NSDictionary *) data;

@end

@interface BaseService : NSObject
@property (weak) id<ServiceDelegate> delegate;
@property (strong) NSString *authtoken;

- (id) initWithDelegate:(id<ServiceDelegate>) delegate authtoken:(NSString *)authtoken;

- (void) get:(NSString *)path params:(NSDictionary *)params;
- (void) post:(NSString *)path params:(NSDictionary *)params;
- (void) put:(NSString *)path params:(NSDictionary *)params;

- (BOOL) parser:(NSDictionary *)data context:(NSManagedObjectContext *) context;

@end
