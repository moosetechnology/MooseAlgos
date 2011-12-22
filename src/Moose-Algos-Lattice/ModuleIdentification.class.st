Class {
	#name : #ModuleIdentification,
	#superclass : #Object,
	#instVars : [
		'moduleNodes',
		'lattice',
		'aCandidate',
		'nodesToConsider'
	],
	#category : #'Moose-Algos-Lattice'
}

{ #category : #'initialize-release' }
ModuleIdentification class >> on: lattice [
	
	| identifier |
	identifier := ModuleIdentification new.
	identifier lattice: lattice.
	^ identifier computeModules.
]

{ #category : #'middle-phase' }
ModuleIdentification >> allAncestors: aNode [

	"computes all the anscentors of a node in the lattice"
	
	^ self lattice nodes 
		select: [:each | each descendants includes: aNode].
]

{ #category : #'middle-phase' }
ModuleIdentification >> analyzeDescendantsOf: aTop [
	"aTop is a potential module top node. The method analyzes if the descendants of the aTop only have a single connection to the top and to the bottom"

	| descNodes toRemove |
	
	descNodes := aTop descendants.
	self candidate: aTop.
	descNodes do: [: each | 
		(self hasOneAncestor: each WhichIs: aTop) 
				ifFalse: [
					self flushCandidate.
					^ false ]
				ifTrue: 
					[self candidate: each].
		].
		(self isEndConditionWith: descNodes)
				ifTrue: [	^ true].
	^ self treatNextLevel: (self computeNextLevelNodes: descNodes).
]

{ #category : #accessing }
ModuleIdentification >> candidate [ 
	
	^ aCandidate
]

{ #category : #accessing }
ModuleIdentification >> candidate: anObject [
	
	aCandidate ifNil: [aCandidate := OrderedCollection new].
	(aCandidate includes: anObject)
		ifFalse: [aCandidate add: anObject].
]

{ #category : #'start-phase' }
ModuleIdentification >> computeModules [
	"computes the modules present inside a lattice. A module is a bunch of modes that are connected to the rest of the lattice through a unique top and a bottom node. The algo leaves the top node of the lattice. It then takes all nodes and analyzes its descendantes to see if the bunch forms a module.."

	[self startAlgo] whileTrue: [self startAlgo].
	^ self moduleNodes
]

{ #category : #'middle-phase' }
ModuleIdentification >> computeNextLevelNodes: aCollection [

	^ (aCollection select: [:each | (each descendants size > 1)]) flatCollect: [:each | each descendants]
]

{ #category : #flush }
ModuleIdentification >> flushCandidate [ 
	
	self candidate removeAll.
]

{ #category : #'middle-phase' }
ModuleIdentification >> hasOneAncestor: aNode WhichIs: aTop [	
		"Is ancestor of an aNode the top node and is this the only ancestor of this node"
		
		|myAncestors|
		myAncestors := self allAncestors: aNode.
		
		^ ((myAncestors size =1) and: [myAncestors includes: aTop]) 
]

{ #category : #'end-phase' }
ModuleIdentification >> hasSingleBottom: aNode [
	
	"does the node has a single bottom and no other"
	
	^ (aNode descendants size = 1)
]

{ #category : #initialization }
ModuleIdentification >> initializeNodes [

	nodesToConsider := self lattice nodes.
	nodesToConsider remove: self lattice top.
	
]

{ #category : #'end-phase' }
ModuleIdentification >> isEndConditionWith: descNodes [

	| flag |
	flag := false.
		1 to: (descNodes size -1 ) 
		do: [:n | 	(n+1 to: (descNodes size))
			do:[:m | ((self hasSingleBottom: (descNodes at:n)) and: [self hasSingleBottom: (descNodes at: m)])
				ifTrue: [
						(((descNodes at:n) descendants first = (descNodes at: m) descendants first) and:[(descNodes at: m) descendants first ~= lattice bottom])
							ifTrue: [
								
								self candidate: (descNodes at: m). 
								self candidate: (descNodes at: n).  
								self candidate: (descNodes at:n) descendants first. 
								flag := true.
							]
					]
				]
		].
	flag ifTrue: [self removeFalseCandidates: descNodes. ^ true].			
	^ false
]

{ #category : #accessing }
ModuleIdentification >> lattice [
	^ lattice
]

{ #category : #accessing }
ModuleIdentification >> lattice: anObject [

	lattice := anObject.
	self initializeNodes.
]

{ #category : #accessing }
ModuleIdentification >> moduleNodes [
	^ moduleNodes
]

{ #category : #accessing }
ModuleIdentification >> moduleNodes: aColectionOfNodes [
	
	moduleNodes ifNil: [moduleNodes := OrderedCollection new].
	(moduleNodes includesAllOf: aColectionOfNodes) ifFalse: [ moduleNodes add: aColectionOfNodes copy].
]

{ #category : #'end-phase' }
ModuleIdentification >> removeFalseCandidates: descNodes [

	
	descNodes do: [:each | 
		(self hasSingleBottom: each)
			ifFalse: [self candidate remove:each]
		]
	
]

{ #category : #'start-phase' }
ModuleIdentification >> startAlgo [
	
	1 to: (nodesToConsider size) 
		do: [:n | 
				((nodesToConsider at:n) descendants size > 1)
				ifTrue: [
					
					(self analyzeDescendantsOf: (nodesToConsider at:n))
					ifTrue: [
							self moduleNodes: self candidate.
							nodesToConsider removeAllSuchThat: [:each | self candidate includes: each].
							self flushCandidate.
							^ true.			
						]	
				]   
		].
	^ false.
]

{ #category : #'middle-phase' }
ModuleIdentification >> treatNextLevel: aCollection [
	
	"the purpose of the method is to include the level 2 and beyond nodes in the module"
	(aCollection size = 0) ifTrue: [^false]. 
	aCollection do: [:each |
		(self candidate includesAllOf: (self allAncestors: each))
		 	ifFalse: [nodesToConsider addAll: self candidate. self flushCandidate. ^ false].
			(self isEndConditionWith: aCollection)
							ifTrue: [^ true].
			
		].	
	
	self treatNextLevel: (self computeNextLevelNodes: aCollection)
]
