//
//  BasePickerView.swift
//  PickerView
//
//  Created by Rocoo on 2017/7/7.
//  Copyright © 2017年 rocoo. All rights reserved.
//

import UIKit

class BasePickerView: UIViewController {
  
  @IBOutlet weak var textField: UITextField!
  
  var timePickerView: UIPickerView!
  var timeslotData: [String] = ["10:00", "12:00", "13:00", "17:00", "21:00"]
  var timeSelectedRow = 0
  var timeStartRow = 0
  var isTimePickerDone = false
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    initPickerView()
  }
  
  
  func initPickerView(){
    
    timePickerView = UIPickerView()
    timePickerView.delegate = self
    timePickerView.dataSource = self
    timePickerView.backgroundColor = .white
    
    
    textField.inputView = timePickerView
    
    
    let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: Device.screenWidth, height: 44))
    
    let cancelBtn = UIButton(frame: CGRect(x: 10, y: 5, width: 70, height: 30))
    cancelBtn.setTitle("Cancel", for: .normal)
    cancelBtn.addTarget(self, action: #selector(cencel(sender:)), for: .touchUpInside)
    cancelBtn.backgroundColor = colorFromRGB(185, green: 189, blue: 190)
    cancelBtn.setTitleColor(colorFromRGB(67, green: 112, blue: 183), for: .normal)
    cancelBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
    cancelBtn.layer.cornerRadius = 8
    
    let cancelItem = UIBarButtonItem(customView: cancelBtn)
    
    
    let doneBtn = UIButton(frame: CGRect(x: 10, y: 5, width: 70, height: 30))
    doneBtn.setTitle("Done", for: .normal)
    doneBtn.addTarget(self, action: #selector(done(sender:)), for: .touchUpInside)
    doneBtn.backgroundColor = colorFromRGB(185, green: 189, blue: 190)
    doneBtn.setTitleColor(colorFromRGB(67, green: 112, blue: 183), for: .normal)
    doneBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
    doneBtn.layer.cornerRadius = 8
    
    let rightItem = UIBarButtonItem(customView: doneBtn)
    
    let spaceItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
    
    toolBar.items = [cancelItem, spaceItem, rightItem]
    
    textField.inputAccessoryView = toolBar
    
  }
  
  func cencel(sender: UIButton){
    isTimePickerDone = false
    dismissKeyboard()
  }
  
  func done(sender: UIButton){
    isTimePickerDone = true
    timeSelectedRow = timePickerView.selectedRow(inComponent: 0)
    textField.text = timeslotData[timeSelectedRow]
    
    dismissKeyboard()
  }
  
  func dismissKeyboard(){
    view.endEditing(true)
  }
  
}


// MARK: - UITextFieldDelegate
extension BasePickerView: UITextFieldDelegate{
  func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    
    timeStartRow = timeSelectedRow
    timePickerView.selectRow(timeSelectedRow, inComponent: 0, animated: false)
    
    return true
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    
    if !isTimePickerDone{
      timePickerView.selectRow(timeStartRow, inComponent: 0, animated: false)
      timeSelectedRow = timeStartRow
    }
    
    isTimePickerDone = false
    
  }
  
}

// MARK: - UIPickerViewDelegate, UIPickerViewDataSource
extension BasePickerView: UIPickerViewDelegate, UIPickerViewDataSource{
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return timeslotData.count
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return timeslotData[row]
  }
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
}
