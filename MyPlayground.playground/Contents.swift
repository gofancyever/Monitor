//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class CustomLayout:UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let array = super.layoutAttributesForElements(in: rect)
        if let collectionView = self.collectionView  {
            let visiableRect = CGRect(x: collectionView.frame.origin.x, y: collectionView.frame.origin.y, width: collectionView.frame.width, height: collectionView.frame.height)
            var candidateAttributes: UICollectionViewLayoutAttributes?
            if let arr = array {
                for attributes in arr {
                    guard attributes.representedElementCategory == .cell else { continue }
                    guard candidateAttributes != nil else {
                        candidateAttributes = attributes
                        continue
                    }
                    let frame = attributes.frame
                    let distance = abs(collectionView.contentOffset.x + collectionView.contentInset.left - frame.origin.x)
                    let scale = min(max(1 - distance/(collectionView.bounds.width), 0.85), 1)
                    attributes.transform =
                        CGAffineTransform(scaleX: scale, y: scale)
                }
            }
        }
        return array
    }
}
class TestCell:UICollectionViewCell {
    
}
class MyViewController : UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    lazy var collectionView:UICollectionView = {
        let collectionView = UICollectionView(frame: view.frame, collectionViewLayout: CustomLayout())
        collectionView.backgroundColor = #colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1)
        return collectionView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.frame = CGRect(x: 0, y: 0, width: 320, height: 480)
        
        collectionView.register(TestCell.self, forCellWithReuseIdentifier: "TestCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
    }
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        self.view = view
        
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TestCell", for: indexPath) as! TestCell
        cell.backgroundColor = UIColor.red
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 320, height: 120)
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
