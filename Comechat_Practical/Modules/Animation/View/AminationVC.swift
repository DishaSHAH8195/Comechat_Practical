//
//  ViewController.swift
//  Comechat_Practical
//
//  Created by Disha Shah on 02/12/21.
//

import UIKit

class AminationVC: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet weak var btnAnimation         : UIButton!
    @IBOutlet weak var btnNewsFeed          : UIButton!

    //MARK: - Variables
    var timesClicked = 0

    //MARK: - View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        initialBtnAnimationFrame()
    }

    func initialBtnAnimationFrame() {
        self.btnAnimation.frame = CGRect(x: 30, y: Constants.ScreenSize.SCREEN_HEIGHT/2 - 35, width: 70, height: 70)
    }
    
    //MARK: - UIButton Actions
    @IBAction func btnAnimationAction(_ sender: AnyObject) {
        //increment the count to detect second click
        timesClicked += 1
        if (timesClicked>1) {
            btnAnimation.isUserInteractionEnabled = false //stop button from animating
            UIView.animate(withDuration: 0.65, animations: { [unowned self] in
                btnNewsFeed.isHidden = false
                self.btnAnimation.backgroundColor = UIColor.darkGray()
                self.btnAnimation.frame = CGRect(x:0, y: 0, width: Constants.ScreenSize.SCREEN_WIDTH, height: Constants.ScreenSize.SCREEN_HEIGHT)
            })
        } else {
            let yPosition = btnAnimation.frame.origin.y
            let width = btnAnimation.frame.size.width * 2
            let height = btnAnimation.frame.size.height * 2

            UIView.animate(withDuration: 0.65, animations: { [unowned self] in
                self.btnAnimation.backgroundColor = UIColor.aquaGreen()
                self.btnAnimation.frame = CGRect(x: Constants.ScreenSize.SCREEN_WIDTH/2 - 70, y: yPosition, width: width, height: height)
            })
        }
    }
    
    @IBAction func btnNewsFeedAction(_ sender: AnyObject) {
        //Push to NewsFeed screen
        let  mainView = UIStoryboard(name:"Main", bundle: nil)
        let viewcontroller : UIViewController = mainView.instantiateViewController(withIdentifier: "NewsFeedVC") as! NewsFeedVC
        self.navigationController?.pushViewController(viewcontroller, animated: true)
    }
}

