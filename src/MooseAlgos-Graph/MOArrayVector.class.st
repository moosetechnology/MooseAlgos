"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MOArrayVector,
	#superclass : #MOVector,
	#type : #variable,
	#category : #'MooseAlgos-LinearAlgebra'
}

{ #category : #'instance creation' }
MOArrayVector class >> new: size [
	
	^self basicNew: size
]

{ #category : #accessing }
MOArrayVector >> at: index [
	
	^self basicAt: index
]

{ #category : #accessing }
MOArrayVector >> at: index put: aNumber [
	
	^self basicAt: index put: aNumber
]

{ #category : #accessing }
MOArrayVector >> size [
	
	^self basicSize
]
