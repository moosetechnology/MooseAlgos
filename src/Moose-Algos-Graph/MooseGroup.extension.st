Extension { #name : #MooseGroup }

{ #category : #'*moose-algos-graph' }
MooseGroup >> cyclesToAll: aBlockOrUnarySymbol [
	"returns a group of groups containing cycles between the entities from self
	given the connections from each entity to all the entities returned by evaluating aBlockOrUnarySymbol"
	| tarjan cycles |	
	tarjan := MalTarjan new.
	tarjan nodes: self.
	tarjan edges: self from: [:each | each] toAll: aBlockOrUnarySymbol.
	tarjan run.
	cycles := tarjan stronglyConnectedComponents select: [:each | each size > 1].
	^ (cycles
		collect: [:each | 
			(each collect: [:item | item model ]) asMooseGroup]) asMooseGroup
]
