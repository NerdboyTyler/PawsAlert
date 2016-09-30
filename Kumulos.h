//
//  Kumulos.h
//  Kumulos
//
//  Created by Kumulos Bindings Compiler on Feb  5, 2016
//  Copyright Stillwater Animal Welfare Coalition All rights reserved.
//

#import <Foundation/Foundation.h>
#import "libKumulos.h"


@class Kumulos;
@protocol KumulosDelegate <kumulosProxyDelegate>
@optional

 
- (void) kumulosAPI:(Kumulos*)kumulos apiOperation:(KSAPIOperation*)operation getFosterTableDidCompleteWithResult:(NSArray*)theResults;
 
- (void) kumulosAPI:(Kumulos*)kumulos apiOperation:(KSAPIOperation*)operation createLostFoundTableDidCompleteWithResult:(NSNumber*)newRecordID;
 
- (void) kumulosAPI:(Kumulos*)kumulos apiOperation:(KSAPIOperation*)operation getLostFoundTableDidCompleteWithResult:(NSArray*)theResults;
 
- (void) kumulosAPI:(Kumulos*)kumulos apiOperation:(KSAPIOperation*)operation getPetItemsTableDidCompleteWithResult:(NSArray*)theResults;
 
- (void) kumulosAPI:(Kumulos*)kumulos apiOperation:(KSAPIOperation*)operation getSuccessTableDidCompleteWithResult:(NSArray*)theResults;

@end

@interface Kumulos : kumulosProxy {
    NSString* theAPIKey;
    NSString* theSecretKey;
}

-(Kumulos*)init;
-(Kumulos*)initWithAPIKey:(NSString*)APIKey andSecretKey:(NSString*)secretKey;

   
 -(KSAPIOperation*) getFosterTable;
   
-(KSAPIOperation*) createLostFoundTableWithTitle:(NSString*)title andName:(NSString*)name andDetails:(NSString*)details andImageData:(NSData*)imageData;
    
   
 -(KSAPIOperation*) getLostFoundTable;
   
 -(KSAPIOperation*) getPetItemsTable;
   
 -(KSAPIOperation*) getSuccessTable;
            
@end