//
//  CollectionViewController.swift
//  QuoteApp_UpWork
//
//  Created by Abdurakhmon Jamoliddinov on 2/11/21.
//

import UIKit
import FirebaseDatabase

private let reuseIdentifier = "MyCell"
private let STATUS_BAR_HEIGHT = 20

protocol ViewControllerHandler {
    func dismissed()
}

class HomeViewController: UIViewController,
                          UICollectionViewDelegate,
                          UICollectionViewDataSource,
                          UICollectionViewDelegateFlowLayout,
                          ViewControllerHandler
{
    // MARK: Outlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: Properties
    
    private let db = Database.database().reference()
    private var array = [String]()
    private var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height - CGFloat(STATUS_BAR_HEIGHT / 2)
        layout.estimatedItemSize = CGSize(width: width, height: height)
        return layout
    }()
    
    // MARK: Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.collectionViewLayout = layout
        
        syncTableView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? AddViewController {
            vc.delegate = self
        }
    }
    
    // MARK: ViewControllerHandler
    
    func dismissed() {
        syncTableView()
    }
    
    // MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! QuoteCollectionViewCell
        
        cell.quoteLabel.frame.size.width = UIScreen.main.bounds.size.width - CGFloat(STATUS_BAR_HEIGHT)
        cell.quoteLabel.frame.size.height = UIScreen.main.bounds.size.height
        cell.quoteLabel.backgroundColor = .clear
        cell.quoteLabel.text = array[indexPath.item]
        
        return cell
    }
    
    // MARK: Private
    
    private func syncTableView(){
        var newArray = [String]()
        
        db.child("quotes").observeSingleEvent(of: .value) { [weak self] snapshot in
            guard let quotes = snapshot.value as? [String: Any] else {
                return
            }
            for quote in quotes.values {
                guard let quoteText = quote as? [String: String] else {
                    return
                }
                newArray.append(quoteText.values.first!)
            }
            
            DispatchQueue.main.async {
                self?.array = newArray
                self?.collectionView.reloadData()
            }
        }
    }

}
