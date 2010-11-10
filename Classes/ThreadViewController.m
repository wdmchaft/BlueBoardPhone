//
//  ThreadViewController.m
//  blueBoardPhone
//
//  Created by Kristof Dreier on 09.08.10.
//  Copyright 2010. All rights reserved.
//

#import "ThreadViewController.h"
#import "PostViewController.h"
#import "ThreadParserOperation.h"
#import "ConnectionDelegate.h"

#define kCustomRowHeight    60.0
#define kCustomRowCount     7

static NSString *const ThreadsOverviewURL = @"http://forum.mods.de/bb/xml/board.php?BID=%d";

@implementation ThreadViewController

@synthesize boardId, connection, entries;

#pragma mark 

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.tableView.rowHeight = kCustomRowHeight;
	self.connection = [[ConnectionDelegate alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:ThreadsOverviewURL, self.boardId]]
													   parser:[ThreadParserOperation alloc]
											   viewController:self];
}

- (void)dealloc
{
    [entries release];
	[connection release];
    
    [super dealloc];
}

#pragma mark -
#pragma mark Table view creation (UITableViewDataSource)

// customize the number of rows in the table view
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	int count = [entries count];
	
	// ff there's no data yet, return enough rows to fill the screen
    if (count == 0)	{
        return kCustomRowCount;
    }
	
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	// customize the appearance of table view cells
	//
	static NSString *CellIdentifier = @"ThreadViewCell";
    static NSString *PlaceholderCellIdentifier = @"PlaceholderCell";
    
    // add a placeholder cell while waiting on table data
    int nodeCount = [entries count];
	
	if (nodeCount == 0 && indexPath.row == 0)
	{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PlaceholderCellIdentifier];
        if (cell == nil)
		{
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
										   reuseIdentifier:PlaceholderCellIdentifier] autorelease];   
            cell.detailTextLabel.textAlignment = UITextAlignmentCenter;
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
		
		cell.detailTextLabel.text = @"Lade Threads…";
		
		return cell;
    }
	
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
	{
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
									   reuseIdentifier:CellIdentifier] autorelease];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
	
    // Leave cells empty if there's no data yet
	
    if (nodeCount > 0)
	{
        // Set up the cell...
        ThreadRecord *threadRecord = [entries objectAtIndex:indexPath.row];
        
		cell.textLabel.text = [threadRecord title];
        cell.detailTextLabel.text = [threadRecord subtitle];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PostViewController *postViewController = [[PostViewController alloc] initWithNibName:@"PostViewController" bundle:nil];
	postViewController.title = [[entries objectAtIndex:indexPath.row] title];
	postViewController.threadId = [[entries objectAtIndex:indexPath.row] threadId];
	
	[self.navigationController pushViewController:postViewController animated:YES];
	[postViewController release];
}

@end

