//
//  DateTimePickerViewController.swift
//  MoonSign
//
//  Created by Mac on 10/4/18.
//  Copyright © 2018 BlackSpring. All rights reserved.
//

import UIKit
protocol DateTimeSelectDelegate{
    func getDateTime(dateTime : String,isTimeOnly : Bool)
}
class DateTimePickerViewController: UIViewController {

    @IBOutlet weak var dateTimePickerView: UIDatePicker!
    
    var delegate : DateTimeSelectDelegate?
    
    var isTimeOnlyflag: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isTimeOnlyflag{
            dateTimePickerView.datePickerMode = UIDatePickerMode.time
        }
        else{
            dateTimePickerView.datePickerMode = UIDatePickerMode.date
        }
        // Do any additional setup after loading the view.
    }
    

    @IBAction func cancelClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func doneClicked(_ sender: UIButton) {
        print(self.dateTimePickerView.date)
        
        var pickerDateTime = "\(self.dateTimePickerView.date)".dropLast(5)
        
        let dateTimeFormatter = DateFormatter()
        dateTimeFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        
        let dateTime = dateTimeFormatter.date(from: pickerDateTime)
        print(dateTime)
        if dateTime != nil{
            print("this is dateTime: \(dateTime)")
            
            if isTimeOnlyflag{
                
                dateTimeFormatter.dateFormat = "hh:mm:ss"
                let time = dateTimeFormatter.string(from: dateTime!)
                delegate?.getDateTime(dateTime: time, isTimeOnly: isTimeOnlyflag)
                self.dismiss(animated: true, completion: nil)
            }
            else{
                dateTimeFormatter.dateFormat = "yyyy-MM-dd"
                let date = dateTimeFormatter.string(from: dateTime!)
                delegate?.getDateTime(dateTime: date, isTimeOnly: isTimeOnlyflag)
                self.dismiss(animated: true, completion: nil)
            }
        }
        else{
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}

extension String{
    func dropLast(_ n: Int = 1) -> String {
        return String(characters.dropLast(n))
    }
    var dropLast: String {
        return dropLast()
    }
}
