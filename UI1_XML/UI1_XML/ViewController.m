//
//  ViewController.m
//  UI1_XML
//
//  Created by qianfeng on 15/7/24.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ViewController.h"
#import "GDataXMLNode.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //[self xmlXML];
    [self xpathXML];
}

- (void)xmlXML
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"xml" ofType:@"txt"];
    
    NSString *xmlString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    GDataXMLDocument *dc = [[GDataXMLDocument alloc] initWithXMLString:xmlString error:nil];
    //GDataXMLElement xml数据所有节点(父节点，子节点，)
    //rootElement 获得根节点
    GDataXMLElement *root = [dc rootElement];
   // NSLog(@"%@",root);
    //取到root下面标题为books的子节点
    //节点的对象 放到数组中返回
    NSArray *booksArray = [root elementsForName:@"books"];
    //NSLog(@"%@",booksArray);
    GDataXMLElement *books = booksArray[0];
    NSArray *bookArray = [books elementsForName:@"book"];
    for (GDataXMLElement *book in bookArray) {
        NSArray *nameArray = [book elementsForName:@"name"];
       // NSLog(@"%@",nameArray[0]);
        GDataXMLElement *name = nameArray[0];
        NSLog(@"name = %@",name.stringValue);
        NSLog(@"%@",name.name);
        NSLog(@"book %@",book.attributes);//以数组形式取出节点属性,属性也是节点,用GDataXMLElemnt解析
        NSArray *attributesArray = book.attributes;
        GDataXMLElement *id1 = attributesArray[0];
        NSLog(@"%@",[attributesArray[0] stringValue]);
        NSLog(@"%@",[attributesArray[1] stringValue]);
        
    }
}

- (void)xpathXML
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"sns" ofType:@"txt"];
    NSString *xmlString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    GDataXMLDocument *dc = [[GDataXMLDocument alloc] initWithXMLString:xmlString error:nil];
    NSString *xPath = @"/root/user_list/user";
    NSArray *userArray = [dc nodesForXPath:xPath error:nil];
    for (GDataXMLElement *user in userArray) {
        NSLog(@"id = %@",[user.attributes[0] stringValue]);
        NSArray *userNames = [user elementsForName:@"username"];
        GDataXMLElement *userName = userNames[0];
        NSLog(@"userName:%@",userName.stringValue);
        
    }
    NSArray *totals = [dc nodesForXPath:@"//totalcount" error:nil];
    GDataXMLElement *total = totals[0];
    NSLog(@"%@",total.stringValue);
    
    NSString *xpath = @"//username";
    NSArray *userName = [dc nodesForXPath:xpath error:nil];
    for (GDataXMLElement *name in userName)
    {
        //GDataXMLElement *name = userName[0];
         NSLog(@"name---:%@",name.stringValue);
    }
    
   
                             
    
}














- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
