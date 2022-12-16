import UIKit

class ParkViewController: UIViewController {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = AppConstants.Color.darkOliveGreen
        return imageView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
        stackView.backgroundColor = AppConstants.Color.laurelGreen
        return stackView
    }()
    
    private let parkName: UILabel = {
        let label = UILabel()
        label.text = "Text"
        label.lineBreakMode = .byWordWrapping
        label.backgroundColor = .orange
        label.textColor = AppConstants.Color.cornSilk
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let country: UILabel = {
        let label = UILabel()
        label.text = "Text"
        label.backgroundColor = .orange
        label.textColor = AppConstants.Color.cornSilk
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let keyActivities: UILabel = {
        let label = UILabel()
        label.text = "Text"
        label.backgroundColor = .orange
        label.textColor = AppConstants.Color.cornSilk
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let website: UILabel = {
        let label = UILabel()
        label.text = "Text"
        label.backgroundColor = .orange
        label.textColor = AppConstants.Color.cornSilk
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Internal logic
    
    private func configureParkName(parkName: String) {
        self.parkName.text = "Name: \(parkName)"
    }
    
    private func configureCountry(country: String) {
        self.country.text = "Country: \(country)"
    }
    
    private func configureKeyActivities(keyActivities: String) {
        self.keyActivities.text = "Key Activities: \(keyActivities)"
    }
    
    private func configureWebsite(website: URL) {
        self.website.text = "Website: \(website)"
    }
    
    // MARK: - Private logic
    
    private func setupUI() {
        [self.imageView, self.stackView].forEach {
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
            self.stackView.topAnchor.constraint(equalTo: self.imageView.bottomAnchor),
            self.stackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.stackView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.stackView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        ])
        
        [self.parkName, self.country, self.keyActivities, self.website].forEach {
            self.stackView.addArrangedSubview($0)
        }
    }
    
}
