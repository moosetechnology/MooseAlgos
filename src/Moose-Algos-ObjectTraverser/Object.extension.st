Extension { #name : #Object }

{ #category : #'*Moose-Algos-ObjectTraverser' }
Object >> deepCollect: aBlock [
	^ (self withDeepCollect: aBlock) remove: self; yourself
]

{ #category : #'*Moose-Algos-ObjectTraverser' }
Object >> deepGraph: aBlock [
	| traverser |
	traverser := MalCustomObjectTraverser with: aBlock.
	traverser traverse: self.
	^ traverser graph
]

{ #category : #'*Moose-Algos-ObjectTraverser' }
Object >> withDeepCollect: aBlock [
	| traverser |
	traverser := MalCustomObjectTraverser with: aBlock.
	^ traverser traverse: self
]
