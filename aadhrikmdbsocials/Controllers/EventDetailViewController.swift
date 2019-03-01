//
//  EventDetailViewController.swift
//  aadhrikmdbsocials
//
//  Created by Aadhrik Kuila on 2/24/19.
//  Copyright © 2019 Aadhrik Kuila. All rights reserved.
//

import UIKit
import Firebase
import Material
import FirebaseDatabase

class EventDetailViewController: UIViewController {
    
    var event: Event!
    var eventTitle: UILabel!
    var dateLabel: UILabel!
    var heroImage: UIImageView!
    var interestedLabel: UILabel!
    var descriptionLabel: UILabel!
    var hostLabel: UILabel!
    var interestButton: Button!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Event Details"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .automatic
        
        heroImage = UIImageView(frame: CGRect(x: 0, y: (self.navigationController?.navigationBar.frame.height)!, width: view.frame.width, height: 350))
        heroImage.contentMode = .scaleAspectFill
        heroImage.image = UIImage(named: "event1")
        view.addSubview(heroImage)
        
        let layer = CAShapeLayer()
        layer.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 375, width: view.frame.width, height: view.frame.height), cornerRadius: 50).cgPath
        layer.fillColor = UIColor.white.cgColor
        view.layer.addSublayer(layer)
        
        eventTitle = UILabel(frame: CGRect(x: 35, y: 390, width: 300, height: 40))
        eventTitle.adjustsFontSizeToFitWidth = true
        eventTitle.minimumScaleFactor = 0.4
        eventTitle.textColor = .blue
        eventTitle.text = event.name
        view.addSubview(eventTitle)
        
        dateLabel = UILabel(frame: CGRect(x: 35, y: eventTitle.frame.maxY + 10, width: 150, height: 40))
        dateLabel.textColor = .blue
        dateLabel.text = event.date
        view.addSubview(dateLabel)
        
        interestedLabel = UILabel(frame: CGRect(x: view.frame.width-235, y: eventTitle.frame.maxY + 10, width: 200, height: 40))
        interestedLabel.textColor = .blue
        interestedLabel.textAlignment = .right
        interestedLabel.text = "\(event.numInterested) Interested"
        view.addSubview(interestedLabel)
        
        descriptionLabel = UILabel(frame: CGRect(x: 35, y: dateLabel.frame.maxY + 30, width: view.frame.width-70, height: 300))
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = .blue
        descriptionLabel.text = event.description
        descriptionLabel.sizeToFit()
        view.addSubview(descriptionLabel)
        
        hostLabel = UILabel(frame: CGRect(x: view.frame.width/2 - 150, y: view.frame.height-170, width: 325, height: 70))
        hostLabel.textColor = .blue
        hostLabel.adjustsFontSizeToFitWidth = true
        hostLabel.minimumScaleFactor = 0.4
        hostLabel.text = "Hosted by \(event.owner)"
        hostLabel.textAlignment = .center
        view.addSubview(hostLabel)
        
        interestButton = Button(frame: CGRect(x: view.frame.width/2-112.5, y: view.frame.height - 110, width: 225, height: 60))
        interestButton.setTitle("Interested?", for: .normal)
        interestButton.setTitleColor(UIColor.blue, for: .normal)
        interestButton.pulseColor = .blue
        interestButton.layer.cornerRadius = interestButton.frame.height/2
        interestButton.layer.borderColor = UIColor.blue.cgColor
        interestButton.layer.borderWidth = 2
        interestButton.addTarget(self, action: #selector(whoIsInterested), for: .touchUpInside)
        view.addSubview(interestButton)

        // Do any additional setup after loading the view.
    }
    
    @objc func whoIsInterested() {
        interestButton.setTitle("Interested!", for: .normal)
        interestButton.setTitleColor(UIColor.white, for: .normal)
        interestButton.pulseColor = .white
        interestButton.backgroundColor = .blue
        
        Database.database().reference().child("event").child(self.event.name).child("interested").setValue(event.numInterested + 1, withCompletionBlock: { (error, ref) in
            if let error = error {
                print(error.localizedDescription)
                print("it errored")
            }
        })
        interestButton.isEnabled = false
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
