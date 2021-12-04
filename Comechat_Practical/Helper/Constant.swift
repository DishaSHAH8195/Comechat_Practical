//
//  Constant.swift
//  Comechat_Practical
//
//  Created by Disha Shah on 01/12/21.
//
import UIKit
import Foundation

// MARK: - Message's
enum AlertMessage {
    static let networkConnection = "You are not connected to internet. Please connect and try again"
}

struct PARAMETERS {
    static let kArticle = "articles"
}
struct WebServiceURL {
    static let getNewsFeed = "https://newsapi.org/v2/top-headlines?country=in&apiKey=\(Constants.apiKey)"
}
extension UIColor {
    class func aquaGreen() -> UIColor { return UIColor(red:59/255, green: 142/255, blue: 147/255, alpha: 1)}
    class func darkGray() -> UIColor { return UIColor(red:36/255, green: 36/255, blue: 36/255, alpha: 1)}
}

struct Constants {
    // MARK: - Global Utility
    static let appName          = Bundle.main.infoDictionary!["CFBundleName"] as! String
    static let appDelegate      = UIApplication.shared.delegate as! AppDelegate
    static let mainWindow       = UIApplication.shared.delegate?.window!
    //static let rootView         = UIApplication.shared.keyWindow
    static let deviceID         = UIDevice.current.identifierForVendor?.uuidString
    static let apiKey           = "efd92e419acd41759e6a2abd0ebc8b8e"
    //MARK: - device type
    struct ScreenSize {
        static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
        static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
        static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
        static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
        static let WidthRatio           = (SCREEN_WIDTH / 414)
        static let Safe_Bottom = Constants.mainWindow!.safeAreaInsets.bottom
        static let Safe_Top = Constants.mainWindow!.safeAreaInsets.top
    }
}

