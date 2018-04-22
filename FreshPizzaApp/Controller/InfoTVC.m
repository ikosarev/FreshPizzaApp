//
//  InfoTVC.m
//  FreshPizzaApp
//
//  Created by Ivan Kosarev on 31/03/2018.
//  Copyright © 2018 Ivan Kosarev. All rights reserved.
//

#import "InfoTVC.h"

@interface InfoTVC ()

@end

@implementation InfoTVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [super numberOfSectionsInTableView:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [super tableView:tableView numberOfRowsInSection:section];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Row = %ld, Section = %ld", indexPath.row, (long)indexPath.section);
    if(indexPath.row == 0 && indexPath.section == 0){
        
        NSLog(@"Phone number = %@",self.phoneNumberLbl.text);
        NSString *stringURL = [@"telprompt://" stringByAppendingString:@"12345678"];
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:stringURL]]){
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:stringURL] options:@{} completionHandler:nil];
        } else {
            UIAlertController * alert = [UIAlertController
                                         alertControllerWithTitle:@"Ошибка"
                                         message:@"Чтобы позвонить, на устройстве должно быть установлено приложение Телефон"
                                         preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* okButton = [UIAlertAction
                                        actionWithTitle:@"Ок"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action) {
                                            [alert dismissViewControllerAnimated:true completion:nil];
                                        }];
            [alert addAction:okButton];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }
    if(indexPath.row == 1 && indexPath.section == 0){
        NSString *stringURL = [@"mailto://" stringByAppendingString:self.emailLbl.text];
        
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:stringURL]]){
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:stringURL] options:@{} completionHandler:nil];
        } else {
            UIAlertController * alert = [UIAlertController
                                         alertControllerWithTitle:@"Ошибка"
                                         message:@"Чтобы отправить письмо, на устройстве должно быть установлено приложение Почта"
                                         preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* okButton = [UIAlertAction
                                       actionWithTitle:@"Ок"
                                       style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction * action) {
                                           [alert dismissViewControllerAnimated:true completion:nil];
                                       }];
            [alert addAction:okButton];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }
}
@end
