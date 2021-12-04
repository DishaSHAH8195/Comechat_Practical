//
//  WebServiceHandler.swift
//  Comechat_Practical
//
//  Created by Disha on 25/04/19.
//

import Foundation
import UIKit
import Alamofire
import Security

class WebServiceHandler: NSObject {
    
    static var instance             : WebServiceHandler!
    static let networkManager       = WebServicesManager()
    
    
    // MARK:- Api request with any type parameter
    /// Request with Any type in which images are not supported
    class func apiRequestWithAnyParam(method: HTTPMethod, urlString: String, parameters: Any?, headerType: HeaderType, isShowLoader: Bool = false,shouldHideLoader: Bool = false, isEncodade : Bool = false,isProduction: Bool = false,viewController: UIViewController? = nil,isNotBaseURL : Bool = false, success:@escaping (Any?, Int?) -> Void, failure: @escaping (_ responseObj:Any?, _ errorType: ErrorType, _ statusCode: Int , _ responseHeader:Any?) -> Void) {
        
        // Manamge Loder Here
        if isShowLoader {
            SHOW_NETWORK_ACTIVITY_INDICATOR()
        } else {
            HIDE_NETWORK_ACTIVITY_INDICATOR()
        }

        networkManager.requestWithAnyParam(method: method, urlString: urlString, parameters: parameters, headerType: headerType, success:{ (statusCodeObj, responseObj,responseHeader)  in
            
            print("\n============ Response \(urlString) ============")
            print("StatusCode:\(String(describing: statusCodeObj))")
            print("ResponseObj:\(String(describing: responseObj))")
            print("ResponseHeader:\(String(describing: responseHeader))")
            
            if shouldHideLoader {
                HIDE_NETWORK_ACTIVITY_INDICATOR()
            }
            
            if let statusCode = statusCodeObj {
                if statusCode == 200 {
                    if isEncodade {
                        // Here Decode response
                    } else {
                        success(responseObj, statusCodeObj)
                    }
                } else if statusCode == 201 {
                    if isEncodade {
                        // Here Decode response
                    } else {
                        success(responseObj, statusCodeObj)
                    }
                } else if statusCode == 400 {
                    if isEncodade {
                        // Here Decode response
                    } else {
                        success(responseObj, statusCodeObj)
                    }
                } else if statusCode == 404 {
                    if isEncodade {
                        // Here Decode response
                    } else {
                        success(responseObj, statusCodeObj)
                    }
                } else if statusCode == 204 {
                    if isEncodade {
                        // Here Decode response
                    } else {
                        success(responseObj, statusCodeObj)
                    }
                } else if statusCode == 422 {
                    if isEncodade {
                        // Here Decode response
                    } else {
                        success(responseObj, statusCodeObj)
                    }
                } else if statusCode == 401 { // token expried
                    displayToast("Device token expried, Please login again")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        //goToSignInVC()
                    }
                } else {
                    success(responseObj, statusCodeObj)
                }
            } else {
            }
        }) { (errorType) in
            // Mange Hide Loadder
            //            (_ responseObj:Any, _ errorType: moveSpotErrorType, _ statusCode: Int , _ responseHeader:Any)
            failure(nil, errorType, 0, nil)
            HIDE_NETWORK_ACTIVITY_INDICATOR()
        }
    }
}
