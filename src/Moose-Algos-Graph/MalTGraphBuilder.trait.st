Trait {
	#name : #MalTGraphBuilder,
	#category : #'Moose-Algos-Graph'
}

{ #category : #private }
MalTGraphBuilder >> addEdge: eModel from: source to: target [ 

	| edge sourceNode targetNode unknownNode |
	unknownNode := false.
	sourceNode := self 	findNode: (source value: eModel)
							ifAbsent: [ unknownNode := true ].
	targetNode := self 	findNode: (target value: eModel)
							ifAbsent: [ unknownNode := true ].

	unknownNode ifFalse: [
		self edgeClass ifNil: [
			sourceNode to: targetNode.
			targetNode from: sourceNode.
			^ nil
		] ifNotNil: [
			edge := self edgeClass with: eModel.
			sourceNode to: targetNode edge: edge.
			targetNode from: sourceNode edge: edge.
			edge from: sourceNode.
			edge to: targetNode.
			self edges add: edge.	
			^ edge
		]		
	].
	^ nil
]

{ #category : #configuration }
MalTGraphBuilder >> edgeClass [

	^ nil
]

{ #category : #accessing }
MalTGraphBuilder >> edges [
	
	self explicitRequirement
]

{ #category : #configuration }
MalTGraphBuilder >> edges: aCollection from: source to: target [

	aCollection do: [ :eModel |
		self addEdge: eModel from: source to: target
	]
]

{ #category : #configuration }
MalTGraphBuilder >> edges: aCollection from: source to: target weight: weightFunction [

	| edge |
	aCollection do: [ :eModel |
		edge := self addEdge: eModel from: source to: target.
		edge ifNotNil: [edge weight: (weightFunction value: eModel)].
	]
]

{ #category : #configuration }
MalTGraphBuilder >> edges: aCollection from: source toAll: targets [

	aCollection do: [ :eModel |
		(targets value: eModel) do: [:target| 
			self addEdge: {source value: eModel. target} from: #first to: #second
		]
	]
]

{ #category : #accessing }
MalTGraphBuilder >> findEdge: aModel [

	^ self edges detect: [:edge | edge model = aModel]
]

{ #category : #accessing }
MalTGraphBuilder >> findNode: aModel [

	^ self nodes detect: [:aNode | aNode model = aModel ]
]

{ #category : #accessing }
MalTGraphBuilder >> findNode: aModel ifAbsent: aBlock [

	^ self nodes detect: [:node | node model = aModel] ifNone: aBlock
]

{ #category : #accessing }
MalTGraphBuilder >> graph [

	^ {self nodes. self edges}
]

{ #category : #configuration }
MalTGraphBuilder >> nodeClass [

	^ MalGraphNode
]

{ #category : #accessing }
MalTGraphBuilder >> nodes [
	
	self explicitRequirement
]

{ #category : #configuration }
MalTGraphBuilder >> nodes: aCollection [

	aCollection do: [ :model |
		self nodes add: (self nodeClass with: model)
	]

]
