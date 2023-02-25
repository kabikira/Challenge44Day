//
//  ViewController.swift
//  Challenge44Day
//
//  Created by koala panda on 2023/02/23.
//

import UIKit

class ViewController: UICollectionViewController {
    var pictures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path).sorted(by: >)
        
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }
        print(pictures)
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Picture", for: indexPath) as? PictureCell else {
            fatalError("Unable to dequeue PersonCell.")
        }
        // 画像配列の番号で指定された要素の名前の画像をUIImageとする
        let cellImage = UIImage(named: pictures[indexPath.row])
        // UIImageをUIImageViewのimageとして設定
        cell.imageView?.image = cellImage

        cell.name?.text = pictures[indexPath.row]

        cell.imageView.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
        cell.imageView.layer.borderWidth = 2
        cell.imageView.layer.cornerRadius = 3
        cell.layer.cornerRadius = 7

        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as?
            DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            vc.totalPictures = pictures.count
            vc.selectedPictureNumber = indexPath.row + 1
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func shareTapped() {
        let text = "このアプリ便利だよ"
        let vc = UIActivityViewController(activityItems: [text], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }


}

