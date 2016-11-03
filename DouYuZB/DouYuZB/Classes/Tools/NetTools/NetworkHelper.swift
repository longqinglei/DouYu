//
//  NetworkHelper.swift
//  DouYuZB
//
//  Created by longqinglei on 16/10/15.
//  Copyright © 2016年 龙青磊. All rights reserved.
//

import UIKit
import Alamofire

// MARK: - 定义网络请求类型
enum RequestType :String {
    case GET = "GET"
    case POST = "POST"
}

// MARK: - 定义请求结果回调的闭包
typealias FinishRequestBack = (_ response:ResponseResult) -> Swift.Void

struct ResponseResult {
    
    var request : URLRequest?
    var _metrics: AnyObject?
    var response: HTTPURLResponse?
    var data: Data?                 //返回的data数据信息
    var jsonData : AnyObject?       //如果是json数据转成jsonData
    var error:Error?                //请求的错误信息
    var isSuccess:Bool?             //是否请求成功
    
}

// MARK: - 创建单例
class NetworkHelper {
    static let shareNetworkHelper: NetworkHelper = NetworkHelper()
}


extension NetworkHelper {
    class func requestData(type :RequestType,URLString:String, parameters: [String : Any]? = nil, finish : @escaping FinishRequestBack) {
        // 1 判断类型
        let method : HTTPMethod = type == .GET ? HTTPMethod.get : HTTPMethod.post
        // 2 发送网络请求
        Alamofire.request(URLString, method: method, parameters: parameters).response { (response) in
            let resultResponse : ResponseResult = NetworkHelper.shareNetworkHelper.responseResultWithResponse(requestResult: response)
            finish(resultResponse)
        }
    }
}

// MARK: - 给请求结果转换类型
extension NetworkHelper {
    func responseResultWithResponse(requestResult: DefaultDataResponse) -> ResponseResult{
        // 1 初始化请求结果结构体
        var responseResult:ResponseResult = ResponseResult()
        // 2 赋值
        responseResult.request = requestResult.request
        // 3 判断网络是否请求成功
        if responseResult.error == nil {
            responseResult.isSuccess = true
            
            responseResult.data = requestResult.data
            
            do {
                try responseResult.jsonData = JSONSerialization.jsonObject(with: responseResult.data!, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
            } catch  {
                responseResult.jsonData = nil
            }
        }else{
            responseResult.error = requestResult.error
            responseResult.isSuccess = true
        }
        return responseResult
        
    }
}
