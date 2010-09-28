Class {
	#name : #MalKruskal,
	#superclass : #MalGraphAlgorithm,
	#instVars : [
		'sortedEdges',
		'treeEdges',
		'sortBlock'
	],
	#category : #'Moose-Algos-Graph'
}

{ #category : #configuration }
MalKruskal >> edgeClass [

	^ MalWeightedEdge 
]

{ #category : #initialization }
MalKruskal >> initialize [

	super initialize.
	self minSpanningTree 
]

{ #category : #configuration }
MalKruskal >> maxSpanningTree [

	sortBlock := [:e1 :e2 | e1 weight > e2 weight].

]

{ #category : #configuration }
MalKruskal >> minSpanningTree [

	sortBlock := [:e1 :e2 | e1 weight < e2 weight].

]

{ #category : #configuration }
MalKruskal >> nodeClass [

	^ MalDisjointSetNode 
]

{ #category : #running }
MalKruskal >> run [

	treeEdges := OrderedCollection new.
	self sortedEdges: edges.
	nodes do: [ :node|
		node makeSet	
	].
	sortedEdges do: [ :edge|
		(edge from find = edge to find) ifFalse: [
			edge from union: edge to.
			treeEdges add: edge. ]
	].
	^ treeEdges 
]

{ #category : #configuration }
MalKruskal >> sortBlock: aBlock [

	sortBlock := aBlock
]

{ #category : #running }
MalKruskal >> sortedEdges: aCollectionOfWeightedEdges [

	sortedEdges := SortedCollection sortBlock: sortBlock.
	sortedEdges addAll: aCollectionOfWeightedEdges 
]
