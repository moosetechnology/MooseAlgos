Class {
	#name : #MalHierarchicalGraphTests,
	#superclass : #TestCase,
	#classInstVars : [
		'repository'
	],
	#category : #'Moose-Tests-Algos-HierarchicalGraph'
}

{ #category : #examples }
MalHierarchicalGraphTests >> exploreSimpleSampleHiGraph [ 
	| hg  |
	hg := self setupSimpleSampleHiGraph.
	hg explore.
]

{ #category : #examples }
MalHierarchicalGraphTests >> openFamixTreeMap [
	self openFamixTreeMap: 0.
]

{ #category : #examples }
MalHierarchicalGraphTests >> openFamixTreeMap: aLevel [
	| hg vis |
	hg := self setupFamixHiGraph.
	vis := QsVisualizer with: hg.
	vis averageNodeSize: 400.
	vis showSplitOn: aLevel.
]

{ #category : #examples }
MalHierarchicalGraphTests >> openQuicksilverTreeMap: aLevel [
	| hg vis |
	hg := self setupQuicksilverHiGraph.
	vis := QsVisualizer with: hg.
	vis averageNodeSize: 400.
	vis showSplitOn: aLevel.
]

{ #category : #examples }
MalHierarchicalGraphTests >> openSimpleSampleTree [
	| hg vis |
	hg := self setupSimpleSampleHiGraph.
	vis := QsVisualizer with: hg.
	"hg := self setupFamixHiGraph."
	vis showAsTree.
	"hg rootNodes anyOne viewRelationships."
	"hg rootNodes anyOne viewChildrenTreeMap."
	"hg rootNodes anyOne outgoing anyOne view."
]

{ #category : #examples }
MalHierarchicalGraphTests >> openSimpleSampleTreeMap [
	self openSimpleSampleTreeMap: 0.
]

{ #category : #examples }
MalHierarchicalGraphTests >> openSimpleSampleTreeMap: aLevel [
	| hg vis |
	hg := self setupSimpleSampleHiGraph.
	vis := QsVisualizer with: hg.
	vis showSplitOn: aLevel.
]

{ #category : #examples }
MalHierarchicalGraphTests >> openSimpleTreeMap: aLevel [
	| hg vis |
	hg := self setupSimpleNumbersHiGraph.
	vis := QsVisualizer with: hg weightBlock: [ :entity | entity ].
	vis showSplitOn: aLevel.
]

{ #category : #examples }
MalHierarchicalGraphTests >> openSimpleView [
	| hg vis|
	hg := self setupSimpleSampleHiGraph.
	vis := QsVisualizer with: hg.
	"hg := self setupFamixHiGraph."
	vis showAsTree.
	"hg rootNodes anyOne viewRelationships."
	"hg rootNodes anyOne viewChildrenTreeMap."
	"hg rootNodes anyOne outgoing anyOne view."
]

{ #category : #util }
MalHierarchicalGraphTests >> recursiveStringFactory: aString in: aSet to: aLevel. [
	aString size < aLevel
	ifTrue: [
		| childA childB childC |
		childA := aString , 'a'.
		aSet add: childA.
		self recursiveStringFactory: childA in: aSet to: aLevel. 
		childB := aString , 'b'.
		aSet add: childB.
		self recursiveStringFactory: childB in: aSet to: aLevel. 
		childC := aString , 'c'.
		aSet add: childC.
		self recursiveStringFactory: childC in: aSet to: aLevel. 
	].
	
	
]

{ #category : #setup }
MalHierarchicalGraphTests >> setupFamixHiGraph [
	| hg mooseModel |
	mooseModel := MalHgTestResources get: 'famix'.
	
	hg := MalHierarchicalGraph with: mooseModel allMethods asOrderedCollection name: 'FAMIX'.
	
	hg bottomUp: {FAMIXNamedEntity->#belongsTo}.
							
	hg addEdges: mooseModel allSureInvocations
			sourceBlock: [ :e | e from ] 
			destinationBlock: [ :e | e to first ].
			
	"hg addRelationships: mooseModel allInheritanceDefinitions 
			sourceBlock: [ :e | e from ] 
			destinationBlock: [ :e | e to ].
			
	hg addRelationships: mooseModel allAccesses 
		sourceBlock: [ :e | e from ] 
		destinationBlock: [ :e | e to ].
		
	hg addRelationships: mooseModel allReferences 
		sourceBlock: [ :e | e from ] 
		destinationBlock: [ :e | e to ]."
		
	hg propagateEdges.
		
	^ hg.
	
	
]

{ #category : #setup }
MalHierarchicalGraphTests >> setupHiGraph: name [
	"Setup a hiGraph from an exisiting MooseModel (has to be laoded in the moose panel with given name)."
	
	| mooseModel hg aMooseGroup leafs |

	mooseModel := MooseModel root entityNamed: name.
	
	"Removing all stubs."
	leafs := mooseModel allClasses reject: [ :e |
		e isStub
	].

	hg := MalHierarchicalGraph with: leafs name: name. 

	hg blockToGetParent: [ :e | 
		e belongsTo
	].

	"Remove invocations that end in stubs"
	aMooseGroup := mooseModel allSureInvocations reject: [ :invoc |
		invoc candidates first parentType isStub.
	].
	hg addEdges: aMooseGroup
			sourceBlock: [ :e | e from belongsTo ] 
			destinationBlock: [ :e | e to first belongsTo ].
			
	hg propagateEdges.
	
	^ hg.
]

{ #category : #setup }
MalHierarchicalGraphTests >> setupQuicksilverHiGraph [
	| hg mooseModel |
	mooseModel := MalHgTestResources get: 'Quicksilver'.
	hg := MalHierarchicalGraph with: mooseModel name: 'Quicksilver'.
	
	hg nodes: mooseModel allMethods asOrderedCollection.
	
	hg bottomUp: { 
		FAMIXMethod->#belongsTo .
		FAMIXClass->#parentPackage .
		FAMIXPackage->[ :e | e classes anyOne belongsTo]
	}.
							
	hg edges: mooseModel allSureInvocations
			from: #from 
			to: [ :e | e to first ].
			
	"hg addRelationships: mooseModel allInheritanceDefinitions 
			sourceBlock: [ :e | e from ] 
			destinationBlock: [ :e | e to ].
			
	hg addRelationships: mooseModel allAccesses 
		sourceBlock: [ :e | e from ] 
		destinationBlock: [ :e | e to ].
		
	hg addRelationships: mooseModel allReferences 
		sourceBlock: [ :e | e from ] 
		destinationBlock: [ :e | e to ]."
		
	hg propagateEdges.
		
	^ hg.
	
	
]

{ #category : #setup }
MalHierarchicalGraphTests >> setupSimpleBottomUpModel [
	| hg result |
	result := OrderedCollection new.
	hg := MalHierarchicalGraph with: (self setupSimpleTopDownModel) name: 'test'. 
	hg topDown: #children.
	(hg nodesOnLevel: 4) do: [ :e | result add: e entity ].
	^ result.
]

{ #category : #setup }
MalHierarchicalGraphTests >> setupSimpleBottomUpModelHiGraph [
	| hg  |

	hg := MalHierarchicalGraph with: (self setupSimpleBottomUpModel) name: 'topDownWithModel'.
	hg bottomUp: #parent.

	^ hg.
]

{ #category : #setup }
MalHierarchicalGraphTests >> setupSimpleHiGraph [
	| hg leafs edges |

	"Creates a very simple hiGraph with intergers as nodes. 
	It has 3 root nodes (1,2 and 3), some children and various relationships between them."
	
	leafs := OrderedCollection new.
	leafs add: 12; add: 19; add:24; add: 25; add:27; add: 28; add: 31; add: 34; add: 36.

	hg := MalHierarchicalGraph with: leafs name: 'aSimpleHiGraph'.

	hg aggregation: [ :n |  
		(n / 10 < 1) ifTrue: [ nil ] ifFalse: [(n / (10 raisedTo: (n floorLog: 10))) floor asInteger. ]
	].
	
	edges := OrderedCollection new.
	
	edges add: (12->19).
	edges add: (19->24).
	edges add: (19->31).
	edges add: (19->27).
	
	edges add: (25->12).
	edges add: (25->19).
	edges add: (25->19).
	edges add: (25->34).
	
	edges add: (34->12).
	edges add: (34->31).
	edges add: (36->25).
	edges add: (36->24).
	
	hg addEdges: edges
			sourceBlock: [ :e | e key ] 
			destinationBlock: [ :e | e value ].
			
	hg propagateEdges.
	
	^ hg
]

{ #category : #setup }
MalHierarchicalGraphTests >> setupSimpleNumbersHiGraph [
	| hg leafs relationships |

	"Creates a very simple hiGraph with intergers as nodes. 
	It has 3 root nodes (1,2 and 3), some children and various relationships between them."
	
	leafs := OrderedCollection new.
	leafs add: 12; add: 19; add:24; add: 25; add:27; add: 28; add: 31; add: 34; add: 36.

	hg := MalHierarchicalGraph with: leafs name: 'aSimpleHiGraph'.

	hg blockToGetParent: [ :n |  
		(n / 10 < 1) ifTrue: [ nil ] ifFalse: [(n / (10 raisedTo: (n floorLog: 10))) floor asInteger. ]
	].
	
	relationships := OrderedCollection new.
	
	relationships add: (12->19).
	relationships add: (19->24).
	relationships add: (19->31).
	relationships add: (19->27).
	
	relationships add: (25->12).
	relationships add: (25->19).
	relationships add: (25->19).
	relationships add: (25->34).
	
	relationships add: (34->12).
	relationships add: (34->31).
	relationships add: (36->25).
	relationships add: (36->24).
	
	hg addEdges: relationships
			sourceBlock: [ :e | e key ] 
			destinationBlock: [ :e | e value ].
			
	hg propagateEdges.
	
	^ hg
]

{ #category : #setup }
MalHierarchicalGraphTests >> setupSimpleSampleHiGraph [
	| simpleSample hg aMooseGroup leafs |

	simpleSample := MalHgTestResources get: 'simpleSample'.
	

	"Removing all stubs."
"	leafs := simpleSample allClasses reject: [ :e |
		e isStub
	]. "

	leafs := simpleSample allMethods reject: [ :e |
		e parentType isStub
	]. 

	hg := MalHierarchicalGraph with: leafs asOrderedCollection name: 'aSimpleSample'.

	hg blockToGetParent: [ :e | 
			(e isKindOf: FAMIXNamedEntity)
				ifTrue: [ e belongsTo ]
				ifFalse: [ nil ] 
			].
		
	"Remove invocations that end in stubs"
	aMooseGroup := simpleSample allSureInvocations reject: [ :invoc |
		invoc candidates first parentType isStub.
	].
	hg addEdges: aMooseGroup
			sourceBlock: [ :e | e from ] 
			destinationBlock: [ :e | e to first ].
			
	"We don't want stubs in the higraph."
	aMooseGroup := simpleSample allInheritanceDefinitions reject: [ :inheritance |
		inheritance superclass isStub.
	].

	hg addEdges: aMooseGroup
			sourceBlock: [ :e | e from ] 
			destinationBlock: [ :e | e to ].

	"We don't want stubs in the higraph."
	aMooseGroup := simpleSample allAccesses reject: [ :access |
		access variable declaredType isStub.
	].	
	hg addEdges: aMooseGroup
		sourceBlock: [ :e | e from ] 
		destinationBlock: [ :e | e to ].
		
	hg addEdges: simpleSample allReferences 
		sourceBlock: [ :e | e from ] 
		destinationBlock: [ :e | e to ].

	hg propagateEdges.
	
	^ hg.
]

{ #category : #setup }
MalHierarchicalGraphTests >> setupSimpleTopDownModel [
	| parent randomizer nodesToProcess numberOfChildrenAdded child root levelsToCreate childrenToCreate |
	
	"If these values get changed, tests have to be adapted."
	levelsToCreate := 4.
	childrenToCreate := 3.

	numberOfChildrenAdded := 0.
	randomizer := Random new.
	root := MalHgTestModelSimple new.
	root entity: 0.
	root level: 0.
	nodesToProcess := FILOStack new.
	nodesToProcess add: root.

	[nodesToProcess notEmpty] whileTrue: [
		parent := nodesToProcess pop.
		(parent level < levelsToCreate ) ifTrue: [ 
			[ numberOfChildrenAdded < childrenToCreate ] whileTrue: [ 
				child := MalHgTestModelSimple new.
				child parent: parent.
				child level: (parent level + 1).
				child entity: ((randomizer next * 10)  + (10 raisedTo: (child level))) asInteger.
				parent children add: child.
				numberOfChildrenAdded := numberOfChildrenAdded + 1.
				nodesToProcess add: child.
			].
			numberOfChildrenAdded := 0.
		].
	].

	^ root.
]

{ #category : #setup }
MalHierarchicalGraphTests >> setupSimpleTopDownModelHiGraph [
	| hg  |

	hg := MalHierarchicalGraph with: (self setupSimpleTopDownModel) name: 'topDownWithModel'.
	hg top topDown: #children.

	^ hg.
]

{ #category : #setup }
MalHierarchicalGraphTests >> setupVerySimpleHierarchicalGraph [
	| hg |
	hg := MalHierarchicalGraph with: 'baseEntity' name: 'test'.
	self assert: ( hg nodes size = 0).
]

{ #category : #tests }
MalHierarchicalGraphTests >> testBaseEntity [
	| hg |
	hg := MalHierarchicalGraph with: (OrderedCollection with: 2) name: 'Quicksilver'.

	self assert: hg nodes notEmpty.
	self assert: hg nodes size = 1.
	self assert: hg nodes first entity = 2.
]

{ #category : #tests }
MalHierarchicalGraphTests >> testBlockBasedApiBottomUp [
	| hg |
	
	hg := MalHierarchicalGraph with: (self setupSimpleBottomUpModel) name: 'test'.
	hg bottomUp: [ :e | e parent ].
	
	self assert: hg nodes size = 121.
	self assert: hg rootNodes size = 1.
	self assert: hg rootNodes anyOne level = 0.
	self assert: hg rootNodes anyOne children size = 3.
	self assert: hg rootNodes anyOne children anyOne level = 1.
	self assert: hg rootNodes anyOne children anyOne children size = 3.
	self assert: hg rootNodes anyOne children anyOne children anyOne level = 2.
	self assert: hg rootNodes anyOne children anyOne children anyOne children size = 3.
	self assert: hg rootNodes anyOne children anyOne children anyOne children anyOne level = 3.
	self assert: hg rootNodes anyOne children anyOne children anyOne children anyOne children size = 3.
	self assert: hg rootNodes anyOne children anyOne children anyOne children anyOne children anyOne level = 4.
	self assert: hg rootNodes anyOne children anyOne children anyOne children anyOne children anyOne isLeafNode.
	
	"QsVisualizer show: hg withWeightBlock: [ :e | e entity ]."
	
	
	

]

{ #category : #tests }
MalHierarchicalGraphTests >> testBottomUpDeepGraphBuilding [
	| hg rootNodes leafNodes |
	
	rootNodes := OrderedCollection new.
	leafNodes := OrderedCollection new.
	
	rootNodes add: 'a'; add: 'b'; add: 'c'.
	rootNodes do: [ :entity | self recursiveStringFactory: entity in: leafNodes to: 7 ].

	hg := MalHierarchicalGraph with: leafNodes name: 'aBottomUpConstructedGraph'.
	
	hg aggregation:  [ :entity |  
		(entity size > 1) 
		ifTrue: [ entity truncateTo: (entity size - 1). ]
		ifFalse: [ nil ].
	].
	
	self assert: (hg rootNodes size = 3) description: 'Should be exactly 3 root nodes in this graph'.
	self assert: (hg nodes size = 3279) description: 'Should be exactly 3279 nodes in total in this graph'.
	self assert: (hg rootNodes anyOne children size = 3) description: 'Any rootNode should have exactly 3 children'.
	self assert: ((hg nodesFor: (Set with: 'aa')) anyOne parent entity = 'a') description: 'Parent of aa should be a'.
	self assert: ((hg nodesFor: (Set with: 'ca')) anyOne parent entity = 'c') description: 'Parent of ca should be c'.
	self assert: ((hg nodesFor: (Set with: 'aca')) anyOne parent entity = 'ac') description: 'Parent of ac should be aca'.
	self assert: ((hg nodesFor: (Set with: 'aaaaaa')) anyOne parent entity = 'aaaaa') description: 'Parent of aaaaaa should be aaaaa'.
	self assert: ((hg nodesFor: (Set with: 'abacac')) anyOne parent entity = 'abaca') description: 'Parent of abacac should be abaca'.
	self assert: ((hg nodesFor: (Set with: 'caabc')) anyOne parent entity = 'caab') description: 'Parent of caabc should be caab'.
	self assert: ((hg nodesFor: (Set with: 'aaaaaaa')) anyOne isLeafNode) description: 'Node aaaaaaa should be a leaf node'.
	self assert: ((hg nodesFor: (Set with: 'aaaaaaa')) anyOne level = 6) description: 'Node aaaaaaa should be on level 6'.
	self assert: ((hg nodesFor: (Set with: 'c')) anyOne level = 0) description: 'Node c should be on level 0'.
	self assert: ((hg nodesFor: (Set with: 'c')) anyOne isRootNode) description: 'Node c should be a root node'.
	self assert: ((hg nodesFor: (Set with: 'bc')) anyOne level = 1) description: 'Node bc should be on level 1'.
	self assert: ((hg nodesFor: (Set with: 'acb')) anyOne level = 2) description: 'Node acb should be on level 2'.
	self assert: ((hg nodesFor: (Set with: 'caba')) anyOne level = 3) description: 'Node caba should be on level 3'.
	self assert: ((hg nodesFor: (Set with: 'bccab')) anyOne level = 4) description: 'Node bccab should be on level 4'.
	self assert: ((hg nodesFor: (Set with: 'bcabca')) anyOne level = 5) description: 'Node bcabca should be on level 5'.
	self assert: ((hg nodesFor: (Set with: 'caabccc')) anyOne level = 6) description: 'Node caabccc should be on level 6'.
]

{ #category : #tests }
MalHierarchicalGraphTests >> testBottomUpGraphBuilding [
	| hg rootNodes otherNodes model |
	
	rootNodes := OrderedCollection new.
	otherNodes := OrderedCollection new.
	
	rootNodes add: 1; add: 2; add:3.
	otherNodes add: 11; add: 12; add: 13; add: 21; add:22; add: 23; add: 31; add: 32; add: 33.
	
	hg := MalHierarchicalGraph with: otherNodes name: 'aBottomUpConstructedGraph'.

	hg blockToGetParent: [ :n |  
		(n / 10 < 1) ifTrue: [ nil ] ifFalse: [(n / (10 raisedTo: (n floorLog: 10))) floor asInteger. ]
	].
	
	self assert: (hg rootNodes size = 3) description: 'Should be exactly 3 root nodes in this graph'.
	self assert: (hg nodes size = 12) description: 'Should be exactly 12 nodes in total in this graph'.
	self assert: (hg rootNodes anyOne children size = 3) description: 'Any rootNode should have exactly 3 children'.
	self assert: ((hg nodesFor: (Set with: 11)) anyOne parent entity = 1) description: 'Parent of 11 should be 1'.
	self assert: ((hg nodesFor: (Set with: 12)) anyOne parent entity = 1) description: 'Parent of 12 should be 1'.
	self assert: ((hg nodesFor: (Set with: 13)) anyOne parent entity = 1) description: 'Parent of 13 should be 1'.
	self assert: ((hg nodesFor: (Set with: 21)) anyOne parent entity = 2) description: 'Parent of 13 should be 2'.
	self assert: ((hg nodesFor: (Set with: 22)) anyOne parent entity = 2) description: 'Parent of 13 should be 2'.
	self assert: ((hg nodesFor: (Set with: 23)) anyOne parent entity = 2) description: 'Parent of 13 should be 2'.
	self assert: ((hg nodesFor: (Set with: 31)) anyOne parent entity = 3) description: 'Parent of 13 should be 3'.
	self assert: ((hg nodesFor: (Set with: 32)) anyOne parent entity = 3) description: 'Parent of 13 should be 3'.
	self assert: ((hg nodesFor: (Set with: 33)) anyOne parent entity = 3) description: 'Parent of 13 should be 3'.

]

{ #category : #tests }
MalHierarchicalGraphTests >> testClassBasedApiBottomUp [
	| hg |
	
	hg := MalHierarchicalGraph with: (self setupSimpleBottomUpModel) name: 'test'.
	hg bottomUp: {MalHgTestModelSimple->#parent}.
	
	self assert: hg nodes size = 121.
	self assert: hg rootNodes size = 1.
	self assert: hg rootNodes anyOne level = 0.
	self assert: hg rootNodes anyOne children size = 3.
	self assert: hg rootNodes anyOne children anyOne level = 1.
	self assert: hg rootNodes anyOne children anyOne children size = 3.
	self assert: hg rootNodes anyOne children anyOne children anyOne level = 2.
	self assert: hg rootNodes anyOne children anyOne children anyOne children size = 3.
	self assert: hg rootNodes anyOne children anyOne children anyOne children anyOne level = 3.
	self assert: hg rootNodes anyOne children anyOne children anyOne children anyOne children size = 3.
	self assert: hg rootNodes anyOne children anyOne children anyOne children anyOne children anyOne level = 4.
	self assert: hg rootNodes anyOne children anyOne children anyOne children anyOne children anyOne isLeafNode.
	
	"QsVisualizer show: hg withWeightBlock: [ :e | e entity ]."
	
	
	

]

{ #category : #tests }
MalHierarchicalGraphTests >> testClassBasedApiTopDown [
	| hg |
	
	hg := MalHierarchicalGraph with: (self setupSimpleTopDownModel) name: 'test'.
	hg topDown: {MalHgTestModelSimple->#children}.
	
	self assert: hg nodes size = 121.
	self assert: hg rootNodes size = 1.
	self assert: hg rootNodes anyOne level = 0.
	self assert: hg rootNodes anyOne children size = 3.
	self assert: hg rootNodes anyOne children anyOne level = 1.
	self assert: hg rootNodes anyOne children anyOne children size = 3.
	self assert: hg rootNodes anyOne children anyOne children anyOne level = 2.
	self assert: hg rootNodes anyOne children anyOne children anyOne children size = 3.
	self assert: hg rootNodes anyOne children anyOne children anyOne children anyOne level = 3.
	self assert: hg rootNodes anyOne children anyOne children anyOne children anyOne children size = 3.
	self assert: hg rootNodes anyOne children anyOne children anyOne children anyOne children anyOne level = 4.
	self assert: hg rootNodes anyOne children anyOne children anyOne children anyOne children anyOne isLeafNode.
	
	"QsVisualizer show: hg withWeightBlock: [ :e | e entity ]."
	
	
	

]

{ #category : #tests }
MalHierarchicalGraphTests >> testClassBasedBlockApiBottomUp [
	| hg |
	
	hg := MalHierarchicalGraph with: (self setupSimpleBottomUpModel) name: 'test'.
	hg bottomUp: {MalHgTestModelSimple->[:e | e parent]}.
	
	self assert: hg nodes size = 121.
	self assert: hg rootNodes size = 1.
	self assert: hg rootNodes anyOne level = 0.
	self assert: hg rootNodes anyOne children size = 3.
	self assert: hg rootNodes anyOne children anyOne level = 1.
	self assert: hg rootNodes anyOne children anyOne children size = 3.
	self assert: hg rootNodes anyOne children anyOne children anyOne level = 2.
	self assert: hg rootNodes anyOne children anyOne children anyOne children size = 3.
	self assert: hg rootNodes anyOne children anyOne children anyOne children anyOne level = 3.
	self assert: hg rootNodes anyOne children anyOne children anyOne children anyOne children size = 3.
	self assert: hg rootNodes anyOne children anyOne children anyOne children anyOne children anyOne level = 4.
	self assert: hg rootNodes anyOne children anyOne children anyOne children anyOne children anyOne isLeafNode.
	
	"vis := QsVisualizer with: hg weightBlock: [ :e | e entity ].
	vis averageNodeSize: 100.
	vis relativeNodeSizeExtrema: 0.05@1.5.
	vis edgeThicknessRange: 0@10.
	vis layout: QsLayout.	
	vis showSplitOn: 2."
	
	

]

{ #category : #tests }
MalHierarchicalGraphTests >> testDeepestLevel [
| hg rootNodes |
	
	rootNodes := OrderedCollection new.
	rootNodes add: 'a'.
	
	hg := MalHierarchicalGraph with: rootNodes name: 'aTopDownConstructedGraph'.

	hg topDown: [ :entity |  
		(entity size < 3) 
		ifTrue: [
			| result |
			result := Set new.
			result add: (entity, 'a').
			result add: (entity, 'b').
			result.
		]
	].

	self assert: hg deepestLevel = 2.
]

{ #category : #tests }
MalHierarchicalGraphTests >> testEdgePropagationAsymetrical [
| hg rootNodes visualizer relationships |
	
	rootNodes := OrderedCollection new.
	rootNodes add: 'a'.
	
	hg := MalHierarchicalGraph with: rootNodes name: 'aTopDownConstructedGraph'.

	hg blockToGetChildren: [ :entity |  
		(entity size < 3) 
		ifTrue: [
			| result |
			result := Set new.
			result add: (entity, 'a').
			result add: (entity, 'b').
			result.
		]
	].

	relationships := OrderedCollection new.	
	relationships add: ('abb'->'aa').

	hg addEdges: relationships
			sourceBlock: [ :r | r key ] 
			destinationBlock: [ :r | r value ].

	hg propagateEdges.

	"Testing relationships and their propagandation."
	self assert: ((hg nodeWrapping: 'ab') outgoing size = 1).
	self assert: ((hg nodeWrapping: 'abb') outgoing size = 1).
	self assert: ((hg nodeWrapping: 'aa') incoming size = 2).
	self assert: (hg edgesPropagated size = 1).
	self assert: (hg edgesNotPropagated size = 1).

	"hg explore."
	"visualizer := SnVisualizer show: hg withWeightBlock: [ :e | e size ]."
	"visualizer := SnVisualizer with: hg weightBlock: [ :e | e size ]."
	"visualizer showAsTree."
	"visualizer showSplitOn: 2."
	"visualizer show: (hg nodesFor: ((Set with: 'a') add: 'b'; add: 'ca'; add: 'cb'; add: 'cc'; yourself))."
	
]

{ #category : #tests }
MalHierarchicalGraphTests >> testEdgePropagationMultipleRootNodes [
| hg rootNodes visualizer relationships |
	
	rootNodes := OrderedCollection new.
	rootNodes add: 'a'; add: 'b'; add: 'c'.
	
	hg := MalHierarchicalGraph with: rootNodes name: 'aTopDownConstructedGraph'.

	hg blockToGetChildren: [ :entity |  
		(entity size < 6) 
		ifTrue: [
			| result |
			result := Set new.
			result add: (entity, 'a').
			result add: (entity, 'b').
			result add: (entity, 'c').
			result.
		]
	].

	relationships := OrderedCollection new.
	relationships add: ('ab'->'ba').
	"relationships add: ('ab'->'bb').
	relationships add: ('ab'->'bca')."

	hg addEdges: relationships
			sourceBlock: [ :r | r key ] 
			destinationBlock: [ :r | r value ].

	hg propagateEdges.

	"Testing relationships and their propagandation."
	self assert: ((hg nodeWrapping: 'a') outgoing size = 2).
	self assert: ((hg nodeWrapping: 'ab') outgoing size = 2).
	self assert: (hg edgesPropagated size = 3).
	self assert: (hg edgesNotPropagated size = 1).
	self assert: ((hg nodeWrapping: 'b') incoming size = 2).
	
]

{ #category : #tests }
MalHierarchicalGraphTests >> testEdgePropagationMultipleRootNodesAsymetric [
| hg rootNodes relationships |
	
	rootNodes := OrderedCollection new.
	rootNodes add: 'a'; add: 'b'; add: 'c'.
	
	hg := MalHierarchicalGraph with: rootNodes name: 'aTopDownConstructedGraph'.

	hg blockToGetChildren: [ :entity |  
		(entity size < 6) 
		ifTrue: [
			| result |
			result := Set new.
			result add: (entity, 'a').
			result add: (entity, 'b').
			result add: (entity, 'c').
			result.
		]
	].

	relationships := OrderedCollection new.
	relationships add: ('ab'->'baa').

	hg addEdges: relationships
			sourceBlock: [ :r | r key ] 
			destinationBlock: [ :r | r value ].

	hg propagateEdges.

	"Testing relationships and their propagandation."
	self assert: ((hg nodeWrapping: 'a') outgoing size = 3).
	self assert: ((hg nodeWrapping: 'ab') outgoing size = 3).
	self assert: (hg edgesPropagated size = 5).
	self assert: (hg edgesNotPropagated size = 1).
	self assert: ((hg nodeWrapping: 'b') incoming size = 2).
	self assert: ((hg nodeWrapping: 'baa') incoming size = 2).
	self assert: ((hg nodeWrapping: 'ba') incoming size = 2).
	
]

{ #category : #tests }
MalHierarchicalGraphTests >> testEdgePropagationSimple [
| hg rootNodes visualizer relationships |
	
	rootNodes := OrderedCollection new.
	rootNodes add: 'a'.
	
	hg := MalHierarchicalGraph with: rootNodes name: 'aTopDownConstructedGraph'.

	hg blockToGetChildren: [ :entity |  
		(entity size < 3) 
		ifTrue: [
			| result |
			result := Set new.
			result add: (entity, 'a').
			result add: (entity, 'b').
			result.
		]
	].

	relationships := OrderedCollection new.	
	relationships add: ('abb'->'aab').

	hg addEdges: relationships
			sourceBlock: [ :r | r key ] 
			destinationBlock: [ :r | r value ].

	hg propagateEdges.

	"Testing relationships and their propagandation."
	self assert: ((hg nodeWrapping: 'ab') outgoing size = 2).
	self assert: ((hg nodeWrapping: 'abb') outgoing size = 2).
	self assert: ((hg nodeWrapping: 'aa') incoming size = 2).
	self assert: (hg edgesPropagated size = 3).
	self assert: (hg edgesNotPropagated size = 1).

	"hg explore."
	"visualizer := SnVisualizer show: hg withWeightBlock: [ :e | e size ]."
	"visualizer := SnVisualizer with: hg weightBlock: [ :e | e size ]."
	"visualizer showAsTree."
	"visualizer showSplitOn: 2."
	"visualizer show: (hg nodesFor: ((Set with: 'a') add: 'b'; add: 'ca'; add: 'cb'; add: 'cc'; yourself))."
	
]

{ #category : #tests }
MalHierarchicalGraphTests >> testEmptyHiGraph [
	| hg |
	hg := MalHierarchicalGraph with: (OrderedCollection new) name: 'Softwarenaut'.
	self assert: hg nodes isEmpty.
	self assert: hg rootNodes isEmpty.
	self assert: hg edges isEmpty.
	self assert: hg name = 'Softwarenaut'.
]

{ #category : #tests }
MalHierarchicalGraphTests >> testFamixHiGraph [
	| hg famixRootNode  |
	hg := self setupFamixHiGraph.
			
	self assert: hg class = MalHierarchicalGraph.
	self assert: hg rootNodes notEmpty.
	
	"Should only be one in the case of FAMIX"
	self assert: hg rootNodes size = 1.
	
	famixRootNode := hg rootNodes anyOne.	
		
	self assert: famixRootNode entity name = 'Smalltalk'.
	
	"Test whether parent of children is parent"
	self assert: hg rootNodes asArray first children asArray first parent = hg rootNodes asArray first.
	
	"anInheritance := (hg relationshipsDict select: [ :each | each source entity name = #Object ]) keys anyOne."
	
	"self
		assert: (anInheritance subclass name = #Object and: anInheritance superclass name = #ProtoObject)."
	
	"protoObjectEntity := (hg nodeEntities select: [ :e | e name = #ProtoObject ]) anyOne."
	
	"(hg nodesDict at: protoObjectEntity) explore."
	
	"hg explore."
	
	
	
]

{ #category : #tests }
MalHierarchicalGraphTests >> testFamixHierarchy [
	| hg aRootNode |
	
	hg := self setupFamixHiGraph.
					
	"assert roots have no parents"
	hg rootNodes asArray do: [ :e | 
		self assert: e parent isNil.
	].
	
	"assert children are nodes and have parent as parent"
	hg rootNodes asArray do: [ :rn | 
		self assert: rn class = MalHgNode.
		rn children do: [ :c | 
			self assert: c class = MalHgNode.
			self assert: c parent = rn.
		].
	].

	"Test basic FAMIX Hierarchy"
	aRootNode := hg rootNodes anyOne.
	self assert: aRootNode entity class = FAMIXNamespace.
	self assert: aRootNode children anyOne entity class = FAMIXClass.
	self assert: aRootNode children anyOne children anyOne entity class = FAMIXMethod.


]

{ #category : #tests }
MalHierarchicalGraphTests >> testGetLevel [
	| hg |
	
	hg := self setupSimpleSampleHiGraph.
		
	self assert: ((hg nodesOnLevel: -1) size) = 0.
	self assert: ((hg nodesOnLevel: 0) size) = 1.
	self assert: ((hg nodesOnLevel: 1) size) = 1.
	self assert: ((hg nodesOnLevel: 2) size) = 1.
	self assert: ((hg nodesOnLevel: 3) size) = 3.
	self assert: ((hg nodesOnLevel: 4) size) = 6.
	self assert: ((hg nodesOnLevel: 5) size) = 12.
	self assert: ((hg nodesOnLevel: 6) size) = 18.
	self assert: ((hg nodesOnLevel: 7) size) = 0.

]

{ #category : #tests }
MalHierarchicalGraphTests >> testLevels [
	| hg |
	
	hg := self setupSimpleNumbersHiGraph.

	self assert: ((hg nodeWrapping: 1) level = 0).
	self assert: ((hg nodeWrapping: 1) isRootNode).
	self assert: ((hg nodeWrapping: 2) level = 0).
	self assert: ((hg nodeWrapping: 3) level = 0).
	self assert: ((hg nodeWrapping: 34) level = 1).
	self assert: ((hg nodeWrapping: 25) level = 1).
	self assert: ((hg nodeWrapping: 36) level = 1).
	self assert: ((hg nodeWrapping: 12) level = 1).
]

{ #category : #tests }
MalHierarchicalGraphTests >> testNodeWrapping [
	| hg |
	
	hg := self setupSimpleNumbersHiGraph.

	self assert: ((hg nodeWrapping: 999) = nil).
	self assert: ((hg nodesDict at: 1) = (hg nodeWrapping: 1)).
	self assert: ((hg nodesDict at: 24) = (hg nodeWrapping: 24)).
	
]

{ #category : #tests }
MalHierarchicalGraphTests >> testNodesForEntities [
	| hg |
	
	hg := self setupSimpleNumbersHiGraph.
	
	self assert: ((hg nodesFor: (Set new)) isEmpty).
	self assert: (((hg nodesFor: (Set with: 1)) size) = 1).
	self assert: (((hg nodesFor: (Set with: 1)) anyOne) entity = 1).
	self assert: (((hg nodesFor: (Set new add: 1; add: 2; yourself)) size) = 2).
	self assert: (((hg nodesFor: (Set new add: 1; add: 2; add: 999; yourself)) size) = 2).
	self assert: (((hg nodesFor: (Set new add: 1; add: 2; add: 34; yourself)) size) = 3).
	self assert: (((hg nodesFor: (Set new add: 1; add: 12; add: 34; add: 19; yourself)) size) = 4).
]

{ #category : #tests }
MalHierarchicalGraphTests >> testRecursiveChildren [
	| hg |
	hg := self setupSimpleSampleHiGraph.

	"Assert that there are more nodes in the highraph in total than some rootNodes sub graph."
	self assert: hg nodes size > hg rootNodes anyOne recursiveChildren size.

	"Assert that the total size of nodes in the higraph is equal to all rootNodes and their recursive children."
	self assert: (hg nodes size = (hg rootNodes size + (hg rootNodes inject: 0 into: [:sum :each | sum + each recursiveChildren size]))).
	
]

{ #category : #tests }
MalHierarchicalGraphTests >> testSimpleApiBottomUp [
	| hg |
	
	hg := MalHierarchicalGraph with: (self setupSimpleBottomUpModel) name: 'test'. 
	hg bottomUp: #parent.
	
	self assert: hg nodes size = 121.
	self assert: hg rootNodes size = 1.
	self assert: hg rootNodes anyOne level = 0.
	self assert: hg rootNodes anyOne children size = 3.
	self assert: hg rootNodes anyOne children anyOne level = 1.
	self assert: hg rootNodes anyOne children anyOne children size = 3.
	self assert: hg rootNodes anyOne children anyOne children anyOne level = 2.
	self assert: hg rootNodes anyOne children anyOne children anyOne children size = 3.
	self assert: hg rootNodes anyOne children anyOne children anyOne children anyOne level = 3.
	self assert: hg rootNodes anyOne children anyOne children anyOne children anyOne children size = 3.
	self assert: hg rootNodes anyOne children anyOne children anyOne children anyOne children anyOne level = 4.
	self assert: hg rootNodes anyOne children anyOne children anyOne children anyOne children anyOne isLeafNode.
	
	"QsVisualizer show: hg withWeightBlock: [ :e | e entity ]."
	
	
	

]

{ #category : #tests }
MalHierarchicalGraphTests >> testSimpleApiTopDown [
	| hg |
	
	hg := MalHierarchicalGraph with: (self setupSimpleTopDownModel) name: 'test'. 
	hg topDown: #children.
	
	self assert: hg nodes size = 121.
	self assert: hg rootNodes size = 1.
	self assert: hg rootNodes anyOne level = 0.
	self assert: hg rootNodes anyOne children size = 3.
	self assert: hg rootNodes anyOne children anyOne level = 1.
	self assert: hg rootNodes anyOne children anyOne children size = 3.
	self assert: hg rootNodes anyOne children anyOne children anyOne level = 2.
	self assert: hg rootNodes anyOne children anyOne children anyOne children size = 3.
	self assert: hg rootNodes anyOne children anyOne children anyOne children anyOne level = 3.
	self assert: hg rootNodes anyOne children anyOne children anyOne children anyOne children size = 3.
	self assert: hg rootNodes anyOne children anyOne children anyOne children anyOne children anyOne level = 4.
	self assert: hg rootNodes anyOne children anyOne children anyOne children anyOne children anyOne isLeafNode.
	
	"QsVisualizer show: hg withWeightBlock: [ :e | e entity ]."
	
	
	

]

{ #category : #tests }
MalHierarchicalGraphTests >> testSimpleEdgeApi [
| hg rootNodes relationships |
	
	rootNodes := OrderedCollection new.
	rootNodes add: 'a'; add: 'b'; add: 'c'.
	
	hg := MalHierarchicalGraph with: rootNodes name: 'aTopDownConstructedGraph'.

	hg topDown: [ :entity |  
		(entity size < 6) 
		ifTrue: [
			| result |
			result := Set new.
			result add: (entity, 'a').
			result add: (entity, 'b').
			result add: (entity, 'c').
			result.
		]
	].

	relationships := OrderedCollection new.
	relationships add: ('ab'->'ba').
	relationships add: ('ab'->'bb').
	relationships add: ('a'->'b').
	relationships add: ('a'->'c').
	relationships add: ('a'->'ab').

	hg addEdges: relationships from: #key to: #value.

	self assert: (hg nodeWrapping: 'a') outgoing size = 3.
	self assert: (hg nodeWrapping: 'ab') outgoing size = 2.
	self assert: (hg nodeWrapping: 'ba') outgoing isEmpty.
	self assert: (hg nodeWrapping: 'ba') incoming size = 1.
	self assert: (hg nodeWrapping: 'b') incoming size = 1.
	self assert: (hg nodeWrapping: 'c') incoming size = 1.
	self assert: (hg nodeWrapping: 'ab') incoming size = 1.
	self assert: (hg nodeWrapping: 'cb') incoming isEmpty.
	
]

{ #category : #tests }
MalHierarchicalGraphTests >> testSimpleEdgeApiWithModel [
| hg rootNodes edges |
	
	rootNodes := OrderedCollection new.
	rootNodes add: 'a'; add: 'b'; add: 'c'.
	
	hg := MalHierarchicalGraph with: rootNodes name: 'aTopDownConstructedGraph'.

	hg topDown: [ :entity |  
		(entity size < 6) 
		ifTrue: [
			| result |
			result := Set new.
			result add: (entity, 'a').
			result add: (entity, 'b').
			result add: (entity, 'c').
			result.
		]
	].

	edges := OrderedCollection new.
	edges add: (MalHgTestEdge from: 'ab' to: 'ba').
	edges add: (MalHgTestEdge from: 'ab' to: 'bb').
	edges add: (MalHgTestEdge from: 'a' to: 'b').
	edges add: (MalHgTestEdge from: 'a' to: 'c').
	edges add: (MalHgTestEdge from: 'a' to: 'ab').

	hg addEdges: edges from: {MalHgTestEdge->#from} to: {MalHgTestEdge->#to}.

	self assert: (hg nodeWrapping: 'a') outgoing size = 3.
	self assert: (hg nodeWrapping: 'ab') outgoing size = 2.
	self assert: (hg nodeWrapping: 'ba') outgoing isEmpty.
	self assert: (hg nodeWrapping: 'ba') incoming size = 1.
	self assert: (hg nodeWrapping: 'b') incoming size = 1.
	self assert: (hg nodeWrapping: 'c') incoming size = 1.
	self assert: (hg nodeWrapping: 'ab') incoming size = 1.
	self assert: (hg nodeWrapping: 'cb') incoming isEmpty.
	
	hg resetEdges.
	
	hg addEdges: edges from: {MalHgTestEdge->[ :e | e from]} to: {MalHgTestEdge->[ :e | e to]}.
	
	self assert: (hg nodeWrapping: 'a') outgoing size = 3.
	self assert: (hg nodeWrapping: 'ab') outgoing size = 2.
	self assert: (hg nodeWrapping: 'ba') outgoing isEmpty.
	self assert: (hg nodeWrapping: 'ba') incoming size = 1.
	self assert: (hg nodeWrapping: 'b') incoming size = 1.
	self assert: (hg nodeWrapping: 'c') incoming size = 1.
	self assert: (hg nodeWrapping: 'ab') incoming size = 1.
	self assert: (hg nodeWrapping: 'cb') incoming isEmpty.
	
	hg resetEdges.
	
	"This makes no sense, but it has to work anyway."
	hg addEdges: edges 
		from: {MalHgTestEdge->#from . MalHgTestEdge->#from } 
		to: {MalHgTestEdge->#to . MalHgTestEdge->#to}.
	
	self assert: (hg nodeWrapping: 'a') outgoing size = 3.
	self assert: (hg nodeWrapping: 'ab') outgoing size = 2.
	self assert: (hg nodeWrapping: 'ba') outgoing isEmpty.
	self assert: (hg nodeWrapping: 'ba') incoming size = 1.
	self assert: (hg nodeWrapping: 'b') incoming size = 1.
	self assert: (hg nodeWrapping: 'c') incoming size = 1.
	self assert: (hg nodeWrapping: 'ab') incoming size = 1.
	self assert: (hg nodeWrapping: 'cb') incoming isEmpty.
	
]

{ #category : #tests }
MalHierarchicalGraphTests >> testSimpleModel [
	| root |
	root := self setupSimpleTopDownModel.
	
	"We have four levels"
	self assert: root children size = 3.
	self assert: root children anyOne children size = 3.
	self assert: root children anyOne children anyOne children size = 3.
	self assert: root children anyOne children anyOne children anyOne children size = 3.
	self assert: root children anyOne children anyOne children anyOne children anyOne children size = 0.
	
	"We have a hierarchy chain"
	self assert: root children anyOne children anyOne children anyOne parent parent parent = root.
	
	"root is root"
	self assert: root parent = nil.
	
	

]

{ #category : #tests }
MalHierarchicalGraphTests >> testSingleNodeHiGraph [
	| hg  |
	hg := MalHierarchicalGraph with: (OrderedCollection with: 'someBaseEntity') name: 'Softwarenaut'.
	self assert: (hg nodes size = 1).
]

{ #category : #tests }
MalHierarchicalGraphTests >> testTopDownDeepGraphBuilding [
	| hg rootNodes |
	
	rootNodes := OrderedCollection new.
	rootNodes add: 'a'; add: 'b'; add: 'c'.
	
	hg := MalHierarchicalGraph with: rootNodes name: 'aTopDownConstructedGraph'.

	hg topDown: [ :entity |  
		(entity size < 7) 
		ifTrue: [
			| result |
			result := Set new.
			result add: (entity, 'a').
			result add: (entity, 'b').
			result add: (entity, 'c').
			result.
		]
	].
	
	"Testing nodes and hierarchy."
	self assert: (hg rootNodes size = 3) description: 'Should be exactly 3 root nodes in this graph'.
	self assert: (hg nodes size = 3279) description: 'Should be exactly 3279 nodes in total in this graph'.
	self assert: (hg rootNodes anyOne children size = 3) description: 'Any rootNode should have exactly 3 children'.
	self assert: ((hg nodesFor: (Set with: 'aa')) anyOne parent entity = 'a') description: 'Parent of aa should be a'.
	self assert: ((hg nodesFor: (Set with: 'ca')) anyOne parent entity = 'c') description: 'Parent of ca should be c'.
	self assert: ((hg nodesFor: (Set with: 'aca')) anyOne parent entity = 'ac') description: 'Parent of ac should be aca'.
	self assert: ((hg nodesFor: (Set with: 'aaaaaa')) anyOne parent entity = 'aaaaa') description: 'Parent of aaaaaa should be aaaaa'.
	self assert: ((hg nodesFor: (Set with: 'abacac')) anyOne parent entity = 'abaca') description: 'Parent of abacac should be abaca'.
	self assert: ((hg nodesFor: (Set with: 'caabc')) anyOne parent entity = 'caab') description: 'Parent of caabc should be caab'.
	self assert: ((hg nodesFor: (Set with: 'aaaaaaa')) anyOne isLeafNode) description: 'Node aaaaaaa should be a leaf node'.
	self assert: ((hg nodesFor: (Set with: 'aaaaaaa')) anyOne level = 6) description: 'Node aaaaaaa should be on level 6'.
	self assert: ((hg nodesFor: (Set with: 'c')) anyOne level = 0) description: 'Node c should be on level 0'.
	self assert: ((hg nodesFor: (Set with: 'c')) anyOne isRootNode) description: 'Node c should be a root node'.
	self assert: ((hg nodesFor: (Set with: 'bc')) anyOne level = 1) description: 'Node bc should be on level 1'.
	self assert: ((hg nodesFor: (Set with: 'acb')) anyOne level = 2) description: 'Node acb should be on level 2'.
	self assert: ((hg nodesFor: (Set with: 'caba')) anyOne level = 3) description: 'Node caba should be on level 3'.
	self assert: ((hg nodesFor: (Set with: 'bccab')) anyOne level = 4) description: 'Node bccab should be on level 4'.
	self assert: ((hg nodesFor: (Set with: 'bcabca')) anyOne level = 5) description: 'Node bcabca should be on level 5'.
	self assert: ((hg nodesFor: (Set with: 'caabccc')) anyOne level = 6) description: 'Node caabccc should be on level 6'.
	
	"hg explore."
	"visualizer := QsVisualizer show: hg withWeightBlock: [ :e | e size ]."
	"visualizer := QsVisualizer with: hg weightBlock: [ :e | e size ]."
	"visualizer showAsTree."
	"visualizer showSplitOn: 2."
	"visualizer show: (hg nodesFor: ((Set with: 'a') add: 'b'; add: 'ca'; add: 'cb'; add: 'cc'; yourself))."
	
]

{ #category : #tests }
MalHierarchicalGraphTests >> testTopDownGraphBuilding [
	| hg rootNodes otherNodes model |
	
	rootNodes := OrderedCollection new.
	
	rootNodes add: 1; add: 2; add:3.
	
	hg := MalHierarchicalGraph with: rootNodes name: 'aTopDownConstructedGraph'.

	hg blockToGetChildren: [ :n |  
		(n = 1 or: (n = 2 or: n = 3)) 
		ifTrue: [
			| result |
			result := Set new.
			result add: ((n asString , '1') asInteger).
			result add: ((n asString , '2') asInteger).
			result add: ((n asString , '3') asInteger).
			result.
		]
	].
	
	self assert: (hg rootNodes size = 3) description: 'Should be exactly 3 root nodes in this graph'.
	self assert: (hg nodes size = 12) description: 'Should be exactly 12 nodes in total in this graph'.
	self assert: (hg rootNodes anyOne children size = 3) description: 'Any rootNode should have exactly 3 children'.
	self assert: ((hg nodesFor: (Set with: 11)) anyOne parent entity = 1) description: 'Parent of 11 should be 1'.
	self assert: ((hg nodesFor: (Set with: 12)) anyOne parent entity = 1) description: 'Parent of 12 should be 1'.
	self assert: ((hg nodesFor: (Set with: 13)) anyOne parent entity = 1) description: 'Parent of 13 should be 1'.
	self assert: ((hg nodesFor: (Set with: 21)) anyOne parent entity = 2) description: 'Parent of 13 should be 2'.
	self assert: ((hg nodesFor: (Set with: 22)) anyOne parent entity = 2) description: 'Parent of 13 should be 2'.
	self assert: ((hg nodesFor: (Set with: 23)) anyOne parent entity = 2) description: 'Parent of 13 should be 2'.
	self assert: ((hg nodesFor: (Set with: 31)) anyOne parent entity = 3) description: 'Parent of 13 should be 3'.
	self assert: ((hg nodesFor: (Set with: 32)) anyOne parent entity = 3) description: 'Parent of 13 should be 3'.
	self assert: ((hg nodesFor: (Set with: 33)) anyOne parent entity = 3) description: 'Parent of 13 should be 3'.

]

{ #category : #tests }
MalHierarchicalGraphTests >> testVerySimpleHierarchicalGraph [
	| hg leafs rootNodes baseRelationships padreHijoRelationships |
	
	leafs := #(1 2 3 4 5).
	rootNodes := #(6 7).
	
	hg := MalHierarchicalGraph with: rootNodes name: 'Quicksilver'.
	
	baseRelationships := OrderedCollection new.
	baseRelationships 
		add: (1 -> 2);
		add: (1 -> 3);
		add: (3 -> 4);
		add: (2 -> 5).
		
	padreHijoRelationships := Dictionary new.
	padreHijoRelationships 
		at: 6 put: #(1 2 3);
		at: 7 put: #(4 5).
	
	hg blockToGetChildren: [ :padre |
		padreHijoRelationships at: padre ifAbsent: [ nil ].
	].
	
	hg addEdges: 
		baseRelationships 
		sourceBlock:  [:e | e key]
		destinationBlock: [:e | e value].

	hg propagateEdges.
	
	self assert: (hg edges size > 0).
	self assert: (hg edges contains: [:rel | rel source entity = 6 and: [rel destination entity = 7]]).

	"visualizer := SnVisualizer show: hg withWeightBlock: [ :e | e ]."
	

]
