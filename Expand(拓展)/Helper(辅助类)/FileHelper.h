//
//  FileHelper.h
//  MiniPC
//
//  Created by xiongyoudou on 16/5/25.
//  Copyright © 2016年 xiongyoudou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileHelper : NSObject
/**
 *  Plist沙盒文件操作工具类方法 ：
 *  1、写文件（已存在文件名再写会覆盖）：+ (void)writeDictDataToPlistFile:(NSMutableDictionary *)aSaveDic fileName:(NSString *)fileName;
 *  @param aSaveDic  需保存的可变字典
 *  @param fileName 文件名称
 
 *  2、Plist取文件：                 + (NSMutableDictionary *)getPListFileData:(NSString *)fileName;
 *  @param fileName 文件名称
 *  @return 返回文件名称的可变字典
 
 *  3、获取文件路径：                 + (NSString *)getFileNamePath:(NSString *)fileName;
 *  @param fileName 文件名称（存在即取，不存在即创建并取出）
 *  @return 返回文件路径
 
 *  4、沙盒是否存在此文件：            + (BOOL)isExistAtDocumentFile:(NSString *)fileName;
 *  @param fileName 文件名
 *  @return 存在返回Yes
 
 *  5、沙盒文件删除：                 + (void)deleteDocumentFile:(NSString *)fileName;
 *  @param fileName 文件名
 
 *  6、获取/创建文件夹路径（并加参数设置文件名，后缀）：                 + (NSString *)getFolderNamePath:(NSString *)folderName fileName:(NSString *)fileName PathExtension:(NSString *)pathExtension;
 *  @param folderName 文件夹名称（存在即取，不存在即创建并取出）
 *  @param fileName 文件名称（
 *  @param pathExtension 后缀
 *  @return 返回文件路径（fileName 和 pathExtension 同时不为nil才获取文件路径，否则只获取文件夹路径）
 
 *  7、沙盒文件删除：                 + (BOOL)deleteWithContentPath:(NSString *)path;
 *  @param path 文件路径
 *  @return 删除成功返回YES
 */
+ (void)writeDictDataToPlistFile:(NSMutableDictionary *)aSaveDic fileName:(NSString *)fileName;
+ (NSMutableDictionary *)getPListFileData:(NSString *)fileName;
+ (void)createFilePahtIfNotExists:(NSString *)path;
+ (NSString *)getFileNamePath:(NSString *)fileName;
+ (BOOL)isExistAtDocumentFile:(NSString *)fileName;
+ (BOOL)isExistAtPath:(NSString *)filePath;
+ (void)deleteDocumentFile:(NSString *)fileName;
+ (NSString *)getFolderNamePath:(NSString *)folderName fileName:(NSString *)fileName PathExtension:(NSString *)pathExtension;
+ (BOOL)deleteWithContentPath:(NSString *)path;
+ (BOOL)saveFileToDocument:(NSData *)fileData withFileName:(NSString *)fileName;
+ (BOOL)deleteFileWithFileName:(NSString *)fileName isUpload:(BOOL)isUpload;
+ (UIImage *)getImageWithFileName:(NSString *)fileName isUpload:(BOOL)isUpload isThumb:(BOOL)isThumb completion:(void (^)(UIImage *image))completion;
+ (void)getVideoImageUploadWithFileName:(NSString *)fileName completion:(void (^)(UIImage *img))completion;
+ (void)getVideoImageDownloadWithDownloadPath:(NSString *)filePath isSuccess:(BOOL)isSuccess completion:(void (^)(UIImage *img))completion;
+ (NSString *)getUploadFilePathWithFileName:(NSString *)fileName;
+ (NSString *)getDownloadFilePathWithFilePath:(NSString *)filePath isSave:(BOOL)isSave;
+ (FileType)getFileTypeWithFileName:(NSString *)fileName isFolder:(BOOL)isFolder;
+ (UIImage *)getIconImageWithFileType:(FileType)fileType;
+ (NSString *)getFileSizeWithByteCounts:(long long)byteCounts;
+ (unsigned long long)fileSizeForPath:(NSString *)path;
+ (float)folderSizeAtPath:(NSString*) folderPath;
+ (void)clearCache:(NSString *)path;

@end
