//
//  ConnectionDelegate.m
//  blueBoardPhone
//
//  Created by Kristof Dreier on 09.08.10.
//  Copyright 2010. All rights reserved.
//

#import "ConnectionDelegate.h"
#import "ParseOperation.h"
#import <CFNetwork/CFNetwork.h>

@implementation ConnectionDelegate

@synthesize viewController, parser, queue, listConnection, listData, entries;

- (id)initWithURL:(NSURL *)theURL 
		   parser:(ParseOperation *)theParser 
   viewController:(UITableViewController *)theController
{
    self = [super init];
	
    
	if (self != nil) {
		NSURLRequest *urlRequest = [NSURLRequest requestWithURL:theURL];
		self.listConnection = [[[NSURLConnection alloc] initWithRequest:urlRequest delegate:self] autorelease];
		NSAssert(self.listConnection != nil, @"Failure to create URL connection.");
		
		self.parser = [theParser initWithDelegate:self];
		self.viewController = theController;
		
		self.entries = [NSMutableArray array];
		[viewController setEntries:self.entries];
		
		[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;	
    }
	
    return self;
}

- (void)handleLoadedEntries:(NSArray *)entriesList
{
    [self.entries addObjectsFromArray:entriesList];
    
    [[viewController tableView] reloadData];
}

- (void)didFinishParsing:(NSArray *)entriesList
{
    [self performSelectorOnMainThread:@selector(handleLoadedEntries:) withObject:entriesList waitUntilDone:NO];
    
    self.queue = nil;
}

- (void)parseErrorOccurred:(NSError *)error
{
    [self performSelectorOnMainThread:@selector(handleError:) withObject:error waitUntilDone:NO];
}

#pragma mark -
#pragma mark NSURLConnection delegate methods

- (void)handleError:(NSError *)error
{
    NSString *errorMessage = [error localizedDescription];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Cannot Show Board List"
														message:errorMessage
													   delegate:nil
											  cancelButtonTitle:@"OK"
											  otherButtonTitles:nil];
    [alertView show];
    [alertView release];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.listData = [NSMutableData data];    // start off with new data
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [listData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    if ([error code] == kCFURLErrorNotConnectedToInternet) {
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"No Connection Error"
															 forKey:NSLocalizedDescriptionKey];
        NSError *noConnectionError = [NSError errorWithDomain:NSCocoaErrorDomain
														 code:kCFURLErrorNotConnectedToInternet
													 userInfo:userInfo];
        [self handleError:noConnectionError];
    } else {
        [self handleError:error];
    }
    
    self.listConnection = nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    self.listConnection = nil;
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;   
    
    self.queue = [[NSOperationQueue alloc] init];
	
	[parser setDataToParse:listData];
    
    [queue addOperation:parser];
    [parser release];
	self.listData = nil;
}

@end
