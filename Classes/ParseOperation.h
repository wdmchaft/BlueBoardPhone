//
//  ParseOperation.h
//  blueBoardPhone
//
//  Created by Kristof Dreier on 08.08.10.
//  Copyright 2010. All rights reserved.


@protocol ParseOperationDelegate;

@interface ParseOperation : NSOperation <NSXMLParserDelegate> {
    id <ParseOperationDelegate> delegate;
    
    NSData          *dataToParse;
    
    NSMutableArray  *workingArray;
    id workingEntry;
    NSMutableString *workingPropertyString;
    NSArray         *elementsToParse;
    BOOL            storingCharacterData;
}

- (id)initWithData:(NSData *)data delegate:(id <ParseOperationDelegate>)theDelegate elementsToParse:(NSArray *)theElements;
- (id)initWithDelegate:(id <ParseOperationDelegate>)theDelegate elementsToParse:(NSArray *)theElements;

@property (nonatomic, assign) id <ParseOperationDelegate> delegate;
@property (nonatomic, retain) NSData *dataToParse;
@property (nonatomic, retain) NSMutableArray *workingArray;
@property (nonatomic, retain) id workingEntry;
@property (nonatomic, retain) NSMutableString *workingPropertyString;
@property (nonatomic, retain) NSArray *elementsToParse;
@property (nonatomic, assign) BOOL storingCharacterData;

@end


@protocol ParseOperationDelegate
- (void)didFinishParsing:(NSArray *)appList;
- (void)parseErrorOccurred:(NSError *)error;
@end
