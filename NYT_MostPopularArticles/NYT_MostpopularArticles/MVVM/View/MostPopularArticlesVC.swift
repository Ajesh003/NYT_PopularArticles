

import UIKit

class MostPopularArticlesVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var datasource: [MPAModel] = []
    var selectedArticle:MPAModel?
    let detailsSegueId = "showMostPopularArticleDetails"
    
    var viewModel: MostPopularArticleVM = MostPopularArticleVM(articles: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = UIColor.white

        
        tableViewSettings()
            
        viewModel.refreshUI = {[weak self] in
            DispatchQueue.main.async() { () -> Void in
            self?.tableView.reloadData()
            }
        }
    }
    
    func tableViewSettings() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = UIColor.clear
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "MPACell", bundle: nil), forCellReuseIdentifier: "cell")

        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == detailsSegueId {
            let detailsVC = segue.destination as! MostPopularArticlesDetailVC
            detailsVC.detailItem = selectedArticle
        }
    }
}


extension MostPopularArticlesVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MPACell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MPACell
        cell.configureCell(model: viewModel.articleForIndex(index: indexPath.row))
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedArticle = viewModel.articleForIndex(index: indexPath.row)
        performSegue(withIdentifier: detailsSegueId, sender: nil)
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
 
  
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
               
               let label = UILabel()
               label.frame = CGRect.init(x: 5, y: 5, width: headerView.frame.width-10, height: 20)
               label.text = "Most Popular Articles"
             //  label.font = .systemFont(ofSize: 16)
                label.font = UIFont.boldSystemFont(ofSize: 18.0)

               label.textColor = .black
        
                headerView.backgroundColor = UIColor.lightGray
               
               headerView.addSubview(label)
               
               return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
       
        let footerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 20))
        
        let label = UILabel()
        label.frame = CGRect.init(x: 5, y: 5, width: footerView.frame.width-10, height: 20)
        label.text = "Data fetched from NY Times API"
      //  label.font = .systemFont(ofSize: 16)
        label.font = UIFont.boldSystemFont(ofSize: 12.0)

        label.textColor = .black
        label.textAlignment = .center
 
         footerView.backgroundColor = UIColor.lightGray
        
        footerView.addSubview(label)
        
        return footerView
    }
    
}
