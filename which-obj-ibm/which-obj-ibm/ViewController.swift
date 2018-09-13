//
//  ViewController.swift
//  which-obj-ibm
//
//  Created by Lucas Cotta on 9/4/18.
//  Copyright © 2018 Lucas Cotta. All rights reserved.
//

import UIKit
import VisualRecognitionV3
import SVProgressHUD

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //MARK: Variables
    let apiKey = "6WzYZ--VNmf485MdzuRhNTHhf1xzm6DneRgA1agopyRg"
    let version = "2018-09-05"
    var classificationResults: [String: Double] = [:]
    let imagePicker = UIImagePickerController()
    
    //MARK: IBOutlets
    @IBOutlet weak var UIImageViewFromMain: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: Photo Methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //UI Updates
        SVProgressHUD.show()
        cameraButton.isEnabled = false
        
        //Clean list of previous classifications
        classificationResults = [:]
        
        if let imageFromCamera = info[UIImagePickerControllerOriginalImage] as? UIImage {
            UIImageViewFromMain.image = imageFromCamera
            imagePicker.dismiss(animated: true, completion: nil)
            
            //MARK: ML
            //Instantiate model
            let visualRecognition = VisualRecognition(version: version, apiKey: apiKey)

            visualRecognition.classify(image: imageFromCamera) { (classifiedImage) in
                let classes = classifiedImage.images.first!.classifiers.first!.classes
                
                for index in 0..<classes.count {
                    self.classificationResults[String(classes[index].className)] = classes[index].score
                }
                
                let finalScores = self.classificationResults.values.sorted(by: >).prefix(3)
                let finalValues = self.classificationResults.keys.sorted(by: >).prefix(3)
                
                let finalMessage = "\(finalValues[0]): \(finalScores[0])\n\(finalValues[1]): \(finalScores[1])\n\(finalValues[2]): \(finalScores[2])"
                
                
                //UI Updates
                DispatchQueue.main.async {
                    self.cameraButton.isEnabled = true
                    SVProgressHUD.dismiss()
                }
                
                let alert = UIAlertController(title: "Results", message: finalMessage, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Cool!", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            
        } else {
            print("Error picking the image")
        }
    }

    
    @IBAction func cameraButtonPressed(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
        
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false
    }
}

