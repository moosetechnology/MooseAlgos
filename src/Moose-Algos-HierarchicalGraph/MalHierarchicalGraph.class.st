Class {
	#name : #MalHierarchicalGraph,
	#superclass : #Object,
	#instVars : [
		'name',
		'nodesDict',
		'edges',
		'levels',
		'buildingBlock',
		'buildingStyle'
	],
	#category : #'Moose-Algos-HierarchicalGraph'
}

{ #category : #creation }
MalHierarchicalGraph class >> basicCreate: baseEntities [
	| hiGraph |
	hiGraph := self new.
	(baseEntities isKindOf: Collection)
		ifTrue: [ hiGraph nodes: baseEntities. ]
		ifFalse: [ hiGraph node: baseEntities ].
	^ hiGraph.
]

{ #category : #creation }
MalHierarchicalGraph class >> with: baseEntities [
	"Building a HiGraph from base entities (collection of root or leaf nodes)."
	
	 ^ self with: baseEntities name: nil.
	
]

{ #category : #creation }
MalHierarchicalGraph class >> with: baseEntities name: aName [
	"Building a HiGraph from base entities (collection of root or leaf nodes)."
	
	^ (self basicCreate: baseEntities) name: aName.
	
]

{ #category : #api }
MalHierarchicalGraph >> addEdges: aCollection from: source to: destination [
	"Imperative method to add edges. Can be called multiple times, before #propagateEdges is called (must be done manually)."
	self addEdges: aCollection source: source destination: destination.
]

{ #category : #building }
MalHierarchicalGraph >> addEdges: aCollection source: source destination: destination [
	| foundClasses |
	self addEdges: aCollection
		sourceBlock: [ :e |
			(source isKindOf: Array)
				ifTrue: [ 
					foundClasses := (source select: [ :asso | e isKindOf: asso key ]).
					foundClasses ifEmpty: [ nil ] ifNotEmpty: [ foundClasses last value value: e ].
				]
	     			"Symbol (method) or block based way"
				ifFalse: [ 
					source value: e.
				].
		] 
		destinationBlock: [  :e |
			(destination isKindOf: Array)
				ifTrue: [ 
					foundClasses := (destination select: [ :asso | e isKindOf: asso key ]).
					foundClasses ifEmpty: [ nil ] ifNotEmpty: [ foundClasses last value value: e ].
				]
	     			"Symbol (method) or block based way"
				ifFalse: [ 
					destination value: e.
				].
		].
]

{ #category : #building }
MalHierarchicalGraph >> addEdges: aCollection sourceBlock: srcBlock destinationBlock: dstBlock [
	"Add given relations to the higraph.
	If through given relationships new nodes are found, they are NOT added to the hiGhraph."
	
	aCollection do: [ :e | 
		| srcEntity dstEntity srcNode dstNode relationship |
			
		"Get source and destination entities."
		srcEntity := srcBlock value: e.
		dstEntity := dstBlock value: e.

		"Entites should not be nil"
	      self assert: (srcEntity notNil and: dstEntity notNil) description: 'Entites should never be nil. Check correctness of srcBlock and dstBlock.'.
			
		"Get nodes from entities"
		(nodesDict includesKey: srcEntity)
			ifTrue: [
				srcNode := nodesDict at: srcEntity.
			]
			."ifFalse: [
				srcNode := SnNode with: srcEntity.
				self setParentOfNode: srcNode.
				nodesDict at: srcEntity put: srcNode.
			]."
			
		(nodesDict includesKey: dstEntity)
			ifTrue: [
				dstNode := nodesDict at: dstEntity.
			]
			."ifFalse: [
				dstNode := SnNode with: dstEntity.
				self setParentOfNode: dstNode.
				nodesDict at: dstEntity put: dstNode.
			]."
		
		"Only create relationship if nodes were found."
		(srcNode isNil or: dstNode isNil) ifFalse: [
			
			"Create a relationship between the nodes and add it to the graph."
			relationship := MalHgEdge with: e source: srcNode destination: dstNode.
			
			"Adding relationship to hiGraph relationship set"
			self edges add: relationship.
			
			"Add relations to the node themselves"
			srcNode addOutgoing: relationship.
			dstNode addIncoming: relationship.
		].
	].
]

{ #category : #api }
MalHierarchicalGraph >> aggregation: howToGetParent [
	| foundClasses |
	(howToGetParent isKindOf: Array)
		"Class based"
		ifTrue: [ 
			self blockToGetParent: [ :e |
				foundClasses := (howToGetParent select: [ :asso | e isKindOf: asso key ]).
				foundClasses ifEmpty: [ nil ] ifNotEmpty: [ foundClasses last value value: e ].
			]
		]
	      "Symbol (method) or block based way"
		ifFalse: [ 
			self blockToGetParent: [ :e | howToGetParent value: e ].
		].
]

{ #category : #building }
MalHierarchicalGraph >> blockToGetChildren: aBlock [ 
	"Builds the hierarchical graph based on root entities and given block"
	| nodesToProcess |

	"Make sure base entities are set before calling this method."
	self assert: (nodesDict notEmpty) description: 'Base nodes have to be set before calling this method.'.
	
	"If this method is called, we know that we are in top down building mode, 
	this means all given base nodes are root nodes."
	levels at: 0 put: self nodes asSet.

	"Set given block as the higraphs buildingBlock for later use,"
	buildingBlock := aBlock.
	nodesToProcess := Stack new.
	nodesToProcess addAll: nodesDict values.

	[nodesToProcess notEmpty] whileTrue:  [
		| node childrenNodes |
		
		node := nodesToProcess pop.
		
		childrenNodes := self setChildrenOfNode: node.
		
		(childrenNodes notEmpty) ifTrue: [
			
			"Need to re-evaluate found children"
			childrenNodes do: [ :childNode | 
				nodesToProcess push: childNode.
			].
		]
	].

	"True means the graph was built top down."
	buildingStyle := true.

	"After we have set up the hierarchy, we have to set the levels of the node, 
	so we can use this information when propagating relationships"
	self setLevels.
]

{ #category : #building }
MalHierarchicalGraph >> blockToGetParent: aBlock [ 
	"Builds the hierarchical graph based on the leaf entities and given block"
	| nodesToProcess |
	
	"Make sure leafs are set before calling this method."
	self assert: (nodesDict notEmpty) description: 'Base nodes have to be set before calling this method.'.
	
	"Set given block as the higraphs buildingBlock for later use,"
	buildingBlock := aBlock.
	nodesToProcess := Stack new.
	nodesToProcess addAll: nodesDict values.

	[nodesToProcess notEmpty] whileTrue:  [
		| node parentNode |
		
		node := nodesToProcess pop.
		
		parentNode := self setParentOfNode: node.
		
		(parentNode notNil) ifTrue: [
			"Need to re-evaluate found parent"
			nodesToProcess push: parentNode.
		]
	].

	"False means the graph was built bottom up."
	buildingStyle := false.

	"After we have set up the hierarchy, we have to set the levels of the node, 
	so we can use this information when propagating relationships"
	self setLevels.
]

{ #category : #api }
MalHierarchicalGraph >> bottomUp: howToGetParent [
	"Build the hiGraph bottom up from given leaf nodes."
	self aggregation: howToGetParent.
]

{ #category : #caching }
MalHierarchicalGraph >> cache [
	MalHgRepository repo at: self name put: self.
]

{ #category : #api }
MalHierarchicalGraph >> containment: howToGetChildren [
	| foundClasses |
	(howToGetChildren isKindOf: Array)
		"Class based"
		ifTrue: [ 
			self blockToGetChildren: [ :e |
				foundClasses := (howToGetChildren select: [ :asso | e isKindOf: asso key ]).
				foundClasses ifEmpty: [ nil ] ifNotEmpty: [ foundClasses last value value: e ].
			]
		]
	      "Symbol (method) or block based way"
		ifFalse: [ 
			self blockToGetChildren: [ :e | howToGetChildren value: e ].
		].
]

{ #category : #testing }
MalHierarchicalGraph >> deepestLevel [
	^ levels keys asSortedCollection last

]

{ #category : #accessing }
MalHierarchicalGraph >> edges [ 
	"Returns a Set of all relationships in this hiGraph."
	^ edges.
]

{ #category : #api }
MalHierarchicalGraph >> edges: aCollection from: source to: destination [
	"Declerative method to add and propagate edges in one go."
	self addEdges: aCollection source: source destination: destination.
	self propagateEdges.
]

{ #category : #accessing }
MalHierarchicalGraph >> edgesNotPropagated [
	"Returns a Set of all relationships that were not propagated in this hiGraph."
	^ edges reject: [ :rel | rel class = MalHgPropagatedEdge ].
]

{ #category : #accessing }
MalHierarchicalGraph >> edgesPropagated [
	"Returns a Set of all relationships that were propagated in this hiGraph."
	^ edges select: [ :rel | rel class = MalHgPropagatedEdge ].
]

{ #category : #'initialize-release' }
MalHierarchicalGraph >> initialize [
	super initialize.
	self reset.

]

{ #category : #enumerating }
MalHierarchicalGraph >> leafNodes [
	"Returns a Set of all leaf nodes of this hiGraph."
	^ levels at: self deepestLevel.
]

{ #category : #enumerating }
MalHierarchicalGraph >> level: aLevel [
	^ self nodesOnLevel: aLevel.
]

{ #category : #accessing }
MalHierarchicalGraph >> levels [
	^ levels.
]

{ #category : #accessing }
MalHierarchicalGraph >> name [
	"Returns either custom name (if one has been set) or name of wrapped entity of thid HiGraph."
	(name isNil) ifTrue: [
		^ 'a HiGraph'.
	].
	^ name.
]

{ #category : #accessing }
MalHierarchicalGraph >> name: aName [
	"Sets name for this HiGraph"
	name := aName.
]

{ #category : #api }
MalHierarchicalGraph >> node: anEntity [
	"Convenience method to add a single base entity e.g. a single root node."
	self nodes: (OrderedCollection with: anEntity ).
]

{ #category : #accessing }
MalHierarchicalGraph >> nodeEntities [
	"Returns a Collection of all wrapped entites (in QsNodes) in this HiGraph."
	^ nodesDict keys
]

{ #category : #enumerating }
MalHierarchicalGraph >> nodeWrapping: anEntity [
	"Returns the QsNode wrapping the given entity or nil if such a node does not exists in the HiGraph."
	^ nodesDict at: anEntity ifAbsent: [ nil ].
]

{ #category : #accessing }
MalHierarchicalGraph >> nodes [
	"Returns an Array of all QsNodes in this hiGraph."
	^ nodesDict values
]

{ #category : #api }
MalHierarchicalGraph >> nodes: aCollection [
	"Adds base entites (can be root or leaf nodes) to the graph from which we will start building the complete graph.
	This has to be done before calling blockToGetChildren or blockToGetParent."
	
	"Adding given entites as QsNodes to the nodesDict."
	aCollection do: [ :anEntity | 
		nodesDict at: anEntity put: (MalHgNode in: self with: anEntity).
	]
]

{ #category : #accessing }
MalHierarchicalGraph >> nodesDict [
	"Returns a Dictionary with keys: entities and values: nodes"
	^ nodesDict
]

{ #category : #enumerating }
MalHierarchicalGraph >> nodesDownFromLevel: aLevel [
	"Returns only part of the hiGraph: a set of all nodes of given and of deeper levels (deeper meaning farer away from the root nodes)."
	| result currLevel |
	
	result := Set new.
	currLevel := aLevel.
	
	[ levels includesKey: currLevel ] whileTrue: [ 
		result addAll: (levels at: currLevel).
		currLevel := currLevel + 1.
	].
	
	 ^ result.
]

{ #category : #enumerating }
MalHierarchicalGraph >> nodesFor: aCollectionOfEntites [
	"Returns a Set of all QsNodes wrapping given entities, empty Set if no corresponding node was found."
	| result node |
	result := Set new.
	
	aCollectionOfEntites do: [ :anEntity |
		node := nodesDict at: anEntity ifAbsent: [ nil ].
		node notNil ifTrue: [
			result add: node.
		].
	].
	
	^ result.
]

{ #category : #enumerating }
MalHierarchicalGraph >> nodesOnLevel: aLevel [
	"Returns only part of the higraph: a set of all nodes of a certain level (a cross cut of the higraph)"
	^ levels at: aLevel ifAbsent: [ Set new ].
]

{ #category : #enumerating }
MalHierarchicalGraph >> nodesUpFromLevel: aLevel [
	"Returns only part of the hiGraph: a set of all nodes of given and of higher levels (higher means nearer to the root node."
	| result currLevel |
	result := Set new.
	currLevel := aLevel.
	[ aLevel >= 0 ] whileTrue: [ 
		result addAll: (levels at: currLevel).
		currLevel := currLevel - 1.
	].
	
	 ^ result.
]

{ #category : #enumerating }
MalHierarchicalGraph >> nodesWrapping: anEntityCollection [
	"Returns the QsNodes wrapping the given entities or an empty collection if no such nodes could be found in the HiGraph."
	"TODO: This is a performance nightmare, no better way to do this?"
	| result |
	result := OrderedCollection new.
	
	nodesDict do: [ :n | 
		anEntityCollection do: [ :e | (n entity = e) ifTrue: [ result add: n ]].
	].

	^ result.
]

{ #category : #printing }
MalHierarchicalGraph >> printOn: aStream [
	aStream
		nextPutAll: 'HiGraph: ';
		nextPutAll: self name printString;
		nextPutAll: ' (n: ';
		nextPutAll: self nodesDict size printString;
		nextPutAll: ', e: ';
		nextPutAll: self edges size printString;
		nextPutAll: ')'.
]

{ #category : #building }
MalHierarchicalGraph >> propagateEdges [
	"Propagates relationships up in the hiGraph from the leaf nodes."
	self propagateEdges: OrderedCollection new.
]

{ #category : #building }
MalHierarchicalGraph >> propagateEdges: classCollection [
	"Propagates relationships up in the hiGraph from the leaf nodes.
	If a Collection with classes is provied, only relationships between given classes are propagated."
	| nodesToProcess propagatedRelationship srcNode dstNode srcAncestry dstAncestry srcLevel dstLevel  srcParent dstParent srcAncestorNodeIsAllowedClass dstAncestorNodeIsAllowedClass |
	
	nodesToProcess := Stack new.
	nodesToProcess addAll: self nodes.

	[nodesToProcess notEmpty] whileTrue: [
		srcNode := nodesToProcess pop.

		"Only check non root nodes."
		(srcNode isRootNode) ifFalse: [
		
			"If there are outgoing relationships from this node..."
			(srcNode outgoing notEmpty) 
				ifTrue: [
					
					"Go through all original relations."
					srcNode outgoingNotPropagated do: [ :outgoingRelationship |

						"Get destination node of relationship"
						dstNode := outgoingRelationship destination.
						
						srcAncestry := LinkedList new.
						dstAncestry := LinkedList new.

						"Initialize ancestries with src and dest nodes."
						srcAncestry add: srcNode.
						dstAncestry add: dstNode.
	
						"Have to bring ancestries to the same level."
						[srcAncestry last level = dstAncestry last level] whileFalse: [
							srcAncestry last level > dstAncestry last level ifTrue: [
								srcAncestry add: (srcAncestry last parent).
							]
							ifFalse: [
								dstAncestry add: (dstAncestry last parent).
							].
						].
					
						"Fill up ancestry chains by searching for either common root or two separate parents that are root nodes."
						[(srcAncestry last parent == dstAncestry last parent) 
						or: 
						((srcAncestry last isRootNode) or: (dstAncestry last isRootNode))]
						whileFalse: [
							srcAncestry add: (srcAncestry last parent).
							dstAncestry add: (dstAncestry last parent).
						].

						"Now add outgoing relations from source node and its ancestry to destination node and its ancestry."
						srcAncestry do: [ :srcAncestorNode |
							
							"Relationships from all source ancestry nodes to all destination ancestry nodes."
							dstAncestry do: [ :dstAncestorNode |
								
								"Reset class restrictions. Assuming not allowed."
								srcAncestorNodeIsAllowedClass := false.
								dstAncestorNodeIsAllowedClass := false.
									
								"Add all connections in the ancestries as new relations. Except :
								 - the original relation
								 - If they are the same node
								 - if a given class restriction is not satisfied"
								((srcAncestorNode = srcNode and: (dstAncestorNode = dstNode)) 
								or: 
								(srcAncestorNode = dstAncestorNode)) 
								ifFalse: [

									classCollection isEmpty ifTrue: [
										srcAncestorNodeIsAllowedClass := true.
										dstAncestorNodeIsAllowedClass := true.
									] ifFalse: [
										"Are the classes of both nodes in the collection of allowed classes?"
										classCollection do: [ :class |
	
											srcAncestorNode entity class == class ifTrue: [srcAncestorNodeIsAllowedClass := true ].
											dstAncestorNode entity class == class ifTrue: [dstAncestorNodeIsAllowedClass := true ].
										].
									].
								
									"Only add the propoagated relationships if it satisfied the class restrictions."
									(srcAncestorNodeIsAllowedClass and: dstAncestorNodeIsAllowedClass) ifTrue: [
										
										"And finally, create and add a new propagated relationship."
										propagatedRelationship := MalHgPropagatedEdge 
											with: outgoingRelationship entity 
											source: srcAncestorNode 
											destination: dstAncestorNode.
										edges add: propagatedRelationship.
										srcAncestorNode addOutgoing: propagatedRelationship.
										dstAncestorNode addIncoming: propagatedRelationship.
									].
								].
							].
						].
					].
				].
			].
		].
]

{ #category : #resetting }
MalHierarchicalGraph >> reset [
	self resetConfiguration.
	self resetNodes.
]

{ #category : #resetting }
MalHierarchicalGraph >> resetConfiguration [
	buildingBlock := nil.
]

{ #category : #resetting }
MalHierarchicalGraph >> resetEdges [
	"Set of all relationships in the graph."
	edges := Set new. 
	
	"Remove edge reference form nodes."
	self nodes ifNotEmpty: [ 
		self nodes do: [ :n | n resetEdges ].
	].
]

{ #category : #resetting }
MalHierarchicalGraph >> resetNodes [
	"dict keys: entities, values: nodes"
	nodesDict := Dictionary new.
	
	"dict keys: level, values: all nodes on that level as a Set."
	levels := Dictionary new.
	
	"nil means the graph has not been built yet. True means: top down, false: bottom up."
	buildingStyle := nil. 
	
	"If nodes are reset, we have to reset edges as well, since there can't be edges without nodes."
	self resetEdges.
]

{ #category : #enumerating }
MalHierarchicalGraph >> rootNodes [
	"Returns a Set of all root nodes of this hiGraph."
	^ levels at: 0 ifAbsent: [ levels at: 0 put: Set new ].
]

{ #category : #enumerating }
MalHierarchicalGraph >> searchForEntitesNamed: aSearchString [ 
	^ self nodes detect: [ :node | aSearchString match: node entity name ].
]

{ #category : #building }
MalHierarchicalGraph >> setChildrenOfNode: aNode [
	"Gets children of given node via buildingBlock, and sets them.
	Returns a Set with found children, or empty set if no children were found."
	| children childrenEntities childNode |

	self assert: (buildingBlock notNil) description: 'blockToGetChildren must be set before calling this method.'.
	self assert: (self rootNodes notEmpty) description: 'There must be at least one root node set before calling this method.'.
		
	children := Set new.

	"Get children entities via blockToGetChildren"
	childrenEntities := buildingBlock value: aNode entity.

	"If the entity has no children it is a leaf and we return an empty Set."
	(childrenEntities isNil)
		ifTrue: [ ^ children. ]
		
		"Else we add found children to the graph."
		ifFalse: [
			
			"Go through all found children..."
			childrenEntities do: [ :childEntity | 
		
				"Check if we already have the child stored in the graph, if yes retrieve it, else store it."
				(nodesDict includesKey: childEntity) 
				ifTrue: [
					childNode := nodesDict at: childEntity.
				]
				ifFalse: [
					childNode := MalHgNode in: self with: childEntity.
					nodesDict at: childEntity put: childNode.
				].
			
				"Add given node as parent to child."
				childNode parent: aNode.
			
				"Add child to given node."
				aNode addChild: childNode.
			
				"Add node to found children."
				children add: childNode.
			].
	].
	
	^ children.
]

{ #category : #building }
MalHierarchicalGraph >> setLevels [
	"Goes through all nodes in the graph and sets their levels relative to the root (level 0)"
	self rootNodes do: [ :rootNode |
		rootNode level: 0.
		rootNode setLevels. "Sets levels on all his children"
	].
]

{ #category : #building }
MalHierarchicalGraph >> setParentOfNode: aNode [
	"Gets parent of given node via blockToGetParent, and sets it - or adds node to root nodes, if there is no parent.
	Returns parent if one was found, nil else"
	| parentNode parentEntity |

	self assert: (buildingBlock notNil) description: 'blockToGetParent must be set before calling this method.'.

	"Get parent entity through blockToGetParent"
	parentEntity := buildingBlock value: aNode entity.
		
	"If the entity has no parent, it is a rootNode"
	(parentEntity isNil) 
	ifTrue: [
		(levels at: 0 ifAbsent: [ levels at: 0 put: Set new ]) add: aNode.
		^ nil.
	]
	ifFalse: [
		"Check if we already have the parent stored in the graph, if yes retrieve it, else store it."
		(nodesDict includesKey: parentEntity) 
			ifTrue: [
				parentNode := nodesDict at: parentEntity.
			]
			ifFalse: [
				parentNode := MalHgNode in: self with: parentEntity.
				nodesDict at: parentEntity put: parentNode.
			].
			
		"Add current node as child to parent"
		parentNode addChild: aNode.
			
		"Add parent to current node as parent"
		aNode parent: parentNode.
		
		"Re Nothing more expected ->turn parent."
		^ parentNode.
	].
]

{ #category : #api }
MalHierarchicalGraph >> topDown: howToGetChildren [
	"Build the hiGraph top down from given root nodes."
	self containment: howToGetChildren.
]

{ #category : #testing }
MalHierarchicalGraph >> wasBuiltBottomUp [
	self assert: buildingStyle notNil description: 'Graph has not been built yet'.
	^ buildingStyle not.
]

{ #category : #testing }
MalHierarchicalGraph >> wasBuiltTopDown [
	self assert: buildingStyle notNil description: 'Graph has not been built yet'.
	^ buildingStyle.
]
