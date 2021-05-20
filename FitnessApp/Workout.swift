//
//  Activity.swift
//  FitnessApp
//
//  Created by Thea Kampmann on 01/04/2021.
//

import Foundation
class Workout
{
    var id: String
    var activity:String
    var duration:String
    
    init(id:String = "", activity:String = "", duration:String = "")
    {
        self.id = id
        self.activity = activity
        self.duration = duration
    }
    
    
/*
    convenience init(activity:String = "", duration:String = "")
    {
        self.init(activity:activity, duration:duration)
        self.activity = activity
        self.duration = duration
    }
 */
}
