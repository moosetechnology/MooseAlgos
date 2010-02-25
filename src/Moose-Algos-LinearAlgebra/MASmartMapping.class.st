"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MASmartMapping,
	#superclass : #MANumberMapping,
	#instVars : [
		'parent'
	],
	#category : #'Moose-Algos-LinearAlgebra'
}

{ #category : #'instance creation' }
MASmartMapping class >> on: parent [
	
	^(self new)
		setParent: parent;
		yourself
]

{ #category : #'initialize-release' }
MASmartMapping >> isRoot [
	
	^parent isNil
]

{ #category : #'accessing - name' }
MASmartMapping >> keyForName: name ifAbsent: exceptionBlock [
	
	^name isInteger
		ifTrue: [name]
		ifFalse:
			[self isRoot
				ifTrue: [exceptionBlock value]
				ifFalse:
					[self keyOf: (parent keyForName: name ifAbsent: exceptionBlock)]]
]

{ #category : #'accessing - name' }
MASmartMapping >> nameForKey: key [
	
	^self isRoot
		ifTrue: [KeyNotFoundError raise]
		ifFalse: [parent nameForKey: (self atKey: key)]
]

{ #category : #'initialize-release' }
MASmartMapping >> setParent: mapping [
	
	^parent := mapping
]
