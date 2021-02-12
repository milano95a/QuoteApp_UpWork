//
//  AddViewController.swift
//  QuoteApp_UpWork
//
//  Created by Abdurakhmon Jamoliddinov on 2/12/21.
//

import UIKit
import FirebaseDatabase

class AddViewController: UIViewController, UITextViewDelegate {

    private let db = Database.database().reference()
    @IBOutlet weak var quoteTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        quoteTextView.delegate = self
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return textView.text.count + (text.count - range.length) <= 140
    }
    
    @IBAction func onAdd(_ sender: UIButton) {
        guard  let newQuote = quoteTextView.text,
               !quoteTextView.text.trimmingCharacters(in:.whitespacesAndNewlines).isEmpty else {
            return
        }
        
        let id = UUID().uuidString
        let quoteObject: [String: Any] = ["quote": newQuote]
        
        db.child("quotes").child(id).setValue(quoteObject) { error, ref in
            if let error = error {
                print("error: \(error)")
            } else {
                print("successfully saved")
            }
        }
        dismiss(animated: true)
    }
    
    @IBAction func onCancel(_ sender: UIButton) {
        dismiss(animated: true)
    }

}
