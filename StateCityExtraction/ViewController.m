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
        NSArray *myText = [Data componentsSeparatedByString:@"eol"];
        NSInteger idx;
        for (idx = 0; idx < myText.count; idx++) {
            NSString *data =[myText objectAtIndex:idx];
            NSLog(@"%@", data);
            id x = [NSNumber numberWithFloat:0+idx*0.002777778];
            id y = [NSDecimalNumber decimalNumberWithString:data];
            [contentArray addObject:
             [NSMutableDictionary dictionaryWithObjectsAndKeys:x, @"x", y, @"y",nil]];
        }
        
        NSLog(@"FGSDFGSDFG: %@", contentArray);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
