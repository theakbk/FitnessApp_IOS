//
//  TableViewController.swift
//  FitnessApp
//
//  Created by Thea Kampmann on 07/04/2021.
//

import UIKit

class TableViewController: UIViewController, Updateable, UITableViewDelegate, UITableViewDataSource
{

    @IBAction func myUnwindAction(unwindSegue: UIStoryboardSegue)
    {}
    
    @IBOutlet weak var tableView: UITableView!
    
    
    func update(obj: NSObject?)
    {
        tableView.reloadData()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        print("tableview did load")

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let dest = segue.destination as? RegControllerViewController
        {
            dest.idx = tableView.indexPathForSelectedRow?.row ?? 0
            dest.wo = fs.getWo(index: tableView.indexPathForSelectedRow?.row ?? 0)
            dest.parent_view_controller = self

        }
        print("prepare is called \(segue.destination.description)")
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        print("tableview \(fs.workOuts.count)")
        return fs.workOuts.count
    }
        
    
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        print("tableview row \(indexPath.row)")
        //create content for one row at a time
        let cell = tableView.dequeueReusableCell(withIdentifier: "mycell", for: indexPath)
        let wo = fs.workOuts[indexPath.row]
        cell.textLabel?.text = String(wo.activity.prefix(15)+"    "+wo.duration
        )
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            print("edit called \(indexPath.row)")
            fs.deleteWorkout(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            // this requires, that the underlying datasource ALSO gets updated.
        }
 
}
