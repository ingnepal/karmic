//
//  AstrologersListViewController.swift
//  MoonSign
//
//  Created by Mac on 9/9/18.
//  Copyright © 2018 BlackSpring. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
class AstrologersListViewController: UIViewController {
    var astrolgersData = [[String:String]]()
    
    
    @IBOutlet weak var mainTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.title = "Astrologers"
        getAstrologerList()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getAstrologerList(){
        
        let stringURL: String = HTTPConstants.baseURl +  "/api/userlist/GetAstrologer"
        HTTPRequests.HTTPGetRequestData(stringURL, withSuccess: {(response,statusFlag) in
            if statusFlag{
                do{
                 let root = try JSONDecoder().decode(AstrologersListRoot.self, from: response!)
                    print(root as Any)
                    for data in root.data!{
                        let dataDict = ["imageUrl": data.imageUrl!,
                                        "qualification":data.qualification!,
                                        "rolename":data.roleNames!,
                                        "userid": data.userId!,
                                        "username": data.userName!
                                        ]
                        self.astrolgersData.append(dataDict)
                    }
                    self.mainTableView.reloadData()
                }
                catch let jsonerror{
                    print(jsonerror as Any)
                }
            }
        })
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension AstrologersListViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.astrolgersData.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 73
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AstrologersListTableViewCell", for: indexPath) as! AstrologersListTableViewCell
        let data = self.astrolgersData[indexPath.row]
        cell.titleImage.af_setImage(withURL: URL(string: data["imageUrl"]!)!)
        cell.title.text = data["username"]
        cell.subtitle.text = data["qualification"]
        return cell
    }
}
