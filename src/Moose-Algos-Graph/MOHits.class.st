Class {
	#name : #MOHits,
	#superclass : #MOGraphAlgorithm,
	#instVars : [
		'k'
	],
	#category : #'Moose-Algos-Graph'
}

{ #category : #running }
MOHits >> computeAuthoritiesFor: aNode [

	aNode auth: (aNode previousNodes inject: 0 into: [:s :n| s + n hub])
]

{ #category : #running }
MOHits >> computeHubsFor: aNode [

	aNode hub: (aNode nextNodes inject: 0 into: [:s :n| s + n auth])
]

{ #category : #displaying }
MOHits >> display [

	| view |
	view := MOViewRenderer new.
	self displayOn: view.
	view open
]

{ #category : #displaying }
MOHits >> displayOn: view [

	view shape: (MORectangleShape new text: [:n| n printString]).
	view nodes: nodes.
	view edgeShape: MOArrowedLineShape new.
	view edges: nodes from: #yourself toAll: #nextNodes.
	view circleLayout
]

{ #category : #'initialize-release' }
MOHits >> initialize [

	super initialize.
	k := 20
]

{ #category : #running }
MOHits >> initializeNodes [

	self nodes do: [:n|
		n auth: 1.0; hub: 1.0
	]
]

{ #category : #configuration }
MOHits >> k [
	^ k
]

{ #category : #configuration }
MOHits >> k: anObject [
	k := anObject
]

{ #category : #configuration }
MOHits >> nodeClass [

	^ MOHitsNode
]

{ #category : #running }
MOHits >> normalize: aCollectionOfNodes [

	| authNorm hubNorm |
	authNorm := aCollectionOfNodes inject: 0 into: [:s :n| s + n auth].
	hubNorm := aCollectionOfNodes inject: 0 into: [:s :n| s + n hub].
	authNorm = 0 ifTrue: [authNorm := 1].
	hubNorm = 0 ifTrue: [hubNorm := 1].
	aCollectionOfNodes do: [:n|
		n auth: (n auth / authNorm).
		n hub: (n hub / hubNorm)]
]

{ #category : #running }
MOHits >> run [

	|i|
	i := 1.
	self initializeNodes.
	[i = k] whileFalse: [
		self nodes do: [:n|
			self computeAuthoritiesFor: n].
		self nodes do: [:n|
			self computeHubsFor: n].
		self normalize: self nodes.
"		Transcript cr; show: i; show: ': '.
		self nodes do: [:n|
			Transcript show: n printString]."
	i := i + 1]
]
