//
//  RootViewController.m
//  blueBoardPhone
//
//  Created by Kristof Dreier on 04.08.10.
//  Copyright 2010. All rights reserved.
//

#import "RootViewController.h"
#import "ThreadViewController.h"
#import "SectionRecord.h"
#import "SectionParserOperation.h"
#import "ConnectionDelegate.h"

#define kCustomRowHeight    60.0
#define kCustomRowCount     7

static NSString *const BoardsOverviewURL = @"http://forum.mods.de/bb/xml/boards.php";

#pragma mark -

@implementation RootViewController

@synthesize entries, connection;

#pragma mark 

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.tableView.rowHeight = kCustomRowHeight;
	self.title = @"mods.de";
	self.connection = [[ConnectionDelegate alloc] initWithURL:[NSURL URLWithString:BoardsOverviewURL]
																	  parser:[SectionParserOperation alloc]
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
    } else {
		count = [[[entries objectAtIndex:section] boardRecords] count];
	}
	
    return count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	int count = [entries count];
	
	// ff there's no data yet, return enough rows to fill the screen
    if (count == 0)	{
        return 1;
    } else {
		count = [entries count];
	}
	
    return count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	if ([entries count] > 0) {
		return [[entries objectAtIndex:section] name];		
	} else {
		return @"";
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	// customize the appearance of table view cells
	//
	static NSString *CellIdentifier = @"BoardViewCell";
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
		
		cell.detailTextLabel.text = @"Lade Foren…";
		
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
        BoardRecord *boardRecord = [[[entries objectAtIndex:indexPath.section] boardRecords] objectAtIndex:indexPath.row];
        
		cell.textLabel.text = [boardRecord name];
        cell.detailTextLabel.text = [boardRecord description];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ThreadViewController *threadViewController = [[ThreadViewController alloc] initWithNibName:@"ThreadViewController" bundle:nil];
	threadViewController.title = [[[[entries objectAtIndex:indexPath.section] boardRecords] objectAtIndex:indexPath.row] name];
	threadViewController.boardId = [[[[entries objectAtIndex:indexPath.section] boardRecords] objectAtIndex:indexPath.row] boardId];
	
	[self.navigationController pushViewController:threadViewController animated:YES];
	[threadViewController release];
}

@end

