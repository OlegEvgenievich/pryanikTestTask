//
//  SelectorTableViewCell.swift
//  pryanikTest
//
//  Created by Олег Бабыр on 06.06.2021.
//

import UIKit

class SelectorTableViewCell: UITableViewCell, UIPickerViewDelegate, UIPickerViewDataSource {
    

    @IBOutlet var pryanikSelector: UIPickerView!
    var pickerData: PryanikItem!
    var selectedRow: Int?
    
    override func awakeFromNib() {
        pryanikSelector.layer.cornerRadius = 20
        pryanikSelector.delegate = self
        pryanikSelector.dataSource = self
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // MARK: - Picker view data source
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData!.variants!.count
    }
    // MARK: - Picker view delegate
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData!.variants![row].text
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedRow = pickerData.variants![row].id
        pickerData.selectedID = row + 1
        print(pickerData.selectedID)
    }
    
}
