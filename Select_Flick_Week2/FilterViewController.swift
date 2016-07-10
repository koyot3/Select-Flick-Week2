//
//  FilterViewController.swift
//  Select_Flick_Week2
//
//  Created by admin on 7/10/16.
//  Copyright © 2016 koyot3. All rights reserved.
//

import UIKit
protocol FiltersDelegate {
    func didChangedCriteria(filterController: FilterViewController, criteria: SearchCriteriaModel)
}

class FilterViewController: UITableViewController {

    @IBOutlet weak var showAdultChecker: UISwitch!
    @IBOutlet weak var releaseYearPick: UIPickerView!
    @IBOutlet weak var primaryReleaseYearPicker: UIPickerView!
    var criteria: SearchCriteriaModel!
    var delegate:FiltersDelegate!
    
    @IBAction func changeAdultSetting(sender: AnyObject) {
        self.criteria.showAdultConten = self.showAdultChecker.on
        delegate.didChangedCriteria(self, criteria: criteria)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.releaseYearPick.delegate = self
        self.primaryReleaseYearPicker.delegate = self
        self.releaseYearPick.dataSource = self
        self.primaryReleaseYearPicker.dataSource = self
        setTheme()
    }
    
    func setTheme(){
        self.showAdultChecker.on = criteria.showAdultConten
        if self.criteria.primaryReleaseYear != "Any year" && self.criteria.primaryReleaseYear != ""  {
            let a = 2016 - Int(self.criteria.primaryReleaseYear)! + 1
            self.primaryReleaseYearPicker.selectRow(2016 - Int(self.criteria.primaryReleaseYear)! + 1, inComponent: 0, animated: true)
        }
        if self.criteria.year != "Any year" && self.criteria.year != ""  {
            self.releaseYearPick.selectRow(2016 - Int(self.criteria.year)! + 1, inComponent: 0, animated: true)
        }

    }
}

extension FilterViewController : UIPickerViewDataSource {
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 101
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if row == 0 {
            return "Any year"
        } else {
            return String(2016 - row + 1)
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == releaseYearPick {
            if row != 0 {
                criteria.year = String(2016 - row + 1)
                delegate.didChangedCriteria(self, criteria: criteria)
            }
        } else if pickerView == primaryReleaseYearPicker {
            if row != 0 {
                criteria.primaryReleaseYear = String(2016 - row + 1)
                delegate.didChangedCriteria(self, criteria: criteria)
            }
        }
    }
    
    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return CGFloat(100)
    }
    
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        var titleData = "Any year"
        if row != 0 {
            titleData = String(2016 - row + 1)
        }
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 13.0)!,NSForegroundColorAttributeName:UIColor.orangeColor()])
        return myTitle
    }
}

extension FilterViewController : UIPickerViewDelegate {
    
}
