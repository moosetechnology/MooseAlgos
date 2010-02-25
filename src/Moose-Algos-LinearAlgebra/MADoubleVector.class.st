"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MADoubleVector,
	#superclass : #MAVector,
	#type : #bytes,
	#category : #'Moose-Algos-LinearAlgebra'
}

{ #category : #'instance creation' }
MADoubleVector class >> new: size [
	
	^self basicNew: size << 3
]

{ #category : #accessing }
MADoubleVector >> at: anIndex [
	
	^self doubleAt: (anIndex << 3) - 7
]

{ #category : #accessing }
MADoubleVector >> at: anIndex put: aNumber [
	
	^self
		doubleAt: (anIndex << 3) - 7
		put: aNumber asFloat
]

{ #category : #private }
MADoubleVector >> doubleAt: byteIndex [
	
	<primitive: 550>
	^self primitiveFailed
]

{ #category : #private }
MADoubleVector >> doubleAt: byteIndex put: float [
	
	<primitive: 551>
	^self primitiveFailed
]

{ #category : #accessing }
MADoubleVector >> size [
	
	^self basicSize >> 3
]
