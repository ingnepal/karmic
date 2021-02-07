//
//  YogaViewController.swift
//  MoonSign
//
//  Created by Mac on 9/25/18.
//  Copyright © 2018 BlackSpring. All rights reserved.
//

import UIKit

import Alamofire
import AlamofireImage

class YogaViewController: UIViewController {

    @IBOutlet weak var mainTableView: UITableView!
    
    var yogaDetails = [[String:String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.title = "Yoga"
        // Do any additional setup after loading the view.
        
        getData()
        
        self.mainTableView.tableHeaderView = UIView()
        self.mainTableView.tableFooterView = UIView()
        
        self.mainTableView.allowsSelection = false
    }
    

    func getData(){
        let stringURL : String = HTTPConstants.baseURl + "api/horoscope/GetYoga"
        
        HTTPRequests.HTTPGetRequestData(stringURL) { (response, statusFlag) in
            if statusFlag{
                do{
                    let root = try JSONDecoder().decode(GetYogaRoot.self, from: response!)
                    if root.meta?.status ?? false == true{
                        for datas in root.data!{
                            let dictData = [
                                "imageURL":datas.imageUrl!,
                                "title":datas.name!,
                                "detail":datas.details!
                            ] as [String:String]
                            self.yogaDetails.append(dictData)
                        }
                        self.mainTableView.reloadData()
                    }
                    
                }
                catch let jsonerror{
                    print(jsonerror)
                }
            }
        }
    }

}
extension YogaViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.yogaDetails.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "YogaUTableViewCell", for: indexPath) as! YogaUTableViewCell
        
        let datas = self.yogaDetails[indexPath.row]
        
        
        let finalURL = datas["imageURL"]?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let imgURL = URL(string: finalURL!)
        cell.titleImage.af_setImage(withURL: imgURL!)
        cell.titleText.text = datas["title"]
        cell.detailText.text = datas["detail"]
        
        cell.mainView.layer.shadowColor = UIColor.gray.cgColor
        cell.mainView.layer.shadowOpacity = 1
        cell.mainView.layer.shadowOffset = CGSize.zero
        cell.mainView.layer.shadowRadius = 3
        
        return cell
    }
}
