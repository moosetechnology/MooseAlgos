"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MAArrayVector,
	#superclass : #MAVector,
	#type : #variable,
	#category : #'Moose-Algos-LinearAlgebra'
}

{ #category : #'instance creation' }
MAArrayVector class >> new: size [
	
	^self basicNew: size
]

{ #category : #accessing }
MAArrayVector >> at: index [
	
	^self basicAt: index
]

{ #category : #accessing }
MAArrayVector >> at: index put: aNumber [
	
	^self basicAt: index put: aNumber
]

{ #category : #accessing }
MAArrayVector >> size [
	
	^self basicSize
]
