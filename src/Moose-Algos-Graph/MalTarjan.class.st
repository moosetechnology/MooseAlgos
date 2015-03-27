"
I implement the well known Tarjan's algorithm. My purpose is to find the strongly connected components (aka circuits /cycles) of a graph in O(m+n).
See https://en.wikipedia.org/wiki/Tarjan%27s_strongly_connected_components_algorithm for more details.
"
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

{ #category : #accessing }
MalTarjan >> circuits [
	^ self stronglyConnectedComponents
		select: [ :each | each size > 1 ]
]

{ #category : #configuration }
MalTarjan >> nodeClass [
	^ MalTarjanNode 
]

{ #category : #setting }
MalTarjan >> nodesAndNextFrom: aNodeList [
	aNodeList 
		do: [ :node | self nodes add: (self nodeClass with: node model) ].
	aNodeList 
		do: [ :node |
			node nextNodes 
				do: [ :each |
						(self findNode: node model) 
							to: (self findNode: each model) ] ]
]

{ #category : #running }
MalTarjan >> putOnStack: aTarjanNode [
	stack push: aTarjanNode.
	aTarjanNode inStack: true. "I use a flag to avoid stack access"
]

{ #category : #running }
MalTarjan >> run [
	sccs := OrderedCollection new.
	stack := Stack new.
	runningIndex := 0.
	self nodes
		do: [ :n | 
			n isTarjanUndefined
				ifTrue: [ self traverse: n ] ].
	^ sccs
]

{ #category : #accessing }
MalTarjan >> stronglyConnectedComponents [
	^ sccs ifNil: [ self run ]
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
