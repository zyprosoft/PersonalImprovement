//
//  FileManagerVCtrl.m
//  PersonalImprovement
//
//  Created by xiong有都 on 16/7/21.
//  Copyright © 2016年 xiong有都. All rights reserved.
//

#import "FileManagerVCtrl.h"
#import "FCFileManager.h"

@interface FileManagerVCtrl ()

@end

@implementation FileManagerVCtrl

- (void)viewDidLoad {
    [super viewDidLoad];

    //my file path, this will be automatically used as it's relative to the Documents directory
    NSString *testPath = @"test.txt";
    //my file path relative to the temporary directory path
    NSString *testPathTemp = [FCFileManager pathForTemporaryDirectoryWithPath:testPath];
    
    /*
     All shortcuts suppported:
     
     pathForApplicationSupportDirectory;
     pathForCachesDirectory;
     pathForDocumentsDirectory;
     pathForLibraryDirectory;
     pathForMainBundleDirectory;
     pathForPlistNamed:(NSString *)name; //look for {{ name }}.plist in the main bundle directory
     pathForTemporaryDirectory;
     */
    
    //copy file from Documents directory (public) to ApplicationSupport directory (private)
    NSString *testPath1 = [FCFileManager pathForApplicationSupportDirectoryWithPath:@"test-copy.txt"];
    [FCFileManager copyItemAtPath:@"test.txt" toPath:testPath1];
    
    //create file and write content to it (if it doesn't exist)
    [FCFileManager createFileAtPath:@"test.txt" withContent:@"File management has never been so easy!!!"];
    
    //create directories tree for the given path (in this case in the Documents directory)
    [FCFileManager createDirectoriesForPath:@"/a/b/c/d/"];
    
    //check if file exist and returns YES or NO
    BOOL testFileExists = [FCFileManager existsItemAtPath:@"test.txt"];
    
    //move file from a path to another and returns YES or NO
    [FCFileManager moveItemAtPath:@"test.txt" toPath:@"tests/test.txt"];
    
    //read file from path and returns its content (NSString in this case)
    NSString *test = [FCFileManager readFileAtPath:@"test.txt"];
    
    //returns the string-value stored for the specified key, if the key doesn't exist returns nil
    NSString *value = [FCFileManager xattrOfItemAtPath:@"test.txt" getValueForKey:@"uploaded"];
    
    //set the specified string-value and returns a BOOL result of the operation
    BOOL success = [FCFileManager xattrOfItemAtPath:@"test.txt" setValue:@"1" forKey:@"uploaded"];
    
    //read image file from path and returns its EXIF data
    NSDictionary *exifData = [FCFileManager exifDataOfImageAtPath:@"test.jpg"];
    
    
    //remove file at the specified path
    [FCFileManager removeItemAtPath:@"test.txt"];
    
    
    //rename file at the specified path with the new name
    [FCFileManager renameItemAtPath:@"test.txt" withName:@"test-renamed.txt"];
    
    
    NSArray *testContent = [NSArray arrayWithObjects:@"t", @"e", @"s", @"t", nil];
    
    //write file at the specified path with content
    [FCFileManager writeFileAtPath:@"test.txt" content:testContent];
    
    
    //get the file size in bytes
    NSNumber *fileSize = [FCFileManager sizeOfFileAtPath:@"test.txt"];
    
    //get the directory size in bytes (including all subdirectories and files inside it)
    NSNumber *directorySize = [FCFileManager sizeOfDirectoryAtPath:@"/a/"];
    
    
    //returns a human-readable file size formatted with the necessary suffix: bytes, KB, MB, GB, TB
    NSString *fileSizeFormatted = [FCFileManager sizeFormattedOfFileAtPath:@"test.txt"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
