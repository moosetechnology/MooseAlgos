"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MANameMappingTest,
	#superclass : #TestCase,
	#category : #'Moose-Tests-Algos-LinearAlgebra'
}

{ #category : #test }
MANameMappingTest >> testAddDuplicate [
	
	| m |
	m := MANameMapping withAll: #(#a #b #c #d).
	self
		should: [m add: #a]
		raise: Error
]

{ #category : #test }
MANameMappingTest >> testNames [
	
	| m |
	m := MANameMapping withAll: #(#a #b #c #d).
	self assert: (m equalsTo: #(1 2 3 4)).
	self assert: (m names equalsTo: #(#a #b #c #d))
]
