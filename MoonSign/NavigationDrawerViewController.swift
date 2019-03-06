//
//  NavigationDrawerViewController.swift
//  MoonSign
//
//  Created by Mac on 9/6/18.
//  Copyright © 2018 BlackSpring. All rights reserved.
//

import UIKit

class NavigationDrawerViewController: UIViewController {
    let titles = ["Our Astrologers","Your Horoscope","How MoonSign works","Yoga","Thought of the day", "Customer Support", "Privacy Policy"]
//    let titleImages = [#imageLiteral(resourceName: "thought"),#imageLiteral(resourceName: "astrologers"),#imageLiteral(resourceName: "support"),#imageLiteral(resourceName: "settings")]
    let titleImages = [UIImage(named: "astrologers"),UIImage(named: "sun"),UIImage(named: "settings"),UIImage(named: "meditate"),UIImage(named: "thought"),UIImage(named: "ic_customer_support"),UIImage(named: "ic_terms"),UIImage(named: "settings")]
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var questionPriceText: UILabel!
    @IBOutlet weak var questionPrice: UILabel!
    
    @IBOutlet weak var vertexView: UIView!
    @IBOutlet weak var blackSpringView: UIView!
    @IBOutlet weak var freeQuestions: UILabel!
    @IBOutlet weak var freeQuestionsText: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.mainTableView.tableFooterView = UIView()
        
        self.questionPriceText.backgroundColor = ColorConstants.accentColor
        self.questionPriceText.textColor = UIColor.white
        self.questionPrice.backgroundColor = ColorConstants.primaryColor
        self.questionPrice.textColor = UIColor.white
        
        self.freeQuestionsText.backgroundColor = ColorConstants.accentColor
        self.freeQuestionsText.textColor = UIColor.white
        
        self.freeQuestions.backgroundColor = ColorConstants.primaryColor
        self.freeQuestions.textColor = UIColor.white
        // Do any additional setup after loading the view.
        
        self.freeQuestions.text = "\(SaveData.getFreeQuestions())"
        
        let vtapGesture = UITapGestureRecognizer(target: self, action: #selector(self.vertexViewTapped(gesture:)))
        let btapGesture = UITapGestureRecognizer(target: self, action: #selector(self.blackspringViewTapped(gesture:)))
        
        self.vertexView.isUserInteractionEnabled = true
        self.vertexView.addGestureRecognizer(vtapGesture)
        
        self.blackSpringView.isUserInteractionEnabled = true
        self.blackSpringView.addGestureRecognizer(btapGesture)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func vertexViewTapped(gesture: UITapGestureRecognizer){
        guard let url = URL(string: "https://www.vertexwebsurf.com.np") else {
            return //be safe
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    @objc func blackspringViewTapped(gesture: UITapGestureRecognizer){
        guard let url = URL(string: "https://blackspring.com.np") else {
            return //be safe
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
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
extension NavigationDrawerViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.titles.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NavigationDrawerTableViewCell", for: indexPath) as! NavigationDrawerTableViewCell
        cell.titleLabel.text = self.titles[indexPath.section]
        cell.titleImage.image = self.titleImages[indexPath.section]
        cell.titleImage.image = cell.titleImage.image!.withRenderingMode(.alwaysTemplate)
        cell.titleImage.tintColor = ColorConstants.primaryColor
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NotificationCenter.default.post(name: .navigation, object: indexPath.section)
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if (section == 3 || section == 5) {
            let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 10))
            headerView.backgroundColor = UIColor.gray
            return headerView
        } else {
            let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 1))
            headerView.backgroundColor = UIColor.clear
             return headerView
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 3 || section == 5 {
            return 2
        }
        else{
            return 0
        }
    }
}
