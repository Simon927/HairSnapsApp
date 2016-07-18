//
//  CommentMoreCell.swift
//  HairSnaps
//
//  Created by Xin YingTai on 21/11/14.
//  Copyright (c) 2014 Xin YingTai. All rights reserved.
//
// --- Headers ---;
import UIKit

// --- Defines ---;
// CommentMoreCellDelegate Protocol;
protocol CommentMoreCellDelegate: NSObjectProtocol {
    func didLoadMore()
}

// CommentMoreCell Class;
class CommentMoreCell: UITableViewCell {

    weak var delegate: CommentMoreCellDelegate! = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func onBtnMore(sender: AnyObject) {
        // Load More;
        if (delegate.respondsToSelector("didLoadMore")) {
            delegate.didLoadMore()
        }
    }
}
