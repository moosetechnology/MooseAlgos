Extension { #name : #Object }

{ #category : #'*Moose-Algos-ObjectTraverser' }
Object >> deep: aTraversalBlock do: anObjectActionBlock [
	| traverser |
	traverser := MalObjectTraverser withCustomTraversal: aTraversalBlock.
	traverser action: (MalCustomObjectAction new objectAction: anObjectActionBlock).
	traverser traverse: self
]

{ #category : #'*Moose-Algos-ObjectTraverser' }
Object >> deepCollect: aBlock [
	^ (self withDeepCollect: aBlock) remove: self; yourself
]

{ #category : #'*Moose-Algos-ObjectTraverser' }
Object >> withDeepCollect: aBlock [
	| traverser |
	traverser := MalObjectTraverser withCustomTraversal: aBlock.
	^ traverser traverse: self
]
