//
//  MapAnnotation.swift
//  SwiftFI
//
//  Created by Ross Nelson on 7/11/14.
//  Copyright (c) 2014 Food Inspections. All rights reserved.
//

import Foundation
import CoreLocation

class MapAnnotation: NSObject {
	var title: NSString?
	var subtitle: NSString?
	var coordinate: CLLocationCoordinate2D?
}