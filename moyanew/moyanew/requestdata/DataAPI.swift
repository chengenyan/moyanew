//
//  DataAPI.swift
//  ChanganTravel
//
//  Created by apple on 2017/7/10.
//  Copyright © 2017年 ZZH. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import Alamofire
let HTTP_IP = "https://api.xxxxxx.com/AppApi/xxxx/"//自己服务器的域名

enum DataAPI {
    case upload(gif: Data,baseurl:String,dict:NSDictionary)//图片上传
    case loadbasedata(mydict:NSDictionary,path:String)//数据获取
    case loaddatabygetMethod(mydict:NSDictionary?,path:String)//数据获取get
    case loaddatabypostMethod(mydict:NSDictionary?,path:String)//数据获取post
}

extension DataAPI: TargetType {
    //上传参数，在这个里面
    var headers: [String : String]? {
        switch self {
        case .upload(_,_,_):
            return nil
        case .loadbasedata(let mydict, _):
            return mydict as? [String : String]
        case .loaddatabygetMethod(let mydict, _):
              return mydict as? [String : String]
        case .loaddatabypostMethod(let mydict,_):
            return mydict as? [String : String]
        }
    }

    /// The method used for parameter encoding.
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.httpBody;
        //        return URLEncoding.default
    }
    
    /// The method used for parameter encoding.
    var baseURL: URL {
        switch self {
      
        case .upload(_,let baseurl,_):
            return URL(string: baseurl)!
        case .loadbasedata(_, _):
            return URL(string: HTTP_IP)!
        case .loaddatabygetMethod(_, _):
            return URL(string: HTTP_IP)!
        case .loaddatabypostMethod(_, _):
            return URL(string: HTTP_IP)!
        }
//        return URL(string: "http://catest.app.ccclubs.com")!
    }
    
    var path: String {
        switch self {
        case .upload(_,_,_):
            return ""
        case .loadbasedata(_, let path):
            return path
            //+ ".ashx"
        case .loaddatabygetMethod(_, let path):
            return path
        case .loaddatabypostMethod(_, let path):
             return path
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .upload(_,_,_):
            return .post
        case .loadbasedata(_, _):
            return .post
        case .loaddatabygetMethod(_,_):
            return .get
        case .loaddatabypostMethod(_, _):
           return .post
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .upload(_,_,let dict):
            return dict as? [String : Any]
        case .loadbasedata(let mydict, _):
            return mydict as? [String : Any]
        case .loaddatabygetMethod(let mydict,_):
            if mydict==nil {
                return nil
            }
         return mydict as? [String : Any]
        case .loaddatabypostMethod(let mydict, _):
            if mydict==nil {
                return nil
            }
            return mydict as? [String : Any]
        }
    }
    
    var sampleData: Data {
        switch self {
        case .upload(_,_,_):
             return "Create post successfully".data(using: String.Encoding.utf8)!
        case .loadbasedata(_, _):
            return "Create post successfully".data(using: String.Encoding.utf8)!
        case .loaddatabygetMethod(_, _):
             return "Create post successfully".data(using: String.Encoding.utf8)!
        case .loaddatabypostMethod(_, _):
              return "Create post successfully".data(using: String.Encoding.utf8)!
        }
    }

    var task: Task {
        switch self {
            case let .upload(data,_,_):
            return .uploadMultipart([MultipartFormData(provider: .data(data), name: "file", fileName: "png", mimeType: "image/png")])
//                .upload(.multipart([MultipartFormData(provider: .data(data), name: "file", fileName: "png", mimeType: "image/png")]))
        case .loadbasedata(let mydict, _):
            return .requestParameters(parameters: mydict as! [String : Any], encoding: URLEncoding.httpBody)//请求参数，加请求方法
        case .loaddatabygetMethod(_,_):
               return .requestPlain//get请求调用
        case .loaddatabypostMethod(let mydict, _):
            if mydict==nil {
                return .requestPlain
            }
            return .requestParameters(parameters: mydict as! [String : Any], encoding: URLEncoding.httpBody)//请求参数，加请求方法
        }
    }
}
