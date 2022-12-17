import UIKit

class ParkViewController: UIViewController {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    private let parkName: UILabel = {
        let label = UILabel()
        label.textColor = AppConstants.Color.cornSilk
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 25)
        return label
    }()
    
    private let country: UILabel = {
        let label = UILabel()
        label.textColor = AppConstants.Color.cornSilk
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    private let keyActivities: UILabel = {
        let label = UILabel()
        label.textColor = AppConstants.Color.cornSilk
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 20)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        return label
    }()
    
    private let website: UITextView = {
        let textView = UITextView()
        textView.textAlignment = .left
        textView.backgroundColor = .clear
        textView.linkTextAttributes = [.link: AppConstants.Color.lemonMeringue, .font: UIFont.boldSystemFont(ofSize: 20)]
        return textView
    }()
    
    // MARK: - Init
    
    init(park: Park) {
        super.init(nibName: nil, bundle: nil)
        
        self.imageView.image = park.image
        self.parkName.text = park.name
        self.country.text = "📍 \(park.country)"
        self.keyActivities.text = "Key Activities: \(park.keyActivities)"
        
        let websiteAttributedString = NSMutableAttributedString(string: "Website: \(park.website)")
        let range = websiteAttributedString.mutableString.range(of: park.website)
        websiteAttributedString.addAttribute(.link, value: park.website, range: range)
        websiteAttributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range)
        
        self.website.attributedText = websiteAttributedString
        self.website.isSelectable = true
        self.website.font = .systemFont(ofSize: 20)
        self.website.textColor = AppConstants.Color.cornSilk
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateViewConstraints() {
        self.view.frame.origin.y = UIScreen.main.bounds.height - 600
        self.view.roundCorners(corners: [.topLeft, .topRight], radius: 10.0)
        super.updateViewConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    

    
    // MARK: - Private logic
    
    private func setupUI() {
        
        self.view.backgroundColor = AppConstants.Color.darkOliveGreen

        
        [self.imageView, self.parkName, self.country, self.keyActivities, self.website].forEach {
            self.view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            self.imageView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.imageView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            self.imageView.heightAnchor.constraint(equalToConstant: 250)
        ])
        
        NSLayoutConstraint.activate([
            self.parkName.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 5),
            self.parkName.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10),
            self.parkName.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.parkName.heightAnchor.constraint(equalToConstant: 35)
        ])
        
        NSLayoutConstraint.activate([
            self.country.topAnchor.constraint(equalTo: self.parkName.bottomAnchor, constant: 3),
            self.country.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10),
            self.country.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.country.heightAnchor.constraint(equalToConstant: 35)
        ])
        
        NSLayoutConstraint.activate([
            self.keyActivities.topAnchor.constraint(equalTo: self.country.bottomAnchor),
            self.keyActivities.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10),
            self.keyActivities.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -3),
            self.keyActivities.heightAnchor.constraint(equalToConstant: 70)
        ])
        
        NSLayoutConstraint.activate([
            self.website.topAnchor.constraint(equalTo: self.keyActivities.bottomAnchor),
            self.website.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 8),
            self.website.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.website.heightAnchor.constraint(equalToConstant: 70)
        ])
        

    }
    
}

extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
