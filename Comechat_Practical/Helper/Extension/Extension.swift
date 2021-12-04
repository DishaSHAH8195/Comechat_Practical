//
//  Extension.swift
//
//

import UIKit
import CoreLocation
import Toast_Swift

public extension UICollectionView {
    /// - Parameter completion: completion handler to run after reloadData finishes.
    func reloadData(_ completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
        }, completion: { _ in
            completion()
        })
    }
}

public extension UITableView {
    /// Reload data with a completion handler.
    ///
    /// - Parameter completion: completion handler to run after reloadData finishes.
    func reloadData(_ completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
        }, completion: { _ in
            completion()
        })
    }
    /// : Remove TableFooterView.
    func removeTableFooterView() {
        tableFooterView = nil
    }
    
    /// : Remove TableHeaderView.
    func removeTableHeaderView() {
        tableHeaderView = nil
    }
    /// : Scroll to bottom of TableView.
    ///
    /// - Parameter animated: set true to animate scroll (default is true).
    func scrollToBottom(animated: Bool = true) {
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height)
        setContentOffset(bottomOffset, animated: animated)
    }
    
    /// : Scroll to top of TableView.
    ///
    /// - Parameter animated: set true to animate scroll (default is true).
    func scrollToTop(animated: Bool = true) {
        setContentOffset(CGPoint.zero, animated: animated)
    }
}

typealias UIButtonTargetClosure = (UIButton) -> ()

class ClosureWrapper: NSObject {
    let closure: UIButtonTargetClosure
    init(_ closure: @escaping UIButtonTargetClosure) {
        self.closure = closure
    }
}

extension UIButton {
    
    private struct AssociatedKeys {
        static var targetClosure = "targetClosure"
    }
    
    private var targetClosure: UIButtonTargetClosure? {
        get {
            guard let closureWrapper = objc_getAssociatedObject(self, &AssociatedKeys.targetClosure) as? ClosureWrapper else { return nil }
            return closureWrapper.closure
        }
        set(newValue) {
            guard let newValue = newValue else { return }
            objc_setAssociatedObject(self, &AssociatedKeys.targetClosure, ClosureWrapper(newValue), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func action(closure: @escaping UIButtonTargetClosure) {
        targetClosure = closure
        addTarget(self, action: #selector(UIButton.closureAction), for: .touchUpInside)
    }
    
    @objc func closureAction() {
        guard let targetClosure = targetClosure else { return }
        targetClosure(self)
    }
}

// MARK:- Toast
func displayToast(_ message : String) {
    let position = CGPoint(x: Constants.ScreenSize.SCREEN_WIDTH / 2, y: Constants.ScreenSize.SCREEN_HEIGHT - 130)
    Constants.mainWindow!.makeToast(message, point: position, title: nil, image: nil, completion: nil)
}

//MARK: - CODABLE FUNCTIONS
func getObjectViaCodable<T : Codable>(dict : [String : Any]) -> T? {
    if let jsonData = try? JSONSerialization.data(
        withJSONObject: dict,
        options: .prettyPrinted
        ){
        do {
            let posts = try JSONDecoder().decode(T.self, from: jsonData)
            return posts
        } catch {
            print(error)
            return nil
        }
        
    } else {
        return nil
    }
}

func getArrayViaCodable<T : Codable>(arrDict : [[String : Any]]) -> [T]? {
    if let jsonData = try? JSONSerialization.data(
        withJSONObject: arrDict,
        options: .prettyPrinted
        ){
        do {
            let posts = try JSONDecoder().decode([T].self, from: jsonData)
            return posts
        } catch {
            print(error)
            return nil
        }
    } else {
        return nil
    }
}
