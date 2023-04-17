//
//  ProgrammaticallyDepartmentViewController.swift
//  DGarciaEcommerce
//
//  Created by MacBookMBA3 on 08/03/23.
//

import UIKit

class ProgrammaticallyDepartmentViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Departamento"
    
        let button : UIButton = UIButton()
        button.setImage(UIImage(systemName: "cart"), for: .normal)
        button.addTarget(self, action: #selector(BuyTapped), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
        
        
        let collectionView : UICollectionView = {
            let flowlayout = UICollectionViewFlowLayout()
            flowlayout.scrollDirection = .vertical
            flowlayout.minimumLineSpacing =  20.0
            let cv = UICollectionView(frame: .zero, collectionViewLayout: flowlayout)
            return cv
        }()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.systemMint
        collectionView.register(UINib(nibName: "GeneralCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GeneralCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.addSubview(collectionView)
        
        let safeG = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeG.topAnchor, constant: 10.0),
            collectionView.leftAnchor.constraint(equalTo: safeG.leftAnchor, constant: 20.0),
            collectionView.rightAnchor.constraint(equalTo: safeG.rightAnchor, constant: -20.0),
            collectionView.bottomAnchor.constraint(equalTo: safeG.bottomAnchor)
            
        ])
        
        
        
        // Do any additional setup after loading the view.
    }
    @objc func BuyTapped() {
        print("Buy tapped")
        self.performSegue(withIdentifier: "buyTapped", sender: self)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ProgrammaticallyDepartmentViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GeneralCell", for: indexPath) as! GeneralCollectionViewCell
        
//        cell.titleLabel.text = areas[indexPath.row].Nombre
//        cell.imageOutlet.image = UIImage(named: areas[indexPath.row].Nombre)
        // Configure the cell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: 160)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "departamentToProduct", sender: self)
    }
    
}
