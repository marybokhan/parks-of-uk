import UIKit

class ViewController: UIViewController {
    
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
        flowLayout.minimumLineSpacing = 5
        flowLayout.minimumInteritemSpacing = 5
        return flowLayout
    }()
    
    private let collectionView: UICollectionView
    
    private var parks = [Park]()
    
    // MARK: - Init
    
    init() {
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.flowLayout)
        
        super.init(nibName: nil, bundle: nil)
        
        self.decodeData()
        self.setupViews()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.collectionView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.flowLayout.itemSize = CGSize(width: (self.view.frame.size.width / 2) - 2.5, height: (self.view.frame.size.width / 3))
    }
    
    // MARK: - Private Logic
    
    private func setupViews() {
        self.view.backgroundColor = .systemBackground
        
        self.collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
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
            
            self.collectionView.topAnchor.constraint(equalTo: self.mainLabel.bottomAnchor, constant: 5),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        ])
    }
    
    private func decodeData() {
        if let parksFileURL = Bundle.main.url(forResource: "Parks", withExtension: "json") {
            do {
                let data = try Data(contentsOf: parksFileURL)
                let jsonDecoder = JSONDecoder()
                let decodedParks = try jsonDecoder.decode([Park].self, from: data)
                self.parks = decodedParks
            } catch {
                print(error.localizedDescription)
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
        
        let stringUrl = parks[indexPath.row].imageURL
        guard let url = URL(string: stringUrl) else {
            return cell
        }
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                print("download for cell at index: \(indexPath.row)")
                DispatchQueue.main.async {
                    cell.imageView.image = UIImage(data: data)
                }
            }
        }
        
        cell.parkNameLabel.text = parks[indexPath.row].name
        
        return cell
    }
    
}

extension ViewController: UICollectionViewDelegate {
    
}
