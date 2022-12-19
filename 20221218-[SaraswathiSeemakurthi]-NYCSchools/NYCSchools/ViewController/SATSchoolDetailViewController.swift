//
//  SATSchoolDetailViewController.swift
//  NYCSchools
//
//  Created by Sara on 16/12/22.
//

import UIKit

class SATSchoolDetailViewController: UIViewController {
    
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak fileprivate var schoolListTableView: UITableView!
    var schoolSATDetails : SATDetail?
    var viewModel : NYCSchoolViewModel?
    var schoolDetail : SchoolDetail?
    @IBOutlet weak var num_of_sat_test_takers: UILabel!
    @IBOutlet weak var sat_critical_reading_avg_score: UILabel!
    @IBOutlet weak var sat_math_avg_score: UILabel!
    @IBOutlet weak var sat_writing_avg_score: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var noRecordFoundView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.noRecordFoundView.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    func setSchoolDetail(detail: SchoolDetail) {
        viewModel = NYCSchoolViewModel(withBaseUrl: Constants.API.BASE_URL)
        self.schoolDetail = detail
        getSchoolSATList()
    }
    
    fileprivate func getSchoolSATList() {
        
        DispatchQueue.main.async {
            if self.indicatorView != nil{
                self.indicatorView.startAnimating()
            }
        }
        viewModel?.getSATSchoolData(completion: { [weak self] result in
            guard let strongSelf = self else {return}
            DispatchQueue.main.async {
                strongSelf.indicatorView.stopAnimating()
                strongSelf.indicatorView.isHidden = true
            }
            switch result {
            case .success(let data):
                
                if let schoolDetail = data.satSchoolDetailListArray.first(where: {$0.dbn == strongSelf.schoolDetail?.dbn}) {
                    strongSelf.schoolSATDetails = schoolDetail
                    DispatchQueue.main.async {
                        self?.noRecordFoundView.isHidden = true
                        self?.title = strongSelf.schoolDetail?.school_name
                        self?.num_of_sat_test_takers.text = strongSelf.schoolSATDetails?.num_of_sat_test_takers
                        self?.sat_critical_reading_avg_score.text = strongSelf.schoolSATDetails?.sat_critical_reading_avg_score
                        self?.sat_math_avg_score.text = strongSelf.schoolSATDetails?.sat_math_avg_score
                        self?.sat_writing_avg_score.text = strongSelf.schoolSATDetails?.sat_writing_avg_score
                        self?.overviewLabel.text = strongSelf.schoolDetail?.overview_paragraph
                    }
                } else {
                    DispatchQueue.main.async {
                      self?.noRecordFoundView.isHidden = false
                    }
                }
            case .failure(let error):
                self?.noRecordFoundView.isHidden = false
                if strongSelf.viewModel?.errorMsg?.isEmpty ==  false {
                    Alert.displayAlert(title: strongSelf.viewModel?.errorMsg ?? "", message: "", view: strongSelf)
                }else if error == .notReachable {
                    Alert.displayAlert(title: Constants.ErrorMessage.INTERNET_CONNECTIVITY, message: "", view: strongSelf)
                }else  {
                    Alert.displayAlert(title: Constants.ErrorMessage.SOMETHING_WENT_WRONG, message: "", view: strongSelf)
                }
            }
        })
    }
    
}
