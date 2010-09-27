Class {
	#name : #MAKruskal,
	#superclass : #MAGraphAlgorithm,
	#instVars : [
		'sortedEdges',
		'treeEdges',
		'sortBlock'
	],
	#category : #'Moose-Algos-Graph'
}

{ #category : #configuration }
MAKruskal >> edgeClass [

	^ MAWeightedEdge 
]

{ #category : #initialization }
MAKruskal >> initialize [

	super initialize.
	self minSpanningTree 
]

{ #category : #configuration }
MAKruskal >> maxSpanningTree [

	sortBlock := [:e1 :e2 | e1 weight > e2 weight].

]

{ #category : #configuration }
MAKruskal >> minSpanningTree [

	sortBlock := [:e1 :e2 | e1 weight < e2 weight].

]

{ #category : #configuration }
MAKruskal >> nodeClass [

	^ MADisjointSetNode 
]

{ #category : #running }
MAKruskal >> run [

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
MAKruskal >> sortBlock: aBlock [

	sortBlock := aBlock
]

{ #category : #running }
MAKruskal >> sortedEdges: aCollectionOfWeightedEdges [

	sortedEdges := SortedCollection sortBlock: sortBlock.
	sortedEdges addAll: aCollectionOfWeightedEdges 
]
