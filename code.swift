//
//  PeriodicTableViewController.swift
//  Formatting Quiz
//
//  Created by Dimitri Bouniol on 10/21/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

protocol PeriodicTableViewControllerDelegate {
    func periodicTableViewController(_ periodicTable: PeriodicTableViewController, didSelectElement element: Element)
}

class PeriodicTableViewController: UIViewController {
    
    var elementsController: ElementsController?
    var selectedElement: Element?
    
    weak var delegate: PeriodicTableViewControllerDelegate?
    
    private var elementViews: [ElementView] = []
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var coloringModeControl: ColoringModeControl!
    @IBOutlet weak var layoutModeControl: LayoutModeControl!

    override func viewDidLoad() {
        super.viewDidLoad()

        for element in elementsController.elements {
            var elementView = ElementView(with: element)
            elementView.delegate = self
            
            scrollView.addSubview(elementView)
            elementViews.append(elementView)
        }
    }
    
    @IBAction func changeColoringMode(_ sender: Any) {
        let coloringMode = coloringModeControl.coloringMode
        
        for elementView in elementViews {
            elementView.coloringMode = coloringMode
        }
    }
    
    @IBAction func changeLayoutMode(_ sender: Any) {
        let layoutMode = layoutModeControl.layoutMode
        
        for elementView in elementViews {
            elementView.layoutMode = layoutMode
        }
    }
    
    // This next method was added by a new member of the team. Identify the 10 formatting, naming, and logic issues below:
    @IBAction func chooseRandomElement(_ sender: Any) {
        let ranElem = self.elementsController.elements.randomElement()
        
        var chosenElementView: ElementView!
        
        for e in elementViews {
            if (e.element == ranElem) {
                chosenElementView = e
                break
            }
        }
        
        chosenElementView.isHighlighted = true
        
        self.delegate?.periodicTableViewController(self, didSelectElement: ranElem)
    }
}

extension PeriodicTableViewController: ElementViewDelegate {
    func elementViewWasSelected(_ elementView: ElementView) {
        let selectedElement = elementView.element
        
        delegate?.periodicTableViewController(self, didSelectElement: selectedElement)
    }
}
