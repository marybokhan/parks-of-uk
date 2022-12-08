import UIKit

class ViewController: UIViewController {
    
    // MARK: - Type Definitions
    
    private enum Constants {
        static let spacing: CGFloat = 3
    }
    
    // MARK: - Private Properties
    
    private let topView: UIView = {
        let view = UIView()
        view.backgroundColor = AppConstants.Color.darkOliveGreen
        return view
    }()
    
    private let mainLabel: UILabel = {
        let label = UILabel()
        label.text = "National Parks of UK"
        label.textAlignment = .center
        label.textColor = AppConstants.Color.cornSilk
        label.backgroundColor = AppConstants.Color.darkOliveGreen
        label.font = .systemFont(ofSize: 30)
        return label
    }()
    
    private let flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = Constants.spacing
        flowLayout.minimumInteritemSpacing = Constants.spacing
        return flowLayout
    }()
    
    private let collectionView: UICollectionView
    
    private var sortedCountries: [String] = []
    private var parks: [String: [(name: String, image: UIImage)]] = [:]
    
    // MARK: - Init
    
    init() {
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.flowLayout)
        
        super.init(nibName: nil, bundle: nil)
        
        self.setupViews()
        self.decodeData(completion: { self.collectionView.reloadData() })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Private Logic
    
    private func setupViews() {
        self.view.backgroundColor = AppConstants.Color.laurelGreen
        self.collectionView.backgroundColor = AppConstants.Color.laurelGreen
        
        self.collectionView.register(CustomCollectionViewCell.self,
                                     forCellWithReuseIdentifier: CustomCollectionViewCell.identifier
        )
        self.collectionView.register(CountryHeaderView.self,
                                     forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                     withReuseIdentifier: CountryHeaderView.identifier
        )
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        self.topView.addSubview(self.mainLabel)
        
        self.mainLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.mainLabel.topAnchor.constraint(equalTo: self.topView.topAnchor, constant: 40),
            self.mainLabel.leftAnchor.constraint(equalTo: self.topView.leftAnchor),
            self.mainLabel.rightAnchor.constraint(equalTo: self.topView.rightAnchor),
            self.mainLabel.bottomAnchor.constraint(equalTo: self.topView.bottomAnchor)
        ])
        
        self.view.addSubview(self.topView)
        self.view.addSubview(self.collectionView)
        
//        [self.mainLabel, self.collectionView].forEach {
//            self.view.addSubview($0)
//            $0.translatesAutoresizingMaskIntoConstraints = false
//        }
        
        self.topView.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.topView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.topView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.topView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            self.topView.heightAnchor.constraint(equalToConstant: 200),
            
            self.collectionView.topAnchor.constraint(equalTo: self.mainLabel.bottomAnchor, constant: Constants.spacing),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        ])
    }
    
    private func decodeData(completion: @escaping () -> Void) {
        DispatchQueue.global().async {
            if let parksFileURL = Bundle.main.url(forResource: "Parks", withExtension: "json") {
                do {
                    let data = try Data(contentsOf: parksFileURL)
                    let jsonDecoder = JSONDecoder()
                    
                    // 1. decode parks in array (as default representation of json)
                    let decodedParks = try jsonDecoder.decode([Park].self, from: data)
                    
                    // 2. fill parks by countries
                    for park in decodedParks {
                        if self.parks[park.country] == nil {
                            self.parks[park.country] = []
                        }
                        
                        guard let url = URL(string: park.imageURL),
                              let data = try? Data(contentsOf: url),
                              let image = UIImage(data: data)
                        else { continue }
                        
                        let parkNameAndImage = (name: park.name, image: image)
        
                        self.parks[park.country]?.append(parkNameAndImage)
                    }
                    
                    // 3. save strict sorted sequence of countries in order to create correlation between number of section and country
                    self.sortedCountries = self.parks.keys.sorted()
                    
                    DispatchQueue.main.async {
                        completion()
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }

}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let country = self.sortedCountries[section]
        return self.parks[country]?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as? CustomCollectionViewCell
        else { return CustomCollectionViewCell(frame: .zero) }
        
        let country = self.sortedCountries[indexPath.section]
        
        guard let parkNamesAndImages = self.parks[country]
        else { return cell }
        
        let parkNameAndImage = parkNamesAndImages[indexPath.row]
        
        cell.configureLabel(label: parkNameAndImage.name)
        cell.configureImage(image: parkNameAndImage.image)
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.sortedCountries.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = self.collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CountryHeaderView.identifier, for: indexPath)
        let country = self.sortedCountries[indexPath.section]
        
        let countryHeaderView = headerView as? CountryHeaderView
        countryHeaderView?.configureLabel(country)
        
        return headerView
    }

}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.collectionView.bounds.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: Constants.spacing, left: 0, bottom: Constants.spacing, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let interitemSpacing = self.flowLayout.minimumInteritemSpacing
        let sideSize = (self.collectionView.frame.size.width / 2) - (interitemSpacing / 2)
        return CGSize(width: sideSize, height: sideSize)
    }
    
}
