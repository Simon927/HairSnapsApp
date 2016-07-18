//
//  CommentPostCell.swift
//  HairSnaps
//
//  Created by Xin YingTai on 21/11/14.
//  Copyright (c) 2014 Xin YingTai. All rights reserved.
//
// --- Headers ---;
import UIKit

// --- Defines ---;
// CommentPostCellDelegate Protocol;
protocol CommentPostCellDelegate: NSObjectProtocol {
    func didBeginEditing()
    func didEndEditing()
}

// CommentPostCell Class;
class CommentPostCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var commentText: UITextField!
    
    weak var delegate: CommentPostCellDelegate! = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        if (delegate.respondsToSelector("didBeginEditing")) {
            delegate.didBeginEditing()
        }
        
        return false
    }
}
