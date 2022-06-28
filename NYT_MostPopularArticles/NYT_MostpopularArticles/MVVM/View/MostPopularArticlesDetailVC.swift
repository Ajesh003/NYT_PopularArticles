

import UIKit

class MostPopularArticlesDetailVC: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var abstractLabel: UILabel!
    @IBOutlet weak var sectionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var byLineLabel: UILabel!
    @IBOutlet weak var publishDateLabel: UILabel!
    @IBOutlet weak var previewImageView: UIImageView!
    @IBOutlet weak var keywordsLabel: UILabel!
    @IBOutlet weak var lblCaption: UILabel!

    // MARK: - Properties
    var detailItem: MPAModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let model = detailItem {
            abstractLabel.text = model.abstract
            sectionLabel.text = model.section
            titleLabel.text = model.title
            byLineLabel.text = model.byline
            publishDateLabel.text = model.published_date
            keywordsLabel.text = model.adx_keywords
            lblCaption.text = self.detailItem!.media?.first?.caption
            
            MPAService.getImage(object: self.detailItem!) { (image, error) in
                
                DispatchQueue.main.async() { () -> Void in
                    self.previewImageView?.image = image
                }
            }
        }
    }


}

