Class {
	#name : #MOGraphAlgorithm,
	#superclass : #Object,
	#instVars : [
		'nodes',
		'edges'
	],
	#category : #'MooseAlgos-Graph'
}

{ #category : #private }
MOGraphAlgorithm >> addEdge: eModel from: source to: target [ 

	| edge sourceNode targetNode unknownNode |
	unknownNode := false.
	sourceNode := self 	findNode: (source value: eModel)
							ifAbsent: [Transcript show: source printString, ' node unknown'; cr.
											unknownNode := true].
	targetNode := self 	findNode: (target value: eModel)
							ifAbsent: [Transcript show: target printString, ' node unknown'; cr.
											unknownNode := true].

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
MOGraphAlgorithm >> edgeClass [

	^ nil
]

{ #category : #accessing }
MOGraphAlgorithm >> edges [
	^ edges
]

{ #category : #private }
MOGraphAlgorithm >> edges: aCollection [
	edges := aCollection
]

{ #category : #configuration }
MOGraphAlgorithm >> edges: aCollection from: source to: target [

	| |
	aCollection do: [ :eModel |
		self addEdge: eModel from: source to: target
	]
]

{ #category : #configuration }
MOGraphAlgorithm >> edges: aCollection from: source to: target weight: weightFunction [

	| edge |
	aCollection do: [ :eModel |
		edge := self addEdge: eModel from: source to: target.
		edge ifNotNil: [edge weight: (weightFunction value: eModel)].
	]
]

{ #category : #configuration }
MOGraphAlgorithm >> edges: aCollection from: source toAll: targets [

	| |
	aCollection do: [ :eModel |
		(targets value: eModel) do: [:target| 
			self addEdge: {source value: eModel. target} from: #first to: #second
		]
	]
]

{ #category : #accessing }
MOGraphAlgorithm >> findEdge: aModel [

	^ self edges detect: [:edge | edge model = aModel]
]

{ #category : #accessing }
MOGraphAlgorithm >> findNode: aModel [

	^ self nodes detect: [:aNode | aNode model = aModel ]
]

{ #category : #accessing }
MOGraphAlgorithm >> findNode: aModel ifAbsent: aBlock [

	^ self nodes detect: [:node | node model = aModel] ifNone: aBlock
]

{ #category : #accessing }
MOGraphAlgorithm >> graph [

	^ {self nodes. self edges}
]

{ #category : #'initialize-release' }
MOGraphAlgorithm >> initialize [

	nodes := OrderedCollection new.
	edges := OrderedCollection new.
]

{ #category : #configuration }
MOGraphAlgorithm >> nodeClass [

	^ MOGraphNode
]

{ #category : #accessing }
MOGraphAlgorithm >> nodes [

	^ nodes
]

{ #category : #configuration }
MOGraphAlgorithm >> nodes: aCollection [

	aCollection do: [ :model |
		self nodes add: (self nodeClass with: model)
	]

]

{ #category : #running }
MOGraphAlgorithm >> run [

	self subclassResponsibility 
]
