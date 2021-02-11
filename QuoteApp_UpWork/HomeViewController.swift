//
//  CollectionViewController.swift
//  QuoteApp_UpWork
//
//  Created by Abdurakhmon Jamoliddinov on 2/11/21.
//

import UIKit

private let reuseIdentifier = "MyCell"
private let STATUS_BAR_HEIGHT = 20

class HomeViewController: UIViewController,
                          UICollectionViewDelegate,
                          UICollectionViewDataSource,
                          UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height - CGFloat(STATUS_BAR_HEIGHT / 2)
        layout.estimatedItemSize = CGSize(width: width, height: height)
        return layout
    }()
    
    
    let array = [
        "I'm selfish, impatient and a little insecure. I make mistakes, I am out of control and at times hard to handle. But if you can't handle me at my worst, then you sure as hell don't deserve me at my best.",
        "Be yourself; everyone else is already taken.",
        "Two things are infinite: the universe and human stupidity; and I'm not sure about the universe.",
        "So many books, so little time.",
        "A room without books is like a body without a soul.",
        "Be who you are and say what you feel, because those who mind don't matter, and those who matter don't mind.",
        "You've gotta dance like there's nobody watching, Love like you'll never be hurt, Sing like there's nobody listening, And live like it's heaven on earth.",
        "You know you're in love when you can't fall asleep because reality is finally better than your dreams.",
        "You only live once, but if you do it right, once is enough.",
        "Be the change that you wish to see in the world.",
        "In three words I can sum up everything I've learned about life: it goes on.",
        "If you want to know what a man's like, take a good look at how he treats his inferiors, not his equals.",
        "Don’t walk in front of me… I may not follow Don’t walk behind me… I may not lead Walk beside me… just be my friend",
        "No one can make you feel inferior without your consent.",
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.collectionViewLayout = layout
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
}
