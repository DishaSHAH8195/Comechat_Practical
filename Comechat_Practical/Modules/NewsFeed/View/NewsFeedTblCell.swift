//
//  NewsFeedTblCell.swift
//  Comechat_Practical
//
//  Created by Disha Shah on 02/12/21.
//

import UIKit

class NewsFeedTblCell: UITableViewCell {

    //MARK: - IBOutlets
    @IBOutlet weak var lblAuthorName    : UILabel!
    @IBOutlet weak var lblTitle         : UILabel!
    @IBOutlet weak var lblDescription   : UILabel!
    @IBOutlet weak var imgNews          : UIImageView!
    @IBOutlet weak var btnSeeFullNews   : UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
   
    //MARK: - setupData
    func setupData(data:Article) {
        lblAuthorName.text = data.author
        lblTitle.text = data.title
        lblDescription.text = data.articleDescription
        imgNews.sd_setImage(with: URL(string: data.urlToImage ?? ""), completed: nil)
    }
}
