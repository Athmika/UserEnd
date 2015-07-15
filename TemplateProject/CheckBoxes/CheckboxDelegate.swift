//
//  CheckboxDelegate.swift
//  TemplateProject
//
//  Created by Athmika Senthilkumar on 7/14/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import Foundation

protocol CheckboxDelegate {
    func didSelectCheckbox(state: Bool, identifier: Int, title: String);
}