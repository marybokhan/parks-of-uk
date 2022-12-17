import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    // MARK: - Internal Properties
    
    static let identifier = "CollectionViewCell"
    
    // MARK: - Private Properties
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let parkNameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = AppConstants.Color.darkOliveGreen
        label.textColor = AppConstants.Color.cornSilk
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.parkNameLabel.text = nil
    }
    
    // MARK: - Internal Logic
    
    func configureLabel(label: String) {
        self.parkNameLabel.text = label
    }
    
    func configureImage(image: UIImage) {
        self.imageView.image = image
    }
    
    // MARK: - Private Logic
    
    private func setupViews() {
        self.contentView.backgroundColor = AppConstants.Color.darkOliveGreen
        self.contentView.clipsToBounds = true
        
        [self.imageView, self.parkNameLabel].forEach {
            self.contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            self.imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.imageView.bottomAnchor.constraint(equalTo: self.parkNameLabel.topAnchor),
            self.imageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            self.imageView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
            
            self.parkNameLabel.heightAnchor.constraint(equalToConstant: 30),
            self.parkNameLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.parkNameLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 5),
            self.parkNameLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -5)
        ])
    }

}
