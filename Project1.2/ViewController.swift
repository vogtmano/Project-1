//
//  ViewController.swift
//  Project1.2
//
//  Created by Maks Vogtman on 14/07/2022.
//

import UIKit

class ViewController: UITableViewController {
    var pictures = [String]()
    var sortedPictures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(recommend))
                
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }
        sortedPictures = pictures.sorted()
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pictures.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = sortedPictures[indexPath.row]
        cell.textLabel?.font = .systemFont(ofSize: 32, weight: .semibold)
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            vc.title = "Picture \(indexPath.row + 1) of \(pictures.count)"
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    @objc func recommend() {
        let vc = UIActivityViewController(activityItems: ["Share this app with other people!"], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
}

