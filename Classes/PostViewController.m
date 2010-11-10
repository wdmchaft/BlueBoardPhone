//
//  PostViewController.m
//  blueBoardPhone
//
//  Created by Kristof Dreier on 09.08.10.
//  Copyright 2010. All rights reserved.
//

#import "PostViewController.h"
#import "PostParserOperation.h"
#import "BBPostEntryCell.h"
#import "ConnectionDelegate.h"
#import "StringHelper.h" 

#define kCustomRowHeight 60.0
#define kCustomRowCount 7
#define kTextViewFontSize 14.0

static NSString *const PostsOverviewURL = @"http://forum.mods.de/bb/xml/thread.php?TID=%d";

@implementation PostViewController

@synthesize threadId, connection, entries;

#pragma mark 

- (void)viewDidLoad
{
    [super viewDidLoad];	
    self.tableView.rowHeight = kCustomRowHeight;
	
	self.connection = [[ConnectionDelegate alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:PostsOverviewURL, self.threadId]]
													   parser:[PostParserOperation alloc]
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

- (CGFloat)calculateHeightOfText:(NSString *)myString fromWidth:(CGFloat)myWidth withFont:(UIFont *)mySize {
	CGSize boundingSize = CGSizeMake(myWidth, CGFLOAT_MAX);
    CGSize requiredSize = [myString sizeWithFont:mySize constrainedToSize:boundingSize lineBreakMode:UILineBreakModeWordWrap];

    return requiredSize.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	// customize the appearance of table view cells
	//
	static NSString *CellIdentifier = @"PostViewCell";
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
		
		cell.detailTextLabel.text = @"Lade Posts…";
		
		return cell;
    }
		
	
	BBPostEntryCell *cell = (BBPostEntryCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"BBPostEntryCell" 
                                                     owner:self options:nil];
        for (id oneObject in nib)
            if ([oneObject isKindOfClass:[BBPostEntryCell class]])
                cell = (BBPostEntryCell *)oneObject;
	}
	
	if (nodeCount > 0) {
		PostRecord *postRecord = [entries objectAtIndex:indexPath.row];
		CGFloat width = [UIScreen mainScreen].bounds.size.width - 20;
		CGFloat height = [[postRecord content] RAD_textHeightForSystemFontOfSize:kTextViewFontSize] + 10.0;
		
		[cell.contentView setFrame:CGRectMake(10.0f, 37.0f, width, height)];
		
		NSString *path = [[NSBundle mainBundle] bundlePath];
		NSURL *baseURL = [NSURL fileURLWithPath:path];
		
		NSString *parsedContent = [NSString stringByReplacingOccurrencesOfString:(NSString *)[postRecord content] withString:(NSString *)replacement
		
		NSString *contentWithStyle = [NSString stringWithFormat:@"<html><head><link href=\"style.css\" rel=\"stylesheet\" type=\"text/css\"></head><body>%@</body></html>", [postRecord content]];
		
		[cell.contentView loadHTMLString:contentWithStyle baseURL:baseURL];

		cell.authorLabel.text = [[postRecord user] nickname];
	}
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {  
    if ([entries count] > 0) {
		NSString *label = [[entries objectAtIndex:indexPath.row] content];
		CGFloat height = [label RAD_textHeightForSystemFontOfSize:kTextViewFontSize] + 60.0;
		
		return height;	
	}
	
	return 60.0;
}

@end

