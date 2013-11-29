Extension { #name : #Object }

{ #category : #'*Moose-Algos-ObjectTraverser' }
Object >> deep: aTraversalBlock do: anObjectActionBlock [
	| traverser |
	traverser := MalTraverser withCustomTraversal: aTraversalBlock.
	traverser action: (MalCustomActionStrategy new objectAction: anObjectActionBlock).
	traverser traverse: self
]

{ #category : #'*Moose-Algos-ObjectTraverser' }
Object >> deepCollect: aBlock [
	^ (self withDeepCollect: aBlock) remove: self; yourself
]

{ #category : #'*Moose-Algos-ObjectTraverser' }
Object >> withDeep: aTraversalBlock do: anObjectActionBlock [
	| traverser action |
	traverser := MalTraverser withCustomTraversal: aTraversalBlock.
	action := MalCustomActionStrategy new objectAction: anObjectActionBlock.
	traverser action: action.
	traverser firstObjectAction: action.
	traverser traverse: self
]

{ #category : #'*Moose-Algos-ObjectTraverser' }
Object >> withDeepCollect: aBlock [
	^ (MalTraverser withCustomTraversal: aBlock)
		traverse: self
]
