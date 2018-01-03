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
#import "navigationAnimaVC.h"
#import "navigationSystemPopVC.h"

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
    NSArray *titleAry = @[@"根据scrollview来写一个tableview",@"快速写一个日历",@"随机瀑布流",@"模仿导航栏的pop手势",@"替换导航栏back返回动画"];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
    }
    if (titleAry.count > indexPath.row) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@、%@",[@(indexPath.row) description],titleAry[indexPath.row]];
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
    if (indexPath.row == 0) {//根据scrollview来写一个tableview
        [self.navigationController pushViewController:[ViewController1 new] animated:YES];
    }
    if (indexPath.row == 1) {//快速写一个日历
        [self.navigationController pushViewController:[ViewController2 new] animated:YES];
    }
    if (indexPath.row == 2) {//随机瀑布流
        [self.navigationController pushViewController:[CollectionViewController new] animated:YES];
    }
    if (indexPath.row == 3) {//模仿导航栏的pop手势
        [self.navigationController pushViewController:[navigationAnimaVC new] animated:YES];
    }
    if (indexPath.row == 4) {//替换导航栏back返回动画
        [self.navigationController pushViewController:[navigationSystemPopVC new] animated:YES];
    }
}
@end
