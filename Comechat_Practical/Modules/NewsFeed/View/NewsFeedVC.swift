//
//  NewsFeedVC.swift
//  Comechat_Practical
//
//  Created by Disha Shah on 02/12/21.
//

import UIKit
import SDWebImage
import CoreData

class NewsFeedVC: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var tblNewsFeeds : UITableView!
    @IBOutlet weak var viewTitle    : UIView!
    
    //MARK: - Variable Declaration
    var viewModel = NewsFeedViewModel()
    
    //MARK: - View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Check for internet connectivity.
        if NetworkConnectivity.isConnectedToInternet(){
            wsGetNewsFeed()
        } else {
            displayToast(AlertMessage.networkConnection)
            getNewsfeedFromCoreData()
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        viewTitle.roundCorners([.bottomLeft,.bottomRight], radius: 15)
    }
    
    //MARK: - UIBUtton Action
    @IBAction func btnCloseAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Fetch Newsfeed to Core Data
    func getNewsFeedFromContainer()->[Newsfeed]{
        let fetchRequest = NSFetchRequest<Newsfeed>(entityName: "Newsfeed")
        let context = Constants.appDelegate.persistentContainer.viewContext
        do{
            let names = try context.fetch(fetchRequest)
            return names
        } catch let fetchErr{
            print("Failed to fetch companiess: ", fetchErr)
            return []
        }
    }
    
    func getNewsfeedFromCoreData(){
        let arrNewsFeed = getNewsFeedFromContainer()
        for i in 0..<arrNewsFeed.count{
            guard let data = arrNewsFeed[i].articles else { return }
            let result = try! JSONDecoder().decode([Article].self, from: data)
            viewModel.arrArticles = result
            tblNewsFeeds.reloadData()
        }
    }
    
    //MARK: - API Call
    func wsGetNewsFeed() {
        viewModel.getNewsArticle { [weak self] error in
            if let _ = error {return}
            let projectsInfo = NSEntityDescription.insertNewObject(forEntityName: "Newsfeed", into: Constants.appDelegate.persistentContainer.viewContext) as! Newsfeed
            let jsonData = try! JSONEncoder().encode(self?.viewModel.arrArticles)
            projectsInfo.articles = jsonData
            Constants.appDelegate.saveContext()
            
            self?.tblNewsFeeds.reloadData()
        }
    }
}

//MARK: - UITableViewDelegate and UITableViewDataSource Methods
extension NewsFeedVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.arrArticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblNewsFeeds.dequeueReusableCell(withIdentifier: "NewsFeedTblCell", for: indexPath) as! NewsFeedTblCell
        let newsData = viewModel.arrArticles[indexPath.row]
        cell.setupData(data: newsData)
        cell.btnSeeFullNews.action { [weak self] btn in
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "NewsContentVC") as! NewsContentVC
            vc.objNewsData = newsData
            vc.modalPresentationStyle = .fullScreen
            self?.navigationController?.present(vc, animated: true, completion: nil)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
