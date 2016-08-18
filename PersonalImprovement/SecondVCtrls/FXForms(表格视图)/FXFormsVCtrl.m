//
//  FXFormsVCtrl.m
//  PersonalImprovement
//
//  Created by xiong有都 on 16/7/23.
//  Copyright © 2016年 xiong有都. All rights reserved.
//

#import "FXFormsVCtrl.h"
#import "RootFormViewController.h"
#import "LoginFormViewController.h"
#import "RootFormViewController1.h"
#import "FormViewController.h"
#import "FormViewController1.h"
#import "LocationForm.h"


@interface FXFormsVCtrl ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation FXFormsVCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self addCell:@"BasicExample" class:@"RootFormViewController"];
    [self addCell:@"CustomButtonExample" class:@"LoginFormViewController"];
    [self addCell:@"CustomFormControllerExample" class:@"RootFormViewController1"];
    [self addCell:@"DependentFieldsExample" class:@"FormViewController"];
    [self addCell:@"DynamicFieldsExample" class:@"FormViewController1"];
    [self addCell:@"FieldControllerExample" class:@"FileManagerVCtrl"];
    [self addCell:@"TemplateFieldsExamplea" class:@"FormatterRootViewController"];
    [self.tableView reloadData];
}


- (void)addCell:(NSString *)title class:(NSString *)className {
    [self.titleArray addObject:title];
    [self.classArray addObject:className];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.titleArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *cellTitle = self.titleArray[indexPath.row];
    NSString *classStr = self.classArray[indexPath.row];
    Class class = NSClassFromString(classStr);
    UIViewController *ctrl = [[class alloc]init];
    ctrl.title = cellTitle;
    if ([cellTitle isEqualToString:@"FieldControllerExample"]){
        FXFormViewController *formViewController = [[FXFormViewController alloc] init];
        formViewController.formController.form = [[LocationForm alloc] init];
        [self.navigationController pushViewController:formViewController animated:YES];
    }else {
        [self.navigationController pushViewController:ctrl animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
