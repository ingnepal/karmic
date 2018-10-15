//
//  NavigationDrawerViewController.swift
//  MoonSign
//
//  Created by Mac on 9/6/18.
//  Copyright © 2018 BlackSpring. All rights reserved.
//

import UIKit

class NavigationDrawerViewController: UIViewController {
    let titles = ["Thought of the day","Horoscope","Yoga","Astrologers","Customer Support", "How MoonSign works"]
//    let titleImages = [#imageLiteral(resourceName: "thought"),#imageLiteral(resourceName: "astrologers"),#imageLiteral(resourceName: "support"),#imageLiteral(resourceName: "settings")]
    let titleImages = [UIImage(named: "thought"),UIImage(named: "sun"),UIImage(named: "meditate"),UIImage(named: "astrologers"),UIImage(named: "support"),UIImage(named: "settings")]
    @IBOutlet weak var mainTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.mainTableView.tableFooterView = UIView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        return self.titles.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NavigationDrawerTableViewCell", for: indexPath) as! NavigationDrawerTableViewCell
        cell.titleLabel.text = self.titles[indexPath.row]
        cell.titleImage.image = self.titleImages[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NotificationCenter.default.post(name: .navigation, object: indexPath.item)
    }
}
