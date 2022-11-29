import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Internal Properties
    
    static let identifier = "CustomCollectionViewCell"
    
    // MARK: - Private Properties
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemGray5
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let parkNameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemGreen
        label.textColor = .white
        label.textAlignment = .center
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
    
    func configure(label: String) {
        self.parkNameLabel.text = label
    }
    
    // MARK: - Private Logic
    
    private func setupViews() {
        self.contentView.backgroundColor = .systemPink
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
            self.parkNameLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            self.parkNameLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor)
        ])
    }
}
