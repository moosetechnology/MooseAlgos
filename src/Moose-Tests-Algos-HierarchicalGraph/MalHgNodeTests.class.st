Class {
	#name : #MalHgNodeTests,
	#superclass : #TestCase,
	#category : #'Moose-Tests-Algos-HierarchicalGraph'
}

{ #category : #setup }
MalHgNodeTests >> setupSimpleSampleHiGraph [
	| simpleSample hg aMooseGroup leafs |

	simpleSample := MalHgTestResources get: 'simpleSample'.
	hg := MalHierarchicalGraph with: simpleSample name: 'aSimpleSample'.

	"Removing all stubs."
"	leafs := simpleSample allClasses reject: [ :e |
		e isStub
	]. "

	leafs := simpleSample allMethods reject: [ :e |
		e parentType isStub
	]. 

	hg nodes: leafs.

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
MalHgNodeTests >> testParentOnLevel [
	| hg rootNodes  |
	
	rootNodes := OrderedCollection new.
	rootNodes add: 'a'; add: 'b'; add: 'c'.
	
	hg := MalHierarchicalGraph with: rootNodes name: 'aTopDownConstructedGraph'.

	hg blockToGetChildren: [ :entity |  
		(entity size < 4) 
		ifTrue: [
			| result |
			result := Set new.
			result add: (entity, 'a').
			result add: (entity, 'b').
			result add: (entity, 'c').
			result.
		]
	].

	self should: [((hg nodeWrapping: 'aba') parentOnLevel: -1) = (hg nodeWrapping: 'a')] raise: AssertionFailure.
	self assert: (((hg nodeWrapping: 'aba') parentOnLevel: 10) = nil).
	
	self assert: (((hg nodeWrapping: 'aba') parentOnLevel: 0) = (hg nodeWrapping: 'a')).
	self assert: (((hg nodeWrapping: 'aba') parentOnLevel: 1) = (hg nodeWrapping: 'ab')).
	self assert: (((hg nodeWrapping: 'cabc') parentOnLevel: 1) = (hg nodeWrapping: 'ca')).
	self assert: (((hg nodeWrapping: 'baac') parentOnLevel: 3) = nil).
	self assert: (((hg nodeWrapping: 'baac') parentOnLevel: 2) = (hg nodeWrapping: 'baa')).
	self assert: (((hg nodeWrapping: 'bbbc') parentOnLevel: 0) = (hg nodeWrapping: 'b')).

	
]

{ #category : #examples }
MalHgNodeTests >> viewTreeMap [
	| hg beingsNode view vis |
	hg := self setupSimpleSampleHiGraph.
	
	beingsNode := hg nodes detect: [ :e | 'beings' match: e entity name ].
	
  	vis := QsVisualizer with: hg.
	vis show: (Array with: beingsNode).
]
