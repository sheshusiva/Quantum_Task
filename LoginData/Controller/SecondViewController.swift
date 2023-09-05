//
//  SecondViewController.swift
//  LoginData
//
//  Created by apple on 02/09/23.
//

import UIKit
import CoreData
import FirebaseAuth

class SecondViewController: UIViewController {
    
    //MARK:- IBOutlets
    @IBOutlet weak var titleTxt: UILabel!
    @IBOutlet weak var listView: UITableView!
    
    //MARK:- Variables
    var newsArr = [NewModel]()
    var userModel = UserViewModel()
    var email = String()
    
    

    //MARK:- ViewDidLoad Method
    override func viewDidLoad() {
        super.viewDidLoad()
        listView.dataSource = self
        fetchData()
        listView.delegate = self
        // Do any additional setup after loading the view.
        self.showAlertMethod(title: "User Details is Saved in Firebase", message: "Email: \(email)")
    }
    
    //MARK:- Fetch Data
    func fetchData() {
        //CoreDataManager.sharedInstance.deleteAllData(entity: "NewModel")
        if CoreDataManager.sharedInstance.getNewsData().count != 0 {
            self.newsArr = CoreDataManager.sharedInstance.getNewsData()
            self.listView.reloadData()
        }else {
            self.userModel.getNewsDetailsFromServer { newsArr in
                DispatchQueue.main.async {
                    self.newsArr = newsArr
                    self.listView.reloadData()
                }
            } failure: { error in
                
            }
        }
    }
}


//MARK:- UItableView DataSource and Delegate Methods
extension SecondViewController : UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = listView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ListTableViewCell else {
            return UITableViewCell()
        }
        let newObj = newsArr[indexPath.row]
        cell.nameTxt.text = "Author: \(newsArr[indexPath.row].author ?? "No Author")"
        cell.descTxt.text = newObj.title
        cell.timeTxt.text = newObj.publishedAt
        let url = URL(string: newObj.urlToImage ?? "") ?? URL(fileURLWithPath: "")
        cell.backImg.downloadImage(from: url)
        cell.backImg.contentMode = .scaleToFill
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "NewsViewController") as? NewsViewController else {
            return
        }
        vc.newsContent = newsArr[indexPath.row]
        self.present(vc, animated: true)
    }
    
}
//MARK:- Image hitdata
extension UIImageView {
    func downloadImage(from url: URL){
        let dataTask = URLSession.shared.dataTask(with: url,completionHandler: {
            (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200,
                  let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                  let data = data ,error == nil,
                  let image = UIImage(data: data)
            else{
                return
            }
            DispatchQueue.main.async {
                self.image = image
            }
        })
        dataTask.resume()
    }
}
