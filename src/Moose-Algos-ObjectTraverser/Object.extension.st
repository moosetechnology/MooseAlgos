Extension { #name : #Object }

{ #category : #'*Moose-Algos-ObjectTraverser' }
Object >> deep: aTraversalBlock collect: aCollectBlock [
	| result |
	result := OrderedCollection new.
	self 
		deep: aTraversalBlock 
		do: [ :each | result add: (aCollectBlock value: each) ].
	^ result
]

{ #category : #'*Moose-Algos-ObjectTraverser' }
Object >> deep: aTraversalBlock do: anObjectActionBlock [
	| traverser action |
	action := MalCustomActionStrategy new objectAction: anObjectActionBlock.
	traverser := MalTraverser withCustomTraversal: aTraversalBlock.
	traverser 
		action: action;
		traverse: self
]

{ #category : #'*Moose-Algos-ObjectTraverser' }
Object >> deep: aTraversalBlock flatCollect: aCollectBlock [
	| result |
	result := OrderedCollection new.
	self 
		deep: aTraversalBlock 
		do: [ :each | result addAll: (aCollectBlock value: each) ].
	^ result
]

{ #category : #'*Moose-Algos-ObjectTraverser' }
Object >> deepCollect: aBlock [
	^ self deepCollect: aBlock as: OrderedCollection
]

{ #category : #'*Moose-Algos-ObjectTraverser' }
Object >> deepCollect: aBlock as: aCollectionClass [
	| result |
	result := aCollectionClass new.
	self
		deep: aBlock 
		do: [ :each | result add: each ].
	^ result
]

{ #category : #'*Moose-Algos-ObjectTraverser' }
Object >> deepCollectAsSet: aBlock [
	"When the desired result is a set, we take advantage of the 
	fact that the traversed objects are kept in a set inside the traverser
	and we simply return that set"
	^ ((MalTraverser withCustomTraversal: aBlock)
		traverse: self)
		remove: self;
		yourself
]

{ #category : #'*Moose-Algos-ObjectTraverser' }
Object >> withDeep: aTraversalBlock do: anObjectActionBlock [
	| traverser action |
	action := MalCustomActionStrategy new objectAction: anObjectActionBlock.
	traverser := MalTraverser withCustomTraversal: aTraversalBlock.
	traverser 
		action: action;
		firstObjectAction: action;
		traverse: self
]

{ #category : #'*Moose-Algos-ObjectTraverser' }
Object >> withDeepCollect: aBlock [
	| result |
	result := OrderedCollection new.
	self withDeep: aBlock do: [ :each | result add: each ].
	^ result
]
