"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MAUnboundedMatrix,
	#superclass : #MAMatrixDecorator,
	#instVars : [
		'backgroundValue'
	],
	#category : #'Moose-Algos-LinearAlgebra'
}

{ #category : #'instance creation' }
MAUnboundedMatrix class >> on: matrix with: defaultValue [
	
	^(self on: matrix)
		backgroundValue: defaultValue;
		yourself
]

{ #category : #'initialize-release' }
MAUnboundedMatrix >> at: row and: column [
	
	^[matrix at: row and: column]
		on: "SubscriptOutOfBoundsError" Error
		do: [:ex | backgroundValue]
]

{ #category : #'initialize-release' }
MAUnboundedMatrix >> at: row and: column put: aNumber [
	
	^[matrix at: row and: column put: aNumber]
		on: "SubscriptOutOfBoundsError" Error
		do: [:ex | backgroundValue]
]

{ #category : #accessing }
MAUnboundedMatrix >> backgroundValue [
	
	^backgroundValue
]

{ #category : #accessing }
MAUnboundedMatrix >> backgroundValue: anObject [
	
	backgroundValue := anObject
]
