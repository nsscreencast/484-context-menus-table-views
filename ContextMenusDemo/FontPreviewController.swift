//
//  FontPreviewController.swift
//  ContextMenusDemo
//
//  Created by Ben Scheirman on 3/23/21.
//

import UIKit

class FontPreviewController: UITableViewController {
    var fontFamily: String!
    
    let sizes: [CGFloat] = [48, 32, 24, 16, 12]
    let template = "The Quick Brown Fox Jumped Over the Lazy Dog"
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sizes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FontPreviewCell", for: indexPath) as! FontPreviewCell
        cell.label.text = template
        cell.label.font = UIFont(name: fontFamily, size: sizes[indexPath.row])
        return cell
    }
}

class FontPreviewCell: UITableViewCell {
    @IBOutlet weak var label: UILabel!
}

