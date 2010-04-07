"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MAFloatVector,
	#superclass : #MAVector,
	#type : #variable,
	#category : #'Moose-Algos-LinearAlgebra'
}

{ #category : #'instance creation' }
MAFloatVector class >> new: size [
	
	^self basicNew: size "<< 2"
]

{ #category : #accessing }
MAFloatVector >> at: anIndex [
	
	"^self floatAt: (anIndex bitShift: 2) - 3"
	^ (self basicAt: anIndex) 
]

{ #category : #accessing }
MAFloatVector >> at: anIndex put: aNumber [
	
	"^self
		floatAt: (anIndex bitShift: 2) - 3
		put: aNumber asFloat"
		
	^ self basicAt: anIndex put: aNumber asFloat
]

{ #category : #private }
MAFloatVector >> floatAt: byteIndex [
	
	<primitive: 548>
	^self primitiveFailed

]

{ #category : #private }
MAFloatVector >> floatAt: byteIndex put: float [
	
	<primitive: 549>
	^self primitiveFailed
	

]

{ #category : #accessing }
MAFloatVector >> size [
	
	^self basicSize" >> 2"
]
