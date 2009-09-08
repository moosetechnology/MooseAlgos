Class {
	#name : #MOKruskal,
	#superclass : #MOGraphAlgorithm,
	#instVars : [
		'sortedEdges',
		'treeEdges',
		'sortBlock'
	],
	#category : #'MooseAlgos-Graph'
}

{ #category : #sample }
MOKruskal class >> mondrianSample [
	"
	MOKruskal mondrianSample
	"
 
	| kruskal tree otherEdges edges view |
	kruskal := MOKruskal new.
	MOGraphFixture complexWeightedGraph: kruskal.
	tree := kruskal run.
	
	view := (Smalltalk at: #MOViewRenderer) new.
	view nodes: kruskal nodes.
	view edgeShape: ((Smalltalk at: #MOStraightLineShape) new width: 3).
	edges := view edges: tree from: #from to: #to.

	view edgeShape: ((Smalltalk at: #MOCurveFitterShape) new color: Color red; width: 2).
	otherEdges := kruskal edges copyWithoutAll: tree.
	otherEdges := view edges: otherEdges from: #from to: #to.

	view treeLayout userDefinedEdges: edges.
	view open.
]

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
