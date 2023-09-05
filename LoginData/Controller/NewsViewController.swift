//
//  NewsViewController.swift
//  LoginData
//
//  Created by apple on 03/09/23.
//

import UIKit

class NewsViewController: UIViewController {
    
    //MARK:- IBOutlets
    @IBOutlet weak var authorTxt: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var timeTxt: UILabel!
    @IBOutlet weak var titleTxt: UILabel!
    @IBOutlet weak var descrTxt: UILabel!
    
    //MARK:- Variables
    var newsContent = NewModel()
    
    //MARK:-NewsViewController ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        authorTxt.text = newsContent.author
        titleTxt.text = newsContent.title
        descrTxt.text = newsContent.descrip
        timeTxt.text = newsContent.publishedAt
        let url = URL(string: newsContent.urlToImage ?? "") ?? URL(fileURLWithPath: "")
        img.downloadImage(from: url)
        img.contentMode = .scaleToFill
        // Do any additional setup after loading the view.
    }
    
    //MARK:- Back Button Tapped
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
