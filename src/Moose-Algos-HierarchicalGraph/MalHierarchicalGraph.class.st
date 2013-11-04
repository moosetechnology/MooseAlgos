Class {
	#name : #MalHierarchicalGraph,
	#superclass : #MalGraphAlgorithm,
	#instVars : [
		'name',
		'levels',
		'buildingBlock'
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
MalHierarchicalGraph class >> with: baseModels [
	"Building a HiGraph from base models (collection of root or leaf nodes)."
	
	 ^ self with: baseModels name: nil.
	
]

{ #category : #creation }
MalHierarchicalGraph class >> with: baseModels name: aName [
	"Building a hierarchical graph from base models (collection of root or leaf nodes)."
	
	^ (self basicCreate: baseModels) name: aName.
	
]

{ #category : #api }
MalHierarchicalGraph >> addEdge: aModel from: source to: target [
	self addEdges: (OrderedCollection with: aModel) from: source to: target.
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
	"Add given edges to the higraph.
	If through given edges new nodes are found, they are NOT added to the graph."
	| srcEntity dstEntity srcNode dstNode edge |
	aCollection do: [ :e | 
		
		"Get source and destination models."
		srcEntity := srcBlock value: e.
		dstEntity := dstBlock value: e.

		"Entites should not be nil"
	      self assert: (srcEntity notNil and: dstEntity notNil) description: 'Entites should never be nil. Check correctness of srcBlock and dstBlock.'.
			
		"Get nodes from entities"
		(nodes includesKey: srcEntity)
			ifTrue: [
				srcNode := nodes at: srcEntity.
			]
			."ifFalse: [
				srcNode := SnNode with: srcEntity.
				self setParentOfNode: srcNode.
				nodesDict at: srcEntity put: srcNode.
			]."
			
		(nodes includesKey: dstEntity)
			ifTrue: [
				dstNode := nodes at: dstEntity.
			]
			."ifFalse: [
				dstNode := SnNode with: dstEntity.
				self setParentOfNode: dstNode.
				nodesDict at: dstEntity put: dstNode.
			]."
		
		"Only create edge if nodes were found."
		(srcNode isNil or: dstNode isNil) ifFalse: [
			
			"Create an edge between the nodes and add it to the graph."
			edge := MalHgEdge with: e from: srcNode to: dstNode.
			
			"Adding edge to the graphs edge set"
			self edges add: edge.
			
			"Add edges to the node themselves"
			srcNode addOutgoing: edge.
			dstNode addIncoming: edge.
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
	self assert: (nodes notEmpty) description: 'Base nodes have to be set before calling this method.'.
	
	"If this method is called, we know that we are in top down building mode, 
	this means all given base nodes are root nodes."
	levels at: 0 put: self nodes asOrderedCollection.

	"Set given block as the higraphs buildingBlock for later use,"
	buildingBlock := aBlock.
	nodesToProcess := Stack new.
	nodesToProcess addAll: nodes values.

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

	"After we have set up the hierarchy, we have to set the levels of the node, 
	so we can use this information when propagating relationships"
	self setLevels.
]

{ #category : #building }
MalHierarchicalGraph >> blockToGetParent: aBlock [ 
	"Builds the hierarchical graph based on the leaf entities and given block"
	| nodesToProcess |
	
	"Make sure leafs are set before calling this method."
	self assert: (nodes notEmpty) description: 'Base nodes have to be set before calling this method.'.
	
	"Set given block as the higraphs buildingBlock for later use,"
	buildingBlock := aBlock.
	nodesToProcess := Stack new.
	nodesToProcess addAll: nodes values.

	[nodesToProcess notEmpty] whileTrue:  [
		| node parentNode |
		
		node := nodesToProcess pop.
		
		parentNode := self setParentOfNode: node.
		
		(parentNode notNil) ifTrue: [
			"Need to re-evaluate found parent"
			nodesToProcess push: parentNode.
		]
	].

	"After we have set up the hierarchy, we have to set the levels of the node, 
	so we can use this information when propagating relationships"
	self setLevels.
]

{ #category : #api }
MalHierarchicalGraph >> bottomUp: howToGetParent [
	"Build the hiGraph bottom up from given leaf nodes."
	self aggregation: howToGetParent.
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
	"Returns a Collection of all edges in this hiGraph."
	^ edges.
]

{ #category : #api }
MalHierarchicalGraph >> edges: aCollection from: source to: destination [
	"Declerative method to add and propagate edges in one go."
	self addEdges: aCollection source: source destination: destination.
	self propagateEdges.
]

{ #category : #api }
MalHierarchicalGraph >> edges: aCollection from: source to: target weight: weightFunction [
	ShouldNotImplement signal. "There are no weights in a hierarchical graph."
]

{ #category : #accessing }
MalHierarchicalGraph >> edgesNotPropagated [
	"Returns a Collection of all edges that were not propagated in this hiGraph."
	^ edges reject: [ :rel | rel class = MalHgPropagatedEdge ].
]

{ #category : #accessing }
MalHierarchicalGraph >> edgesPropagated [
	"Returns a Collection of all edges that were propagated in this hiGraph."
	^ edges select: [ :rel | rel class = MalHgPropagatedEdge ].
]

{ #category : #enumerating }
MalHierarchicalGraph >> findNode: aModel [
	^ self nodeWrapping: aModel.
]

{ #category : #enumerating }
MalHierarchicalGraph >> findNode: aModel ifAbsent: aBlock [
	^ self nodeWrapping: aModel ifAbsent: aBlock.
]

{ #category : #'initialize-release' }
MalHierarchicalGraph >> initialize [
	self reset.

]

{ #category : #enumerating }
MalHierarchicalGraph >> leafNodes [
	"Returns a Collection of all leaf nodes of this hiGraph."
	^ levels at: self deepestLevel.
]

{ #category : #api }
MalHierarchicalGraph >> leaves: entities [
	self nodes: entities.
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
	"Returns the name of this hierarchical graph."
	(name isNil) ifTrue: [
		^ 'a HiGraph'.
	].
	^ name.
]

{ #category : #accessing }
MalHierarchicalGraph >> name: aName [
	"Sets name for this HG"
	name := aName.
]

{ #category : #api }
MalHierarchicalGraph >> node: anEntity [
	"Convenience method to add a single base entity e.g. a single root node."
	self nodes: (OrderedCollection with: anEntity ).
]

{ #category : #configuration }
MalHierarchicalGraph >> nodeClass [
	^ MalHgNode.
]

{ #category : #accessing }
MalHierarchicalGraph >> nodeModels [
	"Returns a Collection of all wrapped models in the nodes of this HiGraph."
	^ nodes keys
]

{ #category : #enumerating }
MalHierarchicalGraph >> nodeWrapping: aModel [
	^ self nodeWrapping: aModel ifAbsent: [ nil ].
]

{ #category : #enumerating }
MalHierarchicalGraph >> nodeWrapping: aModel ifAbsent: aBlock [
	"Returns the node wrapping the given model or nil if such a node does not exists in the graph."
	^ nodes at: aModel ifAbsent: aBlock .
]

{ #category : #accessing }
MalHierarchicalGraph >> nodes [
	"Returns an Array of all nodes in this hiGraph."
	^ nodes values
]

{ #category : #api }
MalHierarchicalGraph >> nodes: aCollection [
	"Adds base entites (can be root or leaf nodes) to the graph from which we will start building the complete graph.
	This has to be done before calling blockToGetChildren or blockToGetParent."
	
	"Adding given entites as MalHgNode to the nodesDict."
	aCollection do: [ :anEntity | 
		nodes at: anEntity put: (MalHgNode in: self with: anEntity).
	]
]

{ #category : #accessing }
MalHierarchicalGraph >> nodesDict [
	"Returns a Dictionary with keys: models and values: nodes"
	^ nodes
]

{ #category : #enumerating }
MalHierarchicalGraph >> nodesDownFromLevel: aLevel [
	"Returns only part of the hiGraph: a Collection of all nodes of given and of deeper levels (deeper meaning farer away from the root nodes)."
	| result currLevel |
	
	result := OrderedCollection new.
	currLevel := aLevel.
	
	[ levels includesKey: currLevel ] whileTrue: [ 
		result addAll: (levels at: currLevel).
		currLevel := currLevel + 1.
	].
	
	 ^ result.
]

{ #category : #enumerating }
MalHierarchicalGraph >> nodesFor: aCollectionOfModels [
	"Returns a Collection of all nodes wrapping given models, empty Set if no corresponding node was found."
	| result node |
	result := OrderedCollection new.
	
	aCollectionOfModels do: [ :aModel |
		node := nodes at: aModel ifAbsent: [ nil ].
		node notNil ifTrue: [
			result add: node.
		].
	].
	
	^ result.
]

{ #category : #enumerating }
MalHierarchicalGraph >> nodesOnLevel: aLevel [
	"Returns only part of the higraph: a collection of all nodes of a certain level (a cross cut of the higraph)"
	^ levels at: aLevel ifAbsent: [ OrderedCollection new ].
]

{ #category : #enumerating }
MalHierarchicalGraph >> nodesUpFromLevel: aLevel [
	"Returns only part of the hiGraph: a collection of all nodes of given and of higher levels (higher means nearer to the root node."
	| result currLevel |
	result := OrderedCollection new.
	currLevel := aLevel.
	[ aLevel >= 0 ] whileTrue: [ 
		result addAll: (levels at: currLevel).
		currLevel := currLevel - 1.
	].
	
	 ^ result.
]

{ #category : #enumerating }
MalHierarchicalGraph >> nodesWrapping: aModelCollection [
	"Returns the nodes wrapping the given entities or an empty collection if no such nodes could be found in the HiGraph."
	"TODO: This is a performance nightmare, no better way to do this?"
	| result |
	result := OrderedCollection new.
	
	nodes do: [ :n | 
		aModelCollection do: [ :e | (n entity = e) ifTrue: [ result add: n ]].
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

{ #category : #private }
MalHierarchicalGraph >> privateEdges: aCollection [
	self edges: aCollection.
]

{ #category : #private }
MalHierarchicalGraph >> privateNodes: aCollection [
	ShouldNotImplement signal.
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
	| nodesToProcess propagatedRelationship srcNode dstNode srcAncestry dstAncestry  srcAncestorNodeIsAllowedClass dstAncestorNodeIsAllowedClass |
	
	nodesToProcess := Stack new.
	nodesToProcess addAll: self nodes.

	[nodesToProcess notEmpty] whileTrue: [
		srcNode := nodesToProcess pop.

		"Only check non-root nodes."
		(srcNode isRootNode) ifFalse: [
		
			"If there are outgoing relationships from this node..."
			(srcNode outgoing notEmpty) 
				ifTrue: [
					
					"Go through all original relations."
					srcNode outgoingNotPropagated do: [ :outgoingRelationship |

						"Get destination node of relationship"
						dstNode := outgoingRelationship to.
						
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
	
											srcAncestorNode model class == class ifTrue: [srcAncestorNodeIsAllowedClass := true ].
											dstAncestorNode model class == class ifTrue: [dstAncestorNodeIsAllowedClass := true ].
										].
									].
								
									"Only add the propoagated relationships if it satisfied the class restrictions."
									(srcAncestorNodeIsAllowedClass and: dstAncestorNodeIsAllowedClass) ifTrue: [
										
										"And finally, create and add a new propagated relationship."
										propagatedRelationship := MalHgPropagatedEdge 
											with: outgoingRelationship model 
											from: srcAncestorNode 
											to: dstAncestorNode.
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
	"Collection of all relationships in the graph."
	edges := OrderedCollection new. 
	
	"Remove edge reference form nodes."
	self nodes ifNotEmpty: [ 
		self nodes do: [ :n | n resetEdges ].
	].
]

{ #category : #resetting }
MalHierarchicalGraph >> resetNodes [
	"dict keys: models, values: nodes"
	nodes := Dictionary new.
	
	"dict keys: level, values: all nodes on that level as a Set."
	levels := Dictionary new.
	
	"If nodes are reset, we have to reset edges as well, since there can't be edges without nodes."
	self resetEdges.
]

{ #category : #api }
MalHierarchicalGraph >> root: entity [
	self node: entity.
]

{ #category : #enumerating }
MalHierarchicalGraph >> rootNodes [
	"Returns a Collection of all root nodes of this hiGraph."
	^ levels at: 0 ifAbsentPut: [OrderedCollection new ].
]

{ #category : #enumerating }
MalHierarchicalGraph >> searchForModelsNamed: aSearchString [
	| matcher |
	"Returns nodes whose model names match the given RegEx String"
	"^ self nodes detect: [ :node | aSearchString match: node entity name ]."
	matcher := RxMatcher forString: aSearchString.
	^ self nodes select: [ :node | matcher search: node model name ].
]

{ #category : #enumerating }
MalHierarchicalGraph >> searchForModelsNamed: aSearchString onLevel: level [
	| matcher |
	"Returns nodes on given level whose model names match the given RegEx String"
	matcher := RxMatcher forString: aSearchString.
	^ (self level: level) select: [ :node | matcher search: node model name ].
]

{ #category : #building }
MalHierarchicalGraph >> setChildrenOfNode: aNode [
	"Gets children of given node via buildingBlock, and sets them.
	Returns a Set with found children, or empty set if no children were found."
	| children childrenEntities childNode |

	self assert: (buildingBlock notNil) description: 'blockToGetChildren must be set before calling this method.'.
	self assert: (self rootNodes notEmpty) description: 'There must be at least one root node set before calling this method.'.
		
	children := OrderedCollection new.

	"Get children entities via blockToGetChildren"
	childrenEntities := buildingBlock value: aNode model.

	"If the entity has no children it is a leaf and we return an empty Set."
	(childrenEntities isNil)
		ifTrue: [ ^ children. ]
		
		"Else we add found children to the graph."
		ifFalse: [
			
			"Go through all found children..."
			childrenEntities do: [ :childEntity | 
		
				"Check if we already have the child stored in the graph, if yes retrieve it, else store it."
				(nodes includesKey: childEntity) 
				ifTrue: [
					childNode := nodes at: childEntity.
				]
				ifFalse: [
					childNode := MalHgNode in: self with: childEntity.
					nodes at: childEntity put: childNode.
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
	| parentNode parentEntity rootLevel |

	self assert: (buildingBlock notNil) description: 'blockToGetParent must be set before calling this method.'.

	"Get parent entity through blockToGetParent"
	parentEntity := buildingBlock value: aNode model.
		
	"If the entity has no parent, it is a rootNode"
	(parentEntity isNil) 
	ifTrue: [
		rootLevel := self rootNodes .
		(rootLevel includes: aNode) ifFalse: [ rootLevel add: aNode ].
		^ nil.
	]
	ifFalse: [
		"Check if we already have the parent stored in the graph, if yes retrieve it, else store it."
		(nodes includesKey: parentEntity) 
			ifTrue: [
				parentNode := nodes at: parentEntity.
			]
			ifFalse: [
				parentNode := MalHgNode in: self with: parentEntity.
				nodes at: parentEntity put: parentNode.
			].
			
		"Add current node as child to parent"
		parentNode addChild: aNode.
			
		"Add parent to current node as parent"
		aNode parent: parentNode.
		
		"Return parent."
		^ parentNode.
	].
]

{ #category : #api }
MalHierarchicalGraph >> topDown: howToGetChildren [
	"Build the hiGraph top down from given root nodes."
	self containment: howToGetChildren.
]
