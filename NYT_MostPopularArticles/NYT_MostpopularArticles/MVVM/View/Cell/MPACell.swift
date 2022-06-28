
import UIKit

class MPACell: UITableViewCell {
    
    @IBOutlet weak var imageIcon: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblByLine: UILabel!
    @IBOutlet weak var lblSection: UILabel!
    @IBOutlet weak var lblPublishedDate: UILabel!


    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageIcon.clipsToBounds = true;
        imageIcon.layer.cornerRadius = 10;
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(model: MPAModel) {
        lblTitle.text = model.title ?? "-----"
        lblByLine.text =   model.byline ?? "-----" // sender.date?.toUserString() ?? "------"
        lblPublishedDate.text = model.published_date ?? "-----"
        lblSection.text = model.section ?? "-----"
        
        
        
        MPAService.getImage(object: model) { (image, error) in
            DispatchQueue.main.async() { () -> Void in
                self.imageIcon?.image = image
            }
        }
    }
}

