Class {
	#name : #MALatticeNode,
	#superclass : #ProtoObject,
	#category : #'Moose-Algos-FormalConceptAnalysis'
}

{ #category : #accessing }
MALatticeNode >> concept [
	
	^self pimonValue
]

{ #category : #displaying }
MALatticeNode >> displayFigureOn: gc [
	
	self basicDisplayFigureOn: gc
]

{ #category : #displaying }
MALatticeNode >> displayOn: gc [
	
	self basicDisplayFigureOn: gc
]

{ #category : #enumerating }
MALatticeNode >> hasDescendant: aNode [
	
	self descendantsDo: [:each | each = aNode ifTrue: [^true]].
	^false
]

{ #category : #accessing }
MALatticeNode >> layer [
	
	^self concept numAttributes
]

{ #category : #accessing }
MALatticeNode >> maybeAppendChild: aNode [
	
	[self layer < aNode layer] assert.
	(self hasDescendant: aNode)
		ifFalse:
			[(aNode concept intent allMask: self concept intent)
				ifTrue: [self add: aNode]]
]
