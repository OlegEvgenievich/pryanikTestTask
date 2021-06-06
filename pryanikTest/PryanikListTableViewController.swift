//
//  PryanikListTableViewController.swift
//  pryanikTest
//
//  Created by Олег Бабыр on 06.06.2021.
//

import UIKit

class PryanikListTableViewController: UITableViewController {
   
    var pryanikData = [PryanikData]()
    var pryanikViews = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PryanikItemController.shared.fetchPryanik { result in
            switch result {
            case .success(let pryanik):
                self.updateUI(withPryanik: pryanik)
            case .failure(let error):
                self.displayError(error, title: "Не удалось загрузить пряник :(")
            }
        }
    }
    
    func updateUI(withPryanik pryanik: Pryanik) {
        DispatchQueue.main.async {
            self.pryanikData = pryanik.data
            self.pryanikViews = pryanik.view
            self.tableView.reloadData()
        }
    }
    
    func displayError(_ error: Error, title: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

    func configureTextCell(_ cell: TextTableViewCell, forPryanikItemName name: String) {
        
        let pryanikItem = PryanikItemController.shared.findPryanikItem(withName: name, inPryanikData: pryanikData)
        
        cell.pryanikLabel.text = pryanikItem?.text
    }
    
    func configureImageCell(_ cell: PictureTableViewCell, forPryanikItemName name: String, indexPath: IndexPath) {
        
        let pryanikItem = PryanikItemController.shared.findPryanikItem(withName: name, inPryanikData: pryanikData)
        
        PryanikItemController.shared.fetchImage(url: pryanikItem!.url!) { image in
            guard let image = image else { return }
            
            DispatchQueue.main.async {
                if let currentPathIndex = self.tableView.indexPath(for: cell),
                   currentPathIndex != indexPath {
                    return
                }
                cell.pryanikPictureImageView.image = image
                cell.pryanikPictureTextLabel.text = pryanikItem!.text!
            }
        }
    }
    
    func configureSelectorCell(_ cell: SelectorTableViewCell, forPryanikItemName name: String, withIndexPath indexPath: IndexPath) {
        let pryanikItem = PryanikItemController.shared.findPryanikItem(withName: name, inPryanikData: self.pryanikData)!
        cell.pickerData = pryanikItem
        cell.pryanikSelector.reloadAllComponents()
        self.tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    @IBSegueAction func showInfoWithTextCell(_ coder: NSCoder, sender: Any?) -> ObjectInfoViewController? {
        guard let cell = sender as? TextTableViewCell, let indexPath = tableView.indexPath(for: cell) else { return nil}
        return ObjectInfoViewController(coder: coder, objectInfoText: pryanikViews[indexPath.row])
    }
    
    @IBSegueAction func showInfoWithPictureCell(_ coder: NSCoder, sender: Any?) -> ObjectInfoViewController? {
        guard let cell = sender as? PictureTableViewCell, let indexPath = tableView.indexPath(for: cell) else { return nil}
        return ObjectInfoViewController(coder: coder, objectInfoText: pryanikViews[indexPath.row])
    }
    
    @IBSegueAction func showInfoWithSelectorCell(_ coder: NSCoder, sender: Any?) -> ObjectInfoViewController? {
        guard let cell = sender as? SelectorTableViewCell, let chosenId = cell.pickerData.selectedID, let indexPath = tableView.indexPath(for: cell)   else { return nil }
        return ObjectInfoViewController(coder: coder, objectInfoText: "Объект: \(pryanikViews[indexPath.row]). ID ответа, инициировавшего переход: \(chosenId)")
    }
    
 

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pryanikViews.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if pryanikViews[indexPath.row] == "selector" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "selectorCell", for: indexPath) as! SelectorTableViewCell
            configureSelectorCell(cell, forPryanikItemName: pryanikViews[indexPath.row], withIndexPath: indexPath)
            return cell
        }
        else if pryanikViews[indexPath.row] == "picture" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as! PictureTableViewCell
            configureImageCell(cell, forPryanikItemName: pryanikViews[indexPath.row], indexPath: indexPath)
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "textCell", for: indexPath) as! TextTableViewCell
            configureTextCell(cell, forPryanikItemName: pryanikViews[indexPath.row])
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
