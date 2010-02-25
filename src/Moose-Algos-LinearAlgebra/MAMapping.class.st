"
Copyright (c), 2004-2007 Adrian Kuhn. This class is part of Hapax. Hapax is distributed under BSD License, see package comment.
"
Class {
	#name : #MAMapping,
	#superclass : #Collection,
	#category : #'Moose-Algos-LinearAlgebra'
}

{ #category : #adding }
MAMapping >> add: newObject [
	
	self subclassResponsibility
]

{ #category : #accessing }
MAMapping >> at: name [
	
	^self atKey: (self keyForName: name)
]

{ #category : #accessing }
MAMapping >> at: name ifAbsent: exceptionBlock [
	
	^self
		atKey: (self keyForName: name ifAbsent: exceptionBlock)
		ifAbsent: exceptionBlock
]

{ #category : #accessing }
MAMapping >> at: name ifPresent: unaryBlock [
	
	^unaryBlock
		value:
			(self
				at: name
				ifAbsent: [^self])
]

{ #category : #'accessing - key' }
MAMapping >> atKey: key [
	
	^self
		atKey: key
		ifAbsent: [KeyNotFoundError raise]
]

{ #category : #'accessing - key' }
MAMapping >> atKey: aKey ifAbsent: exceptionBlock [
	
	^self subclassResponsibility
]

{ #category : #application }
MAMapping >> convertCollection: aSequencableCollection [
	
	| collection |
	collection := aSequencableCollection species new.
	self do: [:index | collection add: (aSequencableCollection at: index)].
	^collection
]

{ #category : #application }
MAMapping >> convertMatrixColumnwise: aMatrix [
	
	^aMatrix species withMatrix: (MAMappedMatrix on: aMatrix columnMap: self)
]

{ #category : #application }
MAMapping >> convertMatrixRowwise: aMatrix [
	
	^aMatrix species withAll: (MAMappedMatrix on: aMatrix rowMap: self)
]

{ #category : #application }
MAMapping >> convertSquareMatrix: aMatrix [
	
	^aMatrix species withMatrix: (MAMappedMatrix on: aMatrix map: self)
]

{ #category : #converting }
MAMapping >> derive: aBlock [
	
	| derivate |
	derivate := MASmartMapping new.
	derivate setParent: self.
	self do: [:index | (aBlock value: index) ifTrue: [derivate add: index]].
	^derivate
]

{ #category : #converting }
MAMapping >> deriveWithNames: names [
	
	| derivate |
	derivate := MASmartMapping new.
	derivate setParent: self.
	names do: [:name | derivate add: (self keyForName: name)].
	^derivate
]

{ #category : #enumerating }
MAMapping >> do: aBlock [
	
	self subclassResponsibility
]

{ #category : #testing }
MAMapping >> includesIndex: index [
	
	self
		keyOf: index
		ifAbsent: [^false].
	^true
]

{ #category : #testing }
MAMapping >> includesKey: key [
	
	self
		atKey: key
		ifAbsent: [^false].
	^true
]

{ #category : #testing }
MAMapping >> includesName: name [
	
	self
		at: name
		ifAbsent: [^false].
	^true
]

{ #category : #'user interface' }
MAMapping >> inspectorClasses [
	
	^self size > 10000
		ifTrue: [Array with: BasicInspector]
		ifFalse: [Array with: DictionaryInspector with: BasicInspector]
]

{ #category : #'accessing - name' }
MAMapping >> keyForName: name [
	
	^self
		keyForName: name
		ifAbsent: [KeyNotFoundError raise]
]

{ #category : #'accessing - name' }
MAMapping >> keyForName: name ifAbsent: exceptionBlock [
	
	^self subclassResponsibility
]

{ #category : #'accessing - key' }
MAMapping >> keyOf: index [
	
	^self
		keyOf: index
		ifAbsent: [ValueNotFoundError raise]
]

{ #category : #'accessing - key' }
MAMapping >> keyOf: anIndex ifAbsent: exceptionBlock [
	
	^self subclassResponsibility
]

{ #category : #'accessing - key' }
MAMapping >> keys [
	
	^self subclassResponsibility
]

{ #category : #'accessing - name' }
MAMapping >> nameForKey: key [
	
	^self subclassResponsibility
]

{ #category : #'accessing - name' }
MAMapping >> nameOf: index [
	
	^self nameForKey: (self keyOf: index)
]

{ #category : #'accessing - name' }
MAMapping >> nameOf: index ifAbsent: exceptionBlock [
	
	^self nameForKey: (self keyOf: index ifAbsent: exceptionBlock)
]

{ #category : #'accessing - name' }
MAMapping >> names [
	
	^self keys collect: [:key | self nameForKey: key]
]

{ #category : #removing }
MAMapping >> remove: oldObject ifAbsent: anExceptionBlock [
	
	self shouldNotImplement
]

{ #category : #accessing }
MAMapping >> size [
	
	^self subclassResponsibility
]

{ #category : #converting }
MAMapping >> with: aCollection derive: aBlock [
	
	^self derive: [:index | aBlock value: (aCollection at: index)]
]
