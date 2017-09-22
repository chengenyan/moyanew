//
//  ViewModelbase.swift
//  BeijingTravel
//
//  Created by apple on 16/5/26.
//  Copyright © 2016年 ZZH. All rights reserved.
//

import UIKit
//类似于OC中的typedef,block
typealias sendValuedict=(_ dict:NSDictionary,_ total:String)->Void
typealias sendValuearray=(_ listarr:NSArray,_ total:String)->Void
typealias sendValuestring=(_ string1:String)->Void
class ViewModelbase: NSObject {//最基础的三个调用
    var mydict:sendValuedict?//字典
    var myarray:sendValuearray?//数组
    var mystring:sendValuestring?//字符串
}
