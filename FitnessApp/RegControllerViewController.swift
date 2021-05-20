//
//  RegControllerViewController.swift
//  FitnessApp
//
//  Created by Thea Kampmann on 01/04/2021.
//

import UIKit

class RegControllerViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    @IBOutlet weak var Activity: UIPickerView!
    @IBOutlet weak var Time: UIPickerView!
    
    var activityArray = ["Run", "Bike", "weightlift", "Benchpress", "push-ups"]
    var timearray = ["10-20", "20-30", "30-40", "40-50", "50-60", "60+"]
    
    var wo = Workout()
    var idx:Int = -1
    var parent_view_controller : TableViewController? = nil

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDefaults()
    }

    
    
    func setDefaults()
    {
        if wo.activity.count > 0
        {
            if let indexPosition = activityArray.firstIndex(of: wo.activity)
            {

                Activity.selectRow(indexPosition, inComponent: 0, animated: true)
            }
            
        }
        
        if wo.duration.count > 0
        {
            if let indexPosition = timearray.firstIndex(of: wo.duration)
            {

                Time.selectRow(indexPosition, inComponent: 0, animated: true)
            }
            
        }
         
   }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    
    //Make sure that the pickerviews has the number of rows
    //that the arrays has elements
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        var countrows : Int = activityArray.count

        if pickerView == Time
        {
            countrows = self.timearray.count
        }
        return countrows
    }
    
    //Fyld pickerview med elementerne fra de to arrays
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        if pickerView == Activity
        {
            let titleRow = activityArray[row]
            return titleRow
        }
        
        else if pickerView == Time
        {
            let titleRow = timearray[row]
            return titleRow
        }

        return ""
    }
    
    @IBAction func SaveToFirebase(_ sender: Any)
    {
        print("press save")
        wo.activity = activityArray[Activity.selectedRow(inComponent: 0)]
        wo.duration = timearray[Time.selectedRow(inComponent: 0)]
        
        if wo.id.isEmpty
        {
            fs.addWorkout(wo: wo)
        }
        else
        {
            fs.updateWorkout(wo:wo, idx:idx)
            parent_view_controller?.update(obj:self)

        }
    }
}
