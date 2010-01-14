Class {
	#name : #MOKruskal,
	#superclass : #MOGraphAlgorithm,
	#instVars : [
		'sortedEdges',
		'treeEdges',
		'sortBlock'
	],
	#category : #'Moose-Algos-Graph'
}

{ #category : #configuration }
MOKruskal >> edgeClass [

	^ MOWeightedEdge 
]

{ #category : #initialization }
MOKruskal >> initialize [

	super initialize.
	self minSpanningTree 
]

{ #category : #configuration }
MOKruskal >> maxSpanningTree [

	sortBlock := [:e1 :e2 | e1 weight > e2 weight].

]

{ #category : #configuration }
MOKruskal >> minSpanningTree [

	sortBlock := [:e1 :e2 | e1 weight < e2 weight].

]

{ #category : #configuration }
MOKruskal >> nodeClass [

	^ MODisjointSetNode 
]

{ #category : #running }
MOKruskal >> run [

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
MOKruskal >> sortBlock: aBlock [

	sortBlock := aBlock
]

{ #category : #running }
MOKruskal >> sortedEdges: aCollectionOfWeightedEdges [

	sortedEdges := SortedCollection sortBlock: sortBlock.
	sortedEdges addAll: aCollectionOfWeightedEdges 
]
