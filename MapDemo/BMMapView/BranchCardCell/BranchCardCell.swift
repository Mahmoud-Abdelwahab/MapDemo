//
//  BranchCardView.swift
//  MapDemo
//
//  Created by Mahmoud Abdulwahab on 24/06/2023.
//

import UIKit

class BranchCardCell: UICollectionViewCell {
    
    @IBOutlet weak var branchNameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var branchAddressLabel: UILabel!
    @IBOutlet weak var supportOnlineBookingIcon: UIImageView!
    @IBOutlet weak var workingHoursIcon: UIImageView!
    @IBOutlet weak var workingHoursLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!

    static var identifier = "BranchCardCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    func setupUI() {
        self.layer.cornerRadius = 10

        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
        self.layer.shadowPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 280, height: 150), cornerRadius: 10).cgPath
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowOpacity = 0.4
        self.layer.shadowRadius = 3
    }

    func configureUI() {
       
    }

}
