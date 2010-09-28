Class {
	#name : #MalLatticeNode,
	#superclass : #ProtoObject,
	#category : #'Moose-Algos-FormalConceptAnalysis'
}

{ #category : #accessing }
MalLatticeNode >> concept [
	
	^self pimonValue
]

{ #category : #displaying }
MalLatticeNode >> displayFigureOn: gc [
	
	self basicDisplayFigureOn: gc
]

{ #category : #displaying }
MalLatticeNode >> displayOn: gc [
	
	self basicDisplayFigureOn: gc
]

{ #category : #enumerating }
MalLatticeNode >> hasDescendant: aNode [
	
	self descendantsDo: [:each | each = aNode ifTrue: [^true]].
	^false
]

{ #category : #accessing }
MalLatticeNode >> layer [
	
	^self concept numAttributes
]

{ #category : #accessing }
MalLatticeNode >> maybeAppendChild: aNode [
	
	[self layer < aNode layer] assert.
	(self hasDescendant: aNode)
		ifFalse:
			[(aNode concept intent allMask: self concept intent)
				ifTrue: [self add: aNode]]
]
