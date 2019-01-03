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
        dateTimePickerView.maximumDate = Date()
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
      
        
        let dateTimeFormatter = DateFormatter()
        dateTimeFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        dateTimeFormatter.locale = Locale(identifier: "en_US_POSIX")
        let dateTime = self.dateTimePickerView.date
     //   if dateTime != nil{
           // print("this is dateTime: \(dateTime)")
            if isTimeOnlyflag{
                dateTimeFormatter.dateFormat = "hh:mm a"
                let time = dateTimeFormatter.string(from: dateTime)
                delegate?.getDateTime(dateTime: time, isTimeOnly: isTimeOnlyflag)
                self.dismiss(animated: true, completion: nil)
            }
            else{
                dateTimeFormatter.dateFormat = "yyyy-MM-dd"
                let date = dateTimeFormatter.string(from: dateTime)
                delegate?.getDateTime(dateTime: date, isTimeOnly: isTimeOnlyflag)
                self.dismiss(animated: true, completion: nil)
            }
    //    }
//        else{
//            self.dismiss(animated: true, completion: nil)
//        }
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
