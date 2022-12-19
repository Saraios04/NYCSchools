//
//  NYCSchoolListViewController.swift
//  NYCSchools
//
//  Created by Sara on 15/12/22.
//

import UIKit

class NYCSchoolListViewController: UIViewController {
    
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    let cellIdentifier = "listCell"
    var schoolDetailsArray = [SchoolDetail]()
    @IBOutlet weak fileprivate var schoolListTableView: UITableView!
    var viewModel : NYCSchoolViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "NYC SCHOOL LIST"
        viewModel = NYCSchoolViewModel(withBaseUrl: Constants.API.BASE_URL)
        self.getSchoolList()
        // Do any additional setup after loading the view.
    }
    
    fileprivate func getSchoolList() {
        indicatorView.startAnimating()
        viewModel?.getSchoolDetail(completion: { [weak self] result in
            guard let strongSelf = self else {return}
            DispatchQueue.main.async {
                strongSelf.indicatorView.stopAnimating()
                strongSelf.indicatorView.isHidden = true
            }
            switch result {
            case .success(let data):
                strongSelf.schoolDetailsArray = data.schoolListArray
                DispatchQueue.main.async {
                    strongSelf.schoolListTableView.reloadData()
                }
            case .failure(let error):
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
extension NYCSchoolListViewController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schoolDetailsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! NYCSchoolListCell
        cell.selectionStyle = .none
        cell.setData(schoolDetail: schoolDetailsArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailController = storyboard.instantiateViewController(withIdentifier: "SATSchoolDetailViewController") as! SATSchoolDetailViewController
        self.navigationController?.pushViewController(detailController, animated: true)
        detailController.setSchoolDetail(detail: schoolDetailsArray[indexPath.row])
       
    }
    
    
}
