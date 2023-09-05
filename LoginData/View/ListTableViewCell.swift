//
//  ListTableViewCell.swift
//  LoginData
//
//  Created by apple on 02/09/23.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var timeTxt: UILabel!
    @IBOutlet weak var nameTxt: UILabel!
    @IBOutlet weak var descTxt: UILabel!
    @IBOutlet weak var backImg: UIImageView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var passwordTxt: UILabel!
    @IBOutlet weak var emailTxt: UILabel!

    var modelUser: NewsData?{
        didSet{
            //userConfiguration()
        }
    }
    
    var dataArray : Email!{
        didSet{
            emailTxt.text = dataArray.email
            passwordTxt.text = dataArray.password
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        backImg.layer.cornerRadius = 20
        backView.layer.cornerRadius = 20
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
