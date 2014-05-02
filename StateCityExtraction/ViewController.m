//
//  ViewController.m
//  StateCityExtraction
//
//  Created by Firdous on 30/04/2014.
//  Copyright (c) 2014 TenPearls. All rights reserved.
//

//TO IMPLEMENT
//http://stackoverflow.com/questions/2444975/import-csv-data-sdk-iphone
//http://www.mapsofworld.com/usa/zipcodes/colorado/

#import "ViewController.h"
#import "ZeeSQLiteHelper.h"
#import "CHCSVParser.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"zip_code_database" ofType:@"csv"];
    NSError *error = nil;

    NSArray *rows = [NSArray arrayWithContentsOfCSVFile:filePath];
    
    if (rows == nil) {
        NSLog(@"error parsing file: %@", error);
        return;
    }

    [ZeeSQLiteHelper initializeSQLiteDB];
    
    for (NSArray *row in rows) {
        NSString *queryFormat = [NSString stringWithFormat:@"insert into rawData (zip,type,primary_city,acceptable_cities,unacceptable_cities,state,county,timezone,area_codes,latitude,longitude,world_region,country,decommission,estimated_population,notes) VALUES(%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@)", [self getQuotedString:[row objectAtIndex:0]],[self getQuotedString:[row objectAtIndex:1]],[self getQuotedString:[row objectAtIndex:2]],[self getQuotedString:[row objectAtIndex:3]],[self getQuotedString:[row objectAtIndex:4]],[self getQuotedString:[row objectAtIndex:5]],[self getQuotedString:[row objectAtIndex:6]],[self getQuotedString:[row objectAtIndex:7]],[self getQuotedString:[row objectAtIndex:8]],[self getQuotedString:[row objectAtIndex:9]],[self getQuotedString:[row objectAtIndex:10]],[self getQuotedString:[row objectAtIndex:11]],[self getQuotedString:[row objectAtIndex:12]],[self getQuotedString:[row objectAtIndex:13]],[self getQuotedString:[row objectAtIndex:14]],[self getQuotedString:[row objectAtIndex:15]]];
        
        [ZeeSQLiteHelper executeQuery:queryFormat];
    }
    
    [ZeeSQLiteHelper closeDatabase];
}

- (NSString*)getQuotedString:(NSString*)string{
    string = [string stringByReplacingOccurrencesOfString:@"'"
                                         withString:@"''"];
    
    return [NSString stringWithFormat:@"'%@'", string];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
