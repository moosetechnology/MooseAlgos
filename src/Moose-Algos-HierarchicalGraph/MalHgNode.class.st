Class {
	#name : #MalHgNode,
	#superclass : #MalGraphNode,
	#instVars : [
		'hiGraph',
		'parent',
		'children',
		'outgoing',
		'incoming',
		'level',
		'attributes'
	],
	#category : #'Moose-Algos-HierarchicalGraph'
}

{ #category : #creation }
MalHgNode class >> in: hiGraph with: aModel [
	| node |
	node := MalHgNode new.
	node hiGraph: hiGraph.
	node model: aModel.
	^ node.
]

{ #category : #creation }
MalHgNode class >> in: hiGraph with: anEntity level: level [
	| node |
	node := MalHgNode new.
	node entity: anEntity.
	node hiGraph: hiGraph.
	node level: level.
	^ node.
]

{ #category : #adding }
MalHgNode >> addChild: aNode [
	"Adds a child node."
	(children includes: aNode) ifFalse: [
		children add: aNode.
	]
]

{ #category : #adding }
MalHgNode >> addChildren: aCollection [
	aCollection do: [ :each | 
		self addChild: each.
	].
]

{ #category : #adding }
MalHgNode >> addIncoming: anEdge [
	incoming add: anEdge.

]

{ #category : #adding }
MalHgNode >> addOutgoing: anEdge [
	outgoing add: anEdge.

]

{ #category : #accessing }
MalHgNode >> attributeAt: aKey [
	^ attributes at: aKey ifAbsent: [ nil ].
]

{ #category : #accessing }
MalHgNode >> attributeAt: aKey ifAbsent: aBlock [
	^ attributes at: aKey ifAbsent: aBlock.
]

{ #category : #accessing }
MalHgNode >> attributeAt: aKey ifAbsentPut: aBlock [
	^ attributes at: aKey ifAbsentPut: aBlock.
]

{ #category : #accessing }
MalHgNode >> attributeAt: aKey put: anObject [
	attributes at: aKey put: anObject.
]

{ #category : #accessing }
MalHgNode >> attributes [
	^ attributes
]

{ #category : #accessing }
MalHgNode >> children [
	"Returns this nodes children."
	^ children.
]

{ #category : #printing }
MalHgNode >> description [
	^  model name , ' (' , model class name , ')'.
]

{ #category : #accessing }
MalHgNode >> edges [
	"Return all edges, incoming and outgoing, as a set."
	^ (Set newFrom: incoming) addAll: outgoing.

]

{ #category : #accessing }
MalHgNode >> edges: aLevel [
	"Return all edges, incoming and outgoing, on given level as a Set."
	^ (Set newFrom: (self incomingEdges: aLevel)) addAll: (self outgoingEdges: aLevel).

]

{ #category : #accessing }
MalHgNode >> hiGraph [
	^ hiGraph
]

{ #category : #accessing }
MalHgNode >> hiGraph: anObject [
	hiGraph := anObject
]

{ #category : #accessing }
MalHgNode >> incoming [
	"Returns all incoming edges."
	^ incoming.

]

{ #category : #enumerating }
MalHgNode >> incomingEdges: aLevel [
	"Returns a set of of all incoming edges that are on given level.
	Returns an empty set if there are no incoming edgesaLevel 
	Returns all incoming edges if given level is nil"
	| incomingEdges |
	 incomingEdges := Set new.
	self incoming do: [ :rel | 	
		aLevel isNil ifTrue: [
			incomingEdges add: rel.
		]
		ifFalse: [
			rel from level = level ifTrue: [
				incomingEdges add: rel.
			].
		].
		
	].
	^ incomingEdges.
]

{ #category : #enumerating }
MalHgNode >> incomingFrom: aNode [
	"Returns all edges that are incoming from given node, nil if no such edge was found."
	| resultSet |
	resultSet := nil.
	self incoming do: [:rel | 
		(rel from == aNode) ifTrue: [
			(resultSet isNil) ifTrue: [
				resultSet := Set new.
			].
			resultSet add: rel.
		].
	].
	^ resultSet.
]

{ #category : #enumerating }
MalHgNode >> incomingFromThese: aNodeCollection [
	"Returns all edges that are incoming from given node collection, empty set if no such edge was found."
	 | resultSet |
	resultSet := Set new.
	aNodeCollection do: [ :node |
		resultSet addAll: (self incomingFrom: node).
	].
	^ resultSet.
]

{ #category : #enumerating }
MalHgNode >> incomingNotPropagated [
	"Returns all incoming edges that were not propagated."
	^ incoming reject: [ :rel | rel class = MalHgPropagatedEdge ].

]

{ #category : #enumerating }
MalHgNode >> incomingPropagated [
	"Returns all incoming edges that were propagated."
	^ incoming select: [ :rel | rel class = MalHgPropagatedEdge ].

]

{ #category : #enumerating }
MalHgNode >> incomingSources [
	"Returns a set of all source nodes of all incoming edges to this node.
	Returns an empty set if there are no incoming edges"
	^ self incomingSources: nil.
]

{ #category : #enumerating }
MalHgNode >> incomingSources: aLevel [
	"Returns a set of all source nodes of all incoming edges that are on given level.
	Returns an empty set if there are no incoming edges
	Returns all incoming sources if given level is nil"
	| incomingSources |
	 incomingSources := Set new.
	self incoming do: [ :rel | 	
		aLevel isNil ifTrue: [
			incomingSources add: rel from.
		]
		ifFalse: [
			rel from level = level ifTrue: [
				incomingSources add: rel from.
			].
		].
		
	].
	^ incomingSources.
]

{ #category : #initialization }
MalHgNode >> initialize [
	self resetHierarchy.
	self resetEdges.
	self resetAttributes.
]

{ #category : #testing }
MalHgNode >> isLeafNode [
	^ children isEmpty.

]

{ #category : #testing }
MalHgNode >> isRootNode [
	^ parent isNil.

]

{ #category : #accessing }
MalHgNode >> level [
	^ level.
]

{ #category : #accessing }
MalHgNode >> level: aLevel [
	level := aLevel.
]

{ #category : #testing }
MalHgNode >> notLeafNode [
	^ children notEmpty.

]

{ #category : #testing }
MalHgNode >> notRootNode [
	^ parent notNil.

]

{ #category : #accessing }
MalHgNode >> outgoing [
	"Returns all outgoing relationships."
	^ outgoing.

]

{ #category : #enumerating }
MalHgNode >> outgoingDestinations [
	"Returns a set of all destination nodes of all outgoing edge target nodes.
	Returns an empty set if there are no such nodes"
	^ self outgoingDestinations: nil.
]

{ #category : #enumerating }
MalHgNode >> outgoingDestinations: aLevel [
	"Returns a set of all destination nodes of all outgoing relationship that are on given level.
	Returns an empty set if there are no such nodes
	Returns all outgoing destinations if given level is nil"
	| outgoingDestinations |
	 outgoingDestinations := Set new.
	self outgoing do: [ :rel | 
		aLevel isNil ifTrue: [
			outgoingDestinations add: rel destination.
		]
		ifFalse: [
			rel destination level = level ifTrue: [
				outgoingDestinations add: rel destination.
			].
		].
	].
	^ outgoingDestinations.
]

{ #category : #enumerating }
MalHgNode >> outgoingEdges: aLevel [
	"Returns a set of all of all outgoing relationship that are on given level.
	Returns an empty set if there are no such relationships
	Returns all outgoing relationships if given level is nil"
	| outgoingRelationships |
	 outgoingRelationships := Set new.
	self outgoing do: [ :rel | 
		aLevel isNil ifTrue: [
			outgoingRelationships add: rel.
		]
		ifFalse: [
			rel to level = level ifTrue: [
				outgoingRelationships add: rel.
			].
		].
	].
	^ outgoingRelationships.
]

{ #category : #enumerating }
MalHgNode >> outgoingNotPropagated [
	"Returns all outgoing relationships that were not propagated."
	^ outgoing reject: [ :rel | rel class = MalHgPropagatedEdge ].

]

{ #category : #enumerating }
MalHgNode >> outgoingPropagated [
	"Returns all outgoing relationships that were propagated."
	^ outgoing select: [ :rel | rel class = MalHgPropagatedEdge ].

]

{ #category : #enumerating }
MalHgNode >> outgoingTo: aNode [
	"Returns all relationships that are outgoing to given node, empty set if no such relationship was found."
	| resultSet |
	resultSet := Set new.
	self outgoing do: [:rel | 
		(rel to == aNode) ifTrue: [
			resultSet add: rel.
		].
	].
	^ resultSet.
]

{ #category : #enumerating }
MalHgNode >> outgoingToThese: aNodeCollection [
	"Returns all relationships that are outgoing to given one or more of given node collection, empty set if no such relationship was found."
	 | resultSet |
	resultSet := Set new.
	aNodeCollection do: [ :node |
		resultSet addAll: (self outgoingTo: node).
	].
	^ resultSet.
	
]

{ #category : #accessing }
MalHgNode >> parent [
	^ parent.

]

{ #category : #accessing }
MalHgNode >> parent: aNode [
	"Sets parent of this node"
	parent := aNode.

]

{ #category : #accessing }
MalHgNode >> parentOnLevel: aLevel [
	"Returns the node that is on given level in this nodes ancestry.
	Returns nil if this node is on the same or on a deeper level than given one 
	or if given level does not exist in the graph (i.e. greater level than leaf nodes)."
	| levelDifference currentNode |
	
	self assert: aLevel >= 0 description: 'Smalles possible level is 0 (root nodes), negative levels do not exists. Given level was: ', aLevel asString.
	
	self level <= aLevel ifTrue: [ ^ nil ].
	
	levelDifference := self level - aLevel.
	currentNode := self.

	[levelDifference ~= 0] whileTrue: [
		currentNode := currentNode parent.	
		levelDifference := levelDifference - 1.
	].

	^ currentNode.
	

]

{ #category : #enumerating }
MalHgNode >> recursiveChildren [
	"Returns the whole family tree below myself (excluding myself). "
	^ self recursiveChildren: false.
	
]

{ #category : #enumerating }
MalHgNode >> recursiveChildren: withMyself [
	"Returns the whole family tree below myself. 
	If withMyself is true, also add myself to the returning set."
	| result |
	result := Set new.
	
	withMyself ifTrue: [
		result add: self.
	].
	
	self isLeafNode ifTrue: [
		^ result.	
	].

	result addAll: children.
	
	children do: [ :each | 
		result addAll: (each recursiveChildren: true). 
	].

	^ result.
]

{ #category : #resetting }
MalHgNode >> resetAttributes [
	attributes := Dictionary new.
]

{ #category : #resetting }
MalHgNode >> resetEdges [
	outgoing := Set new. "Outgoing Edges"
	incoming := Set new. "Incoming Edges"
]

{ #category : #resetting }
MalHgNode >> resetHierarchy [
	children := Set new. "My direct children"
]

{ #category : #ordering }
MalHgNode >> setLevels [
	"Set levels of all my children if I have any. I have to have a level set for this to work."
	| currLevelSet |
	self assert: (level notNil) description: 'This node must have a level set to set its childrens level'.
	
	currLevelSet := hiGraph levels at: level ifAbsent: [ hiGraph levels at: level put: Set new ].
	currLevelSet add: self.
	
	self notLeafNode ifTrue: [
		children do: [ :childNode |
			childNode level: level + 1.
			childNode setLevels.
		].
	].
]

{ #category : #printing }
MalHgNode >> shortName [
 	^ model name.
]
