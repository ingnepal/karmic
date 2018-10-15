//
//  HoroscopeViewController.swift
//  MoonSign
//
//  Created by Mac on 9/25/18.
//  Copyright © 2018 BlackSpring. All rights reserved.
//

import UIKit

class HoroscopeViewController: UIViewController {

    var titles = [String]()
    var horoscopes = [String]()
    var titleImages = [UIImage]()
    
    @IBOutlet weak var horoscopeTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.title = "Today's Horoscope"
        // Do any additional setup after loading the view.
        
        getData()
    }
    

    func getData(){
        
        let stringURL: String = HTTPConstants.baseURl + "api/horoscope/GetHoroscopes"
        
        HTTPRequests.HTTPGetRequestData(stringURL) { (response, statusFlag) in
            if statusFlag{
                do{
                    let root = try JSONDecoder().decode(GetHoroscopeRoot.self, from: response!)
                    
                    for datas in root.data!{
                        self.titles.append(datas.name!)
                        self.titleImages.append(UIImage(named: datas.name!) ?? UIImage(named: "sun")!)
//                        self.horoscopes.append(datas.detail!)
                        if datas.detail == nil{
                            self.horoscopes.append("Not Available")
                        }
                        else{
                            self.horoscopes.append(datas.detail!)
                        }
                    }
                    
                    self.horoscopeTableView.reloadData()
                }
                catch let jsonerror{
                    print(jsonerror)
                }
            }
        }
        
        
    }

}
extension HoroscopeViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titles.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 86
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HoroscopeTableViewCell", for: indexPath) as! HoroscopeTableViewCell
        cell.titleText.text = titles[indexPath.row]
        cell.subtitleText.text = horoscopes[indexPath.row]
        cell.titleImage.image = titleImages[indexPath.row]
        return cell
    }
    
    
}
