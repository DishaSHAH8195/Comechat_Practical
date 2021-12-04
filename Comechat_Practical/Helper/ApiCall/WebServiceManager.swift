//
//  WebServicesManager.swift
//  Comechat_Practical
//
//  Created by Disha Shah on 02/12/21.
//
//

import Foundation
import Alamofire
import SVProgressHUD

//MARK : - Errors
enum ErrorType {
    case network
    case response(error: Any?)
    case cancelled
}

enum HeaderType:Int{
    case xFormOnly,xFormOnly1,xFormAccessToken,none
    
    var headerParam:[String:String]{
        switch self
        {
        case .xFormOnly:
            return ["Content-Type":"application/json"]
        default:
            return [:]
        }
    }
}

// New Api Structre  Method
class WebServicesManager {
    /// Request Any param with All Type Method
    func requestWithAnyParam(method: HTTPMethod, urlString: String, parameters: Any? = nil, headerType: HeaderType = .xFormOnly,isFirstTimeCall: Bool = true, success: @escaping (_ statusCode: Int?, _ responseObject: Any?,_ responseHeader:Any?) -> Void, failure: @escaping (_ error: ErrorType) -> Void) {
        
        guard NetworkConnectivity.isConnectedToInternet() else{
            HIDE_NETWORK_ACTIVITY_INDICATOR()
            displayToast(AlertMessage.networkConnection)
            return
        }
        print("====================================")
        print("============== Request =============\n")
        print("URL:- \(urlString)")
        print("header:- \(headerType.headerParam)")
        print("Parameter:- \(String(describing: parameters))")
        
        var request = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = method.rawValue
        for key in headerType.headerParam.keys {
            request.setValue(headerType.headerParam[key], forHTTPHeaderField: key)
        }
        
        if method != .get {
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters ?? "",options: .prettyPrinted)
        }
        
        AF.request(request)
            .responseJSON { responseData in
                switch responseData.result {
                case .success(let responseObj):
                    success(responseData.response?.statusCode, responseObj as Any?, responseData.response?.allHeaderFields)
                case .failure(let error):
                    if responseData.response?.statusCode == 401 {
                        success(responseData.response?.statusCode, nil, nil)
                    } else if error._code == -1001 || error._code == -1004  || error._code == -1005 {
                        if isFirstTimeCall {
                            self.requestWithAnyParam(method: method, urlString: urlString, parameters: parameters, headerType: headerType, isFirstTimeCall: false, success: success, failure: failure)
                        }  else {
                            failure(.response(error: error as Any?))
                        }
                    } else if error._code == 999 {
                        failure(.cancelled)
                    } else {
                        failure(.response(error: error as Any?))
                    }
                }
        }
    }
    
    class func cancelRequestInAlamofire(arrCancelRequestsUrl: [String]) {
        // Before View Will Disapear call these func and pass api which is call in these ViewController
        Alamofire.Session.default.session.getTasksWithCompletionHandler { (sessionDataTask, uploadData, downloadData) in
            sessionDataTask.forEach {
                for url in arrCancelRequestsUrl {
                    if ($0.originalRequest?.url?.absoluteString ?? "").contains(url) {
                        print("==== Cancelled Request : \(String(describing: $0.originalRequest?.url?.absoluteString)) ====")
                        $0.cancel()
                    }
                }
            }
            uploadData.forEach { $0.cancel() }
            downloadData.forEach { $0.cancel() }
        }
    }
}

// MARK: - No Internet Connection
class NetworkConnectivity {
    class func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}

//MARK: - SVProgressHUD Methods
func SHOW_NETWORK_ACTIVITY_INDICATOR(isWithTitle:Bool = false) {
    
    DispatchQueue.main.async {
        SVProgressHUD.setDefaultMaskType(.custom)
        SVProgressHUD.setForegroundColor(.lightGray)
        if isWithTitle {
            SVProgressHUD.show(withStatus: "Video Processing...")
        } else {
            SVProgressHUD.show()
        }
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
}

func HIDE_NETWORK_ACTIVITY_INDICATOR() {
    DispatchQueue.main.async {
        SVProgressHUD.dismiss()
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}
