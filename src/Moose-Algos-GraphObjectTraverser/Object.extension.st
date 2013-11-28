Extension { #name : #Object }

{ #category : #'*Moose-Algos-GraphObjectTraverser' }
Object >> deepGraph: aBlock [
	| traverser |
	traverser := MalCustomObjectTraverser with: aBlock.
	traverser traverse: self.
	^ traverser graph
]
