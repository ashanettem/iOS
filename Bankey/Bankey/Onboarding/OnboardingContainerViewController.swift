//
//  OnboardingContainerViewController.swift
//  Bankey
//
//  Created by PandaH on 3/16/22.
//

import UIKit

class OnboardingContainerViewController: UIViewController {

    //declare page view controller object of type uipageview controller
    let pageViewController: UIPageViewController
    //array of pages (view controllers), load screens apart of onboarding process
    var pages = [UIViewController]()
    //current view controller displayed
    var currentVC: UIViewController
    //close button of type .system
    let closeButton = UIButton(type: .system)
    
    //
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
        //instantiate page view controller
        //set page view controller transition style scroll, navigation horizontal, and options nil
        self.pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
        //create page objects (view controllers)
        let page1 = ViewController1()
        let page2 = ViewController2()
        let page3 = ViewController3()
        
        //add pages to page array
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        
        //grab the current VC
        currentVC = pages.first!
        
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        style()
        layout()
    }
    
    private func setup() {
        
        //background set to purple
        view.backgroundColor = .systemPurple
        
        //3 CRUCIAL STEPS
        //add child view controllers to parent view controller
        //ui page view controller added to selves the container
        addChild(pageViewController)
        //add child's view as a sub view to our view
        view.addSubview(pageViewController.view)
        //call did move on the child to parent self
        pageViewController.didMove(toParent: self)
        
        
        //set self as data source to become source of data for amount of pages and what page to display
        pageViewController.dataSource = self
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false // set for auto layout
        
        NSLayoutConstraint.activate([ //auto layout, pin UI page view controller to edges of parent view
            view.topAnchor.constraint(equalTo: pageViewController.view.topAnchor),
            view.leadingAnchor.constraint(equalTo: pageViewController.view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: pageViewController.view.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: pageViewController.view.bottomAnchor),
        ])
        
        //set display for first page, grab first page, direction of animation forward, animated false
        //no completion
        pageViewController.setViewControllers([pages.first!], direction: .forward, animated: false, completion: nil)
        //store page as current VC
        currentVC = pages.first!
    }
    
    private func style() {
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.setTitle("Close", for: [])
        closeButton.addTarget(self, action: #selector(closeTapped), for: .primaryActionTriggered)

        view.addSubview(closeButton)
    }
    
    private func layout() {
        // Close
        NSLayoutConstraint.activate([
            closeButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            closeButton.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 2)
        ])
    }
}

// MARK: - UIPageViewControllerDataSource
//data source - page view controller needs to know what the view controller should be before or after a swipe
extension OnboardingContainerViewController: UIPageViewControllerDataSource {

    //return previous view controller, call getPreviousViewController function
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return getPreviousViewController(from: viewController)
    }

    //return next view controller, call getNextViewController function
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return getNextViewController(from: viewController)
    }

    
    private func getPreviousViewController(from viewController: UIViewController) -> UIViewController? {
        //grab first index of the view controller that we're on, making sure to check that we're not out of
        //range. Index of current view controller - 1 is always greater than or equal to 0 in order to get prev
        //if not return nil
        guard let index = pages.firstIndex(of: viewController), index - 1 >= 0 else { return nil }
        //if so currentVC becomes view controller located at previous index or index - 1
        currentVC = pages[index - 1]
        //return view controller at previous index
        return pages[index - 1]
    }

    
    private func getNextViewController(from viewController: UIViewController) -> UIViewController? {
        //grab first index of view controller that we're on, making sure to check that we're not out of
        //range. Index of current view controller + 1 is always less than the number of pages in array
        //if not return nil
        guard let index = pages.firstIndex(of: viewController), index + 1 < pages.count else { return nil }
        //if so currentVC becomes view controller located at next index or index + 1
        currentVC = pages[index + 1]
        //return view controller at next index
        return pages[index + 1]
    }

    //presentation Count - return count of pages array or number of view controllers
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }

    //presentation Index - return the first occurent of our currentVC
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return pages.firstIndex(of: self.currentVC) ?? 0
    }
}

// MARK: - Actions
extension OnboardingContainerViewController {
    @objc func closeTapped(_ sender: UIButton) {
        // TODO
    }
}

// MARK: - ViewControllers
class ViewController1:UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
    }
}

class ViewController2:UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
    }
}

class ViewController3:UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
    }
}
