//
//  ViewController.swift
//  MeaningTestMACYS
//
//  Created by srikanth reddy vangala on 4/14/17.
//  Copyright © 2017 srikanth reddy vangala. All rights reserved.
//

import UIKit
var meanObj = [MeaningModel]()
var alert : UIAlertController?

class MeaningViewController: UIViewController {

    @IBOutlet weak var searchTxtFld: UITextField!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var abbrevationTableVW: UITableView!
    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        abbrevationTableVW.tableFooterView = UIView()
    }
    
    func getArcomineDataWithParameter(parameter: String){
        
        AcromineClient.getDataFromAcromine(parameter: parameter, completion: {(meanObjects, error) in
            meanObj = meanObjects
            self.hideLoader()
            if meanObj.count > 0 {
                self.abbrevationTableVW.reloadData()
                self.abbrevationTableVW.isHidden = false
                self.label.isHidden = true
            }else {
                self.label.isHidden = false
                self.abbrevationTableVW.isHidden = true
                self.label.text = "NO RESULT"
                
                
            }
            
        })
    }
    
    
    @IBAction func searchBtnTapped(_ sender: Any) {
        
        if (searchTxtFld.text?.characters.count)! > 0 {
            
            showHUDLoader()
            getArcomineDataWithParameter(parameter: searchTxtFld.text!)
            
        }else{
            self.showAlertMessage(message: "Please Enter Some thing to Search.")
        }
        
    }
    
    
    func showAlertMessage(message:String)  {
        
        alert = UIAlertController(title: "", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert?.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:nil))
        self.present(alert!, animated: true, completion: nil)
    }
    
    func showHUDLoader(){
        ///Showing Loader
        let loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        loadingNotification.label.text = "Loading"
    }
    
    func hideLoader(){
        
        MBProgressHUD.hide(for: self.view, animated: true)
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
extension MeaningViewController : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meanObj.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let abbrevObj = meanObj[indexPath.row]
        var cell = tableView.dequeueReusableCell(withIdentifier: "CELL")
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "CELL")
        }
        
        cell!.textLabel?.text = abbrevObj.abbrevation
        cell!.textLabel?.numberOfLines = 0
        return cell!
    }
    
    
}
extension MeaningViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        meanObj.removeAll()
        self.abbrevationTableVW.reloadData()
        return true
    }
}


