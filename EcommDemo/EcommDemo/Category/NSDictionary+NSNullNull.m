//
//  NSObject+NSDictionary_NSNullNull.m
//  Bownce
//
//  Created by craftsvilla on 15/11/16.
//  Copyright © 2016 Jignesh Agola. All rights reserved.
//


#import "NSDictionary+NSNullNull.h"

@implementation NSDictionary (NSNullNull)

- (id)getNilOrobjectForKey:(id)aKey;
{
    id object = [self objectForKey:aKey];
    
    if ([object isEqual:[NSNull null]]) {
        return nil;
    }
    
    return object;
}

- (NSString *)getJsonString{
    
    NSString *jsonString = @"";
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    
    if (! jsonData) {
        
        jsonString = error.localizedDescription;
        
    } else {
        
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    return jsonString;
}


@end

