Trait {
	#name : #MATEdgeNode,
	#category : #'Moose-Algos-Graph'
}

{ #category : #'as yet unclassified' }
MATEdgeNode >> from: aNode edge: anEdge [

	self previousEdges add: anEdge
]

{ #category : #'as yet unclassified' }
MATEdgeNode >> nextEdges [

	self explicitRequirement
]

{ #category : #'as yet unclassified' }
MATEdgeNode >> previousEdges [

	self explicitRequirement
]

{ #category : #'as yet unclassified' }
MATEdgeNode >> to: aNode edge: anEdge [

	self nextEdges add: anEdge
]
