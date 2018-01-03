//
//  ViewController1.m
//  demo
//
//  Created by 吴斌清 on 2018/1/2.
//  Copyright © 2018年 winphonesoftware. All rights reserved.
//

#import "ViewController1.h"

@interface ViewController1 ()<WBQTableViewDelegate>
{
    WBQTableView *_wbqTable;
}

@end

@implementation ViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"customTable";
    _wbqTable = [WBQTableView new];
    _wbqTable.WBQDelegate = self;
    [self.view addSubview:_wbqTable];
    
    [_wbqTable reloadData];
    //table的reload不是同步的    解决方案layout重新布局 调用下面的方法
//    [_wbqTable layoutIfNeeded];
}


-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    _wbqTable.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}


-(NSInteger)tableView:(WBQTableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 50;
}

-(WBQTableViewCell *)tableView:(WBQTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WBQTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[WBQTableViewCell alloc]initWithIdentifier:@"cell"];
    }
    if (indexPath.row%2) {
        cell.backgroundColor = [UIColor yellowColor];
    }else{
        cell.backgroundColor = [UIColor blueColor];
    }
    cell.textLable.text = [@(indexPath.row) description];
    
    return cell;
}

-(CGFloat)tableView:(WBQTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
