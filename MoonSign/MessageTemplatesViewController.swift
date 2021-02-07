//
//  MessageTemplatesViewController.swift
//  MoonSign
//
//  Created by Mac on 9/23/18.
//  Copyright © 2018 BlackSpring. All rights reserved.
//

import UIKit
struct celldata{
    var opened = Bool()
    var title = String()
    var sectionData = [String]()
}

protocol GetTemplateText {
    func getText(text: String)
}
class MessageTemplatesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var tableViewData = [celldata]()
    
    var loveTitles = [String]()
    var career = [String]()
    var remedies = [String]()
    var others = [String]()
    
    var delegate : GetTemplateText?
    
    var openedSections = [Int]()
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var mainTableView: UITableView!
    
    
//    @IBOutlet weak var cancelButton: UIButton!
//
//    @IBAction func cancelClicked(_ sender: UIButton) {
//        self.dismiss(animated: true, completion: nil)
//    }
    override func viewDidLoad() {
        super.viewDidLoad()

        tableViewData = [
            celldata(opened: false, title: "Love", sectionData: loveTitles),
            celldata(opened: false, title: "Career", sectionData: career),
            celldata(opened: false, title: "Remedies", sectionData: remedies),
            celldata(opened: false, title: "Others", sectionData: others)
        ]
        
        mainTableView.tableHeaderView = UIView()
        mainTableView.tableFooterView = UIView()
        
//        self.cancelButton.backgroundColor = UIColor(red:0.31, green:0.06, blue:0.62, alpha:1.0)
        
//        self.cancelButton.backgroundColor = ColorConstants.accentColor
        
        self.view.backgroundColor = UIColor(red:0.00, green:0.00, blue:0.00, alpha:0.2)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first
        if touch?.view != mainView {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableViewData[section].opened == true{
            return tableViewData[section].sectionData.count + 1
        }
        else{
            return 1
        }
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.row == 0 {
//            return 40
//        }
//        else{
//            return 100
//        }
//    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dataIndex = indexPath.row - 1
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MessageTemplatesTableViewCell", for: indexPath) as! MessageTemplatesTableViewCell
            cell.titleText.text = tableViewData[indexPath.section].title
            cell.titleImage.image = UIImage(named: tableViewData[indexPath.section].title)
            cell.arrowText.image = UIImage(named: "ic_down-arrow")
            cell.arrowText.image = cell.arrowText.image!.withRenderingMode(.alwaysTemplate)
            cell.titleImage.image = cell.titleImage.image!.withRenderingMode(.alwaysTemplate)
            cell.arrowText.isHidden = false
            
            for sections in self.openedSections{
                if indexPath.section == sections{
                    cell.arrowText.image = UIImage(named: "ic_up-arrow")
                    cell.arrowText.image = cell.arrowText.image!.withRenderingMode(.alwaysTemplate)
                }
            }
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "MessageTemplatesTableViewCell", for: indexPath) as! MessageTemplatesTableViewCell
            cell.titleText.text = tableViewData[indexPath.section].sectionData[dataIndex]
            cell.titleImage.image = UIImage()
            cell.arrowText.isHidden = true
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            if tableViewData[indexPath.section].opened == true{
                tableViewData[indexPath.section].opened = false
                self.openedSections = self.openedSections.filter{$0 != indexPath.section}
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none)
            }
            else{
                tableViewData[indexPath.section].opened = true
                self.openedSections = self.openedSections.filter{$0 != indexPath.section}
                self.openedSections.append(indexPath.section)
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none)
            }
        }
        else{
            let message = tableViewData[indexPath.section].sectionData[indexPath.row-1]
            print(message)
            delegate?.getText(text: message)
            self.dismiss(animated: true, completion: nil)
            NotificationCenter.default.post(name: .getTemplateNotification, object: message)
        }
    }
    

}
