//
//  MoyaMoyaNetWorkingTools.swift
//  ChanganTravel
//
//  Created by apple on 2017/7/10.
//  Copyright © 2017年 ZZH. All rights reserved.
//

import UIKit
import Foundation
import RxSwift
import Moya
import ObjectMapper

typealias SuccessClosure = (_ result: AnyObject) -> Void
typealias FailClosure = (_ errorMsg: String?) -> Void
class MoyaNetWorkingTools:NSObject{
    private let MD5KEY = "32AD3958-8532-4C52-9D91-4D19EC4E474A"
    let disposeBag = DisposeBag()
    let moyaprovider=RxMoyaProvider<DataAPI>()
    static let tools:MoyaNetWorkingTools = {
        let t = MoyaNetWorkingTools()
        return t
    }()
    //获取单例
    class func shareMoyaNetWorkingTools() ->MoyaNetWorkingTools {
        return tools
    }
    func createPost(_ target: DataAPI, successClosure: @escaping SuccessClosure, failClosure: @escaping FailClosure)  {
        return self.moyaprovider.request(target).subscribe {
        (event) -> Void in
        switch event {
        case .success(let response):
            do {
                let info = try response.mapJSON()//返回的数据解析成 JSON 格式
                guard let senddict = info as? NSDictionary else {
                    throw MoyaError.jsonMapping(response)
                }
                let string1:String=String(senddict["code"])
                if string1 == "100" {//账号被其他手机登录,失效
//                    SVProgressHUD.showError(withStatus: "请重新登录")
                    //去登录界面
                }else {
                    successClosure(senddict as AnyObject)
                }
            } catch {
                failClosure("网络网络请求失败")
            }
        case .error(let error):

            failClosure("网络网络请求失败")
        
           }
        }.addDisposableTo(disposeBag)
    }
    
    //加载数据,,用post方法获取
    func getDatawithpost(_ dict:NSDictionary,url:String,isToken:Bool,finished: @escaping (_ data:AnyObject?, _ error:NSString?)->()){
        return  self.moyaprovider.request(.loaddatabypostMethod(mydict:dict,path:url)).subscribe {
            (event) -> Void in
            switch event {
            case .success(let response):
                do {
                  let info = try response.mapJSON()//返回的数据解析成 JSON 格式
                    guard let senddict = info as? NSDictionary else {
                        throw MoyaError.jsonMapping(response)
                    }
                    let string1:String=String(senddict["code"])
                    if string1 == "-100" || string1 == "-101" || string1 == "-102" {//账号被其他手机登录,失效
//                        SVProgressHUD.showError(withStatus: "请重新登录")
                        //去登录界面
                    }else {
                        finished(senddict,"")
                    }
                } catch {
                    finished(nil,"网络不好")
                }
            case .error(let error):
                finished(nil,"网络不好")
            }
            }.addDisposableTo(disposeBag)
    }
    //加载数据,用get方法获取
    func getDatawithget(_ dict:NSDictionary?,url:String,isToken:Bool,finished: @escaping (_ data:AnyObject?, _ error:NSString?)->()){
        return  self.moyaprovider.request(.loaddatabygetMethod(mydict:dict,path:url)).subscribe {
            (event) -> Void in
            switch event {
            case .success(let response):
                do {
//                    let str = String(data: response.data, encoding: String.Encoding.utf8)
//                    printhidden(str as AnyObject)//将data转换为string
                    let info = try response.mapJSON()//返回的数据解析成 JSON 格式
                    guard let senddict = info as? NSDictionary else {
                        throw MoyaError.jsonMapping(response)
                    }
                    let string1:String=String(senddict["code"])
                    if string1 == "-100" || string1 == "-101" || string1 == "-102" {//账号被其他手机登录,失效
//                        SVProgressHUD.showError(withStatus: "请重新登录")
                        //去登录界面
                    }else {
                        finished(senddict,"")
                    }
                } catch {
                    finished(nil,"网络不好")
                }
            case .error(let error):
//                printhidden(error as AnyObject)
                finished(nil,"网络不好")
            }
            }.addDisposableTo(disposeBag)
    }
    
 
   
}
