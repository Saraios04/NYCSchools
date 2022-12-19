//
//  NYCSchoolListCell.swift
//  NYCSchools
//
//  Created by Sara on 15/12/22.
//

import UIKit

class NYCSchoolListCell: UITableViewCell {

    @IBOutlet weak var schoolNameLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var totalStudentLabel: UILabel!
    @IBOutlet weak var shadowView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        shadowView.addShadow()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setData(schoolDetail : SchoolDetail) {
        schoolNameLabel.text = schoolDetail.school_name
        overviewLabel.text = schoolDetail.overview_paragraph
        totalStudentLabel.text = "Total Student : \(schoolDetail.total_students ?? "")"
    }

}
