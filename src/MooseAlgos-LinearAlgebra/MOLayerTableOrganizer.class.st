Class {
	#name : #MOLayerTableOrganizer,
	#superclass : #Object,
	#instVars : [
		'firstPriority',
		'secondPriority',
		'orderedNodes',
		'similarNodes'
	],
	#category : #'MooseAlgos-DependencyTable'
}

{ #category : #running }
MOLayerTableOrganizer >> computeSimilaritiesOf: layerNodes [

	| sim |
	
	"quick and dirty, not optimized"
	similarNodes := SmallDictionary new.
	layerNodes do: [:n1|
		similarNodes at: n1 put: OrderedCollection new.
		layerNodes do: [:n2|
			n1 ~= n2 ifTrue: [
				sim := n1 similarity: n2.
				sim > 0 ifTrue: [ (similarNodes at: n1) add:  {n2. sim} ]
			]
		]		
	].
]

{ #category : #running }
MOLayerTableOrganizer >> initializeNodeOrderWith: layerNodes [ 
	| node sourceNodes |
	
	orderedNodes := OrderedCollection new.
	sourceNodes := layerNodes reject: [:n| n nextNodes isEmpty].
	self initializePriorityQueuesWith: sourceNodes.
	self computeSimilaritiesOf: sourceNodes.
	
	[ self isEmpty ] whileFalse: 
		[ node := self popNode.
		orderedNodes add: node.
		"reorder to put similar stuff in front"
		self pullSimilarNodesOf: node ].
	^ orderedNodes
]

{ #category : #'running-private' }
MOLayerTableOrganizer >> initializePriorityQueuesWith: nodes [ 
	"sort nodes by layer"

	secondPriority := (nodes asSortedCollection: [ :n1 :n2 | n1 layer < n2 layer ]) asOrderedCollection.
	"firstPriotity contains tuples of {node. similarity}"
	firstPriority := SortedCollection sortBlock: [:a1 :a2 | a1 second > a2 second]

]

{ #category : #'running-private' }
MOLayerTableOrganizer >> isEmpty [

	^ firstPriority isEmpty and: [secondPriority isEmpty]
]

{ #category : #accessing }
MOLayerTableOrganizer >> orderedNodes [
	^ orderedNodes
]

{ #category : #'running-private' }
MOLayerTableOrganizer >> popNode [

	^ firstPriority isEmpty
		ifFalse: [firstPriority removeFirst first]
		ifTrue: [secondPriority removeFirst]
]

{ #category : #'running-private' }
MOLayerTableOrganizer >> pullSimilarNodesOf: aLayerNode [
	"pull similar nodes of aLayerNode in first priority queue"
	
	| tuple |
	(similarNodes at: aLayerNode) do: [ :x |
		(secondPriority includes: x first) ifTrue: [
			secondPriority remove: x first.
			firstPriority add: x "add tuple" ]
		ifFalse: [ "check if tuple in first priority, change order if similarity is better with new tuple"
			tuple := firstPriority detect: [:t| t first = x first] ifNone: [nil].
			tuple ifNotNil: [
				(x second > tuple second) ifTrue: [
					firstPriority remove: tuple.
					firstPriority add: x ]]
		]
	]
]
