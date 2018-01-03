//
//  ViewController.m
//  demo
//
//  Created by 吴斌清 on 2018/1/2.
//  Copyright © 2018年 winphonesoftware. All rights reserved.
//

#import "ViewController.h"
#import "ViewController1.h"
#import "ViewController2.h"
#import "CollectionViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UITableView *table = [[UITableView alloc]initWithFrame:self.view.bounds];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    NSLog(@"numberOfRowsInSection %@",[@(section) description]);
    return 100;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"cellForRowAtIndexPath");
    static NSString *cellId = @"cell";
    NSArray *titleAry = @[@"根据scrollview来写一个tableview",@"快速写一个日历",@"随机瀑布流"];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
    }
    if (titleAry.count > indexPath.row) {
        cell.textLabel.text = titleAry[indexPath.row];
    }else{
        cell.textLabel.text = [@(indexPath.row) description];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"heightForRowAtIndexPath %@",[@(indexPath.row) description]);
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [tableView reloadData];
    if (indexPath.row == 0) {
        [self.navigationController pushViewController:[ViewController1 new] animated:YES];
    }
    if (indexPath.row == 1) {
        [self.navigationController pushViewController:[ViewController2 new] animated:YES];
    }
    if (indexPath.row == 2) {
        [self.navigationController pushViewController:[CollectionViewController new] animated:YES];
    }
}
@end
