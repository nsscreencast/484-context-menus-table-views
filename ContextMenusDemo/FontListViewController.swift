//
//  FontListViewController.swift
//  ContextMenusDemo
//
//  Created by Ben Scheirman on 3/23/21.
//

import UIKit

class FontListViewController: UITableViewController {
    
    private var favorites: Set<String> = []
    
    var fonts: [UIFont]! {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "fontCell")
        fonts = UIFont.familyNames.compactMap { family in
            UIFont(name: family, size: 16)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fonts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fontCell", for: indexPath)
        cell.textLabel?.text = fonts[indexPath.row].familyName
        cell.textLabel?.font = fonts[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let font = fonts[indexPath.row]
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ -> UIMenu? in
            let copyAction = UIAction(title: "Copy", image: UIImage(systemName: "doc.on.doc"), identifier: nil) { _ in
                UIPasteboard.general.string = font.familyName
            }
            
            let favoriteAction = UIAction(title: "Favorite", image: UIImage(systemName: "heart.fill"), identifier: nil,  state: .off) { _ in
                self.favorites.insert(font.familyName)
            }
            
            let unfavoriteAction = UIAction(title: "Unfavorite", image: UIImage(systemName: "heart.slash.fill"), identifier: nil, state: .on) { _ in
                self.favorites.remove(font.familyName)
            }
            
            let favAction: UIAction = self.favorites.contains(font.familyName) ? unfavoriteAction : favoriteAction
            
            return UIMenu(title: font.familyName, image: nil, identifier: nil, options: [], children: [
                            copyAction, favAction
            ])
        }
    }
}
