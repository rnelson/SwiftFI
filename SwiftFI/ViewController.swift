//
//  ViewController.swift
//  SwiftFI
//
//  Created by Ross Nelson on 7/11/14.
//  Copyright (c) 2014 Food Inspections. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {

	let METERS_PER_MILE = 1609.344
	@IBOutlet var mapView: MKMapView

	override func viewDidLoad() {
		super.viewDidLoad()
		
		var lnk: CLLocationCoordinate2D
		var viewDistance: CLLocationDistance
		var viewRegion: MKCoordinateRegion
		
		// Zoom to LNK by default...
		lnk = CLLocationCoordinate2DMake(40.85, -96.61)
		viewDistance = 5 * METERS_PER_MILE
		viewRegion = MKCoordinateRegionMakeWithDistance(lnk, viewDistance, viewDistance)
		mapView.setRegion(viewRegion, animated: true)
		
		// ...but go ahead and go to where the user is if they want
		mapView.showsUserLocation = true
		
		// Display the map view and populate it
		self.view.addSubview(mapView)
		self.addCitiesToMap()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	func addCitiesToMap() {
		dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
			var annotations: NSArray = self.loadFirms()
			self.mapView.addAnnotations(annotations)
		})
	}
	
	func loadFirms() -> NSArray {
		var annotations = NSMutableArray()
		var firms: NSArray = FIFirm.loadWithinMapView(self.mapView)
		
		for o in firms {
			var firm: FIFirm = o as FIFirm
			
			var annotation: MapAnnotation
			var violations: NSString
			var coordinate: CLLocationCoordinate2D
			
			violations = "Critical: " + String(firm.totalCritical) + ", Noncritical: " + String(firm.totalNoncritical)
			coordinate = CLLocationCoordinate2D(latitude: firm.coordinate.latitude, longitude: firm.coordinate.longitude)
			
			annotation = MapAnnotation(title: firm.name, subtitle: violations, coordinate: coordinate)
			annotations.addObject(annotation)
		}
		
		return annotations
	}
}

