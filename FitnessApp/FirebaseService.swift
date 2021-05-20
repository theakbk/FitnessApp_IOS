//
//  FirebaseService.swift
//  FitnessApp
//
//  Created by Thea Kampmann on 01/04/2021.
//

import UIKit
import Foundation
import Firebase
import FirebaseStorage
import FirebaseFirestore


class FirebaseService
{
    private var db = Firestore.firestore()
       var storage = Storage.storage()
       var storageRef:StorageReference?
       var workOuts = [Workout]() // empty array
    private var workoutHisCol = "workoutHis"
    var parent:Updateable?

    func getWo(index:Int) -> Workout
    {
        return workOuts[index]
    }
    
    func addWorkout(wo:Workout)
    {
        print("addNote called with \(wo.activity)")
        if wo.activity.count > 0
        {
            let doc = db.collection(workoutHisCol).document() // will create a new document
            var data = [String:String]()  // creates a new, empty dictionary (map)
            data["Aktivitet"] = wo.activity // later, text comes from textField
            data["Tid"] = wo.duration
            doc.setData(data)  // will save to Firebase
            //workOuts.append(wo)
        }
    }
    
    func deleteWorkout(index:Int) {
            if index < workOuts.count {
                let docID = workOuts[index].id
                db.collection(workoutHisCol).document(docID).delete(){ err in
                    if let e = err {
                        print("error deleting \(docID) \(e)")
                    }else {
                        print("ok deleting \(docID)")
                    }
                }
                workOuts.remove(at: index) // will remove the item to be deleted
            }
        }
    
    
    func updateWorkout(wo:Workout, idx:Int = -1)
    {
        if idx >= 0
        {
            self.workOuts[idx] = wo
        }
        
        db.collection("workoutHis").document(wo.id).setData(
            [
                "Aktivitet": wo.activity,
                "Tid":wo.duration
            ]
        )
        
        {
            err in
           if let err = err
           {
               print("Error writing document: \(err)")
           }
           else
           {
               print("Document successfully written!")
           }
        }
    }
    
    func startListener(){ // will keep listening
            db.collection(workoutHisCol).addSnapshotListener { (snap, error) in
                print("fetched data callback")
                if let e = error {
                    print("error fetching data \(e)")
                }else {
                    print("fetched data")
                    if let s = snap {
                        self.workOuts.removeAll()
                        for doc in s.documents {
                            if let txt = doc.data()["Aktivitet"] as? String
                               , let dur = doc.data()["Tid"] as? String
                            {
                                print("Entry aktivitet id \(doc.documentID) \(txt) tid \(dur)")
                                let wo = Workout(id : doc.documentID, activity: txt, duration: dur)
                                self.workOuts.append(wo)
                                print("Entries \(self.workOuts.count)")
                            }
                        }
                        self.parent?.update(obj: nil)
                    }
                }
            }
        }
}
