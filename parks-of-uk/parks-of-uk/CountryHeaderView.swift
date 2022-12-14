import UIKit

class CountryHeaderView: UICollectionReusableView {
    
    // MARK: - Interal Properties
    
    static let identifier = "CountryHeaderView"
    
    // MARK: - Private properties
    
    private let countryLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = AppConstants.Color.cornSilk
        label.backgroundColor = AppConstants.Color.darkOliveGreen
        label.font = .systemFont(ofSize: 25)
        return label
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Internal logic
    
    func configureLabel(_ label: String) {
        self.countryLabel.text = label
    }
    
    // MARK: - Private logic
    
    private func setupUI() {
        self.addSubview(self.countryLabel)
        self.countryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.countryLabel.topAnchor.constraint(equalTo: self.topAnchor),
            self.countryLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.countryLabel.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.countryLabel.rightAnchor.constraint(equalTo: self.rightAnchor)
        ])
    }
    
}
