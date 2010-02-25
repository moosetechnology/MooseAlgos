"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MABooleanVector,
	#superclass : #MAVector,
	#instVars : [
		'bits',
		'size'
	],
	#category : #'Moose-Algos-LinearAlgebra'
}

{ #category : #'logical operations' }
MABooleanVector >> & booleanVector [
	
	[self size = booleanVector size] assert.
	^(self class new: self size)
		setBits: (self getBits bitAnd: booleanVector getBits);
		yourself
]

{ #category : #accessing }
MABooleanVector >> at: index [
	
	^bits allMask: (1 bitShift: index - 1)
]

{ #category : #accessing }
MABooleanVector >> at: index put: boolean [
	
	^boolean
		ifTrue: [bits := bits maskSet: 1 << (index - 1)]
		ifFalse: [bits := bits maskClear: 1 << (index - 1)]
]

{ #category : #private }
MABooleanVector >> bits [
	
	^bits
]

{ #category : #private }
MABooleanVector >> getBits [
	
	^bits
]

{ #category : #'initialize-release' }
MABooleanVector >> initializeSize: aSize [
	
	bits := 0.
	size := aSize
]

{ #category : #'logical operations' }
MABooleanVector >> not [
	
	^(self class new: self size)
		setBits: self getBits bitInvert;
		yourself
]

{ #category : #private }
MABooleanVector >> setBits: integer [
	
	^bits := integer
]

{ #category : #accessing }
MABooleanVector >> size [
	
	^size
]

{ #category : #'logical operations' }
MABooleanVector >> | booleanVector [
	
	[self size = booleanVector size] assert.
	^(self class new: self size)
		setBits: (self getBits bitOr: booleanVector getBits);
		yourself
]
