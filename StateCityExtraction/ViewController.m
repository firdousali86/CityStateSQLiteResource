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

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSMutableArray *contentArray = [NSMutableArray array];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"zip_code_database" ofType:@"csv"];
    NSString *Data = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil ];
    if (Data)
    {
        NSArray *records = [Data componentsSeparatedByString:@",eotl"];
        NSInteger idx;
        for (idx = 0; idx < records.count; idx++) {
            //zip,type,primary_city,acceptable_cities,unacceptable_cities,state,county,timezone,area_codes,latitude,longitude,world_region,country,decommissioned,estimated_population
            NSString *data =[records objectAtIndex:idx];
            NSLog(@"DSFGLKJ SDFG: %@", data);
            NSArray *fields = [data componentsSeparatedByString:@","];
            
            NSString *queryFormat = [NSString stringWithFormat:@"insert into rawData (zip,type,primary_city,acceptable_cities,unacceptable_cities,state,county,timezone,area_codes,latitude,longitude,world_region,country,decommissioned,estimated_population) VALUES(%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@)", [self getQuotedString:[fields objectAtIndex:0]],[self getQuotedString:[fields objectAtIndex:1]],[self getQuotedString:[fields objectAtIndex:2]],[self getQuotedString:[fields objectAtIndex:3]],[self getQuotedString:[fields objectAtIndex:4]],[self getQuotedString:[fields objectAtIndex:5]],[self getQuotedString:[fields objectAtIndex:6]],[self getQuotedString:[fields objectAtIndex:7]],[self getQuotedString:[fields objectAtIndex:8]],[self getQuotedString:[fields objectAtIndex:9]],[self getQuotedString:[fields objectAtIndex:10]],[self getQuotedString:[fields objectAtIndex:11]],[self getQuotedString:[fields objectAtIndex:12]],[self getQuotedString:[fields objectAtIndex:13]],[self getQuotedString:[fields objectAtIndex:14]]];
            
            //NSString *query = @"insert into rawData (zip,type,primary_city,acceptable_cities,unacceptable_cities,state,county,timezone,area_codes,latitude,longitude,world_region,country,decommissioned,estimated_population) VALUES(%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@)";
            [ZeeSQLiteHelper initializeSQLiteDB];
            [ZeeSQLiteHelper executeQuery:queryFormat];
            [ZeeSQLiteHelper closeDatabase];
        }
        
        
        
    }
}

- (NSString*)getQuotedString:(NSString*)string{
    return [NSString stringWithFormat:@"'%@'", string];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
