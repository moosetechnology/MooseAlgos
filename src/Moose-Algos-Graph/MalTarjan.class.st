Class {
	#name : #MalTarjan,
	#superclass : #MalGraphAlgorithm,
	#instVars : [
		'stack',
		'runningIndex',
		'sccs'
	],
	#category : #'Moose-Algos-Graph'
}

{ #category : #configuration }
MalTarjan >> findNode: aModel ifAbsent: aBlock [
	^ nodes at: aModel ifAbsent: aBlock
]

{ #category : #configuration }
MalTarjan >> initialize [
	super initialize.
	nodes := Dictionary new.
]

{ #category : #configuration }
MalTarjan >> nodeClass [

	^ MalTarjanNode 
]

{ #category : #configuration }
MalTarjan >> nodes [
	^ nodes values
]

{ #category : #configuration }
MalTarjan >> nodes: aCollection [
	aCollection do: [ :model |
		nodes at: model put: (self nodeClass with: model)
	]
]

{ #category : #running }
MalTarjan >> putOnStack: aTarjanNode [

	stack push: aTarjanNode.
	aTarjanNode inStack: true. "I use a flag to avoid stack access"
]

{ #category : #running }
MalTarjan >> run [
	"Tarjan's algorithm to detect strongly connected components (aka cycles) in O(m+n)"
	sccs := OrderedCollection new.
	stack := Stack new.
	runningIndex := 0.
	self nodes do: [ :n | n isTarjanUndefined ifTrue: [ self traverse: n ] ]
]

{ #category : #accessing }
MalTarjan >> stronglyConnectedComponents [

	^ sccs 
]

{ #category : #running }
MalTarjan >> traverse: aTarjanNode [ 
	| pNode component |
	aTarjanNode tarjanIndex: runningIndex.
	aTarjanNode tarjanLowlink: runningIndex.
	runningIndex := runningIndex + 1.
	self putOnStack: aTarjanNode.
	aTarjanNode nextNodes do: [:next | 
		next isTarjanUndefined 
			ifTrue: 
				[ self traverse: next.
				aTarjanNode tarjanLowlink: (aTarjanNode tarjanLowlink min: next tarjanLowlink) ]
			ifFalse: 
				[ next inStack ifTrue: 
					[ aTarjanNode tarjanLowlink: (aTarjanNode tarjanLowlink min: next tarjanIndex) ]]].

	aTarjanNode tarjanIndex = aTarjanNode tarjanLowlink ifTrue: 
		[ component := OrderedCollection new.
		 [pNode := stack pop.
		  pNode popped.
		  component add: pNode ] doWhileFalse: [ pNode = aTarjanNode ].
		 sccs add: component.
		 component do: [:each| 
			each cycleNodes: component ]]
]
