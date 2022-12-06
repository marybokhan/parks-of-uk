import UIKit

class ViewController: UIViewController {
    
    // MARK: - Type Definitions
    
    private enum Constants {
        static let spacing: CGFloat = 3
    }
    
    // MARK: - Private Properties
    
    private let mainLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemGreen
        label.text = "National Parks of UK"
        label.textColor = .white
        label.textAlignment = .center
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
    
    private var parks = [Park]()
    private var imageCache: [URL: UIImage] = [:]
    
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
        self.view.backgroundColor = .systemBackground
        
        self.collectionView.register(CustomCollectionViewCell.self,
                                     forCellWithReuseIdentifier: CustomCollectionViewCell.identifier
        )
        self.collectionView.register(CountryHeaderView.self,
                                     forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                     withReuseIdentifier: CountryHeaderView.identifier
        )
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        [self.mainLabel, self.collectionView].forEach {
            self.view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            self.mainLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.mainLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.mainLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            self.mainLabel.heightAnchor.constraint(equalToConstant: 170),
            
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
                    let decodedParks = try jsonDecoder.decode([Park].self, from: data)
                    self.parks = decodedParks
                    
                    for park in decodedParks {
                        guard let url = URL(string: park.imageURL),
                              let data = try? Data(contentsOf: url),
                              let image = UIImage(data: data)
                        else { continue }
                        
                        self.imageCache[url] = image
                    }
                    
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
    
    // TODO: - Sort parks by country and pack them into sections.
    // 1. - Decode json into array of Park
    // 2. - Split the original array into n arrays with a dedicated country parks
    // 3. - Learn how to create section in collection view
    // 4. - Create headers in collectrion view sections
    // 5. - Configure each section header taking in account current country
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.parks.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as? CustomCollectionViewCell
        else { return CustomCollectionViewCell(frame: .zero) }
        
        cell.configureLabel(label: self.parks[indexPath.row].name)
        
        let stringUrl = self.parks[indexPath.row].imageURL
        guard let url = URL(string: stringUrl),
              let image = self.imageCache[url]
        else { return cell }
        
        cell.configureImage(image: image)
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // Add other value after creating 3 arrays to separate them into 3 sections
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = self.collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CountryHeaderView.identifier, for: indexPath)
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
