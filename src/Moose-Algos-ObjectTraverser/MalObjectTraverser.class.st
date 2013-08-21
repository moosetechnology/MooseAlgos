Class {
	#name : #MalObjectTraverser,
	#superclass : #Object,
	#instVars : [
		'graph',
		'traversed'
	],
	#category : #'Moose-Algos-ObjectTraverser'
}

{ #category : #'public interface' }
MalObjectTraverser >> doTraverse: anObject [
	(self hasAlreadyTraversed: anObject)
		ifFalse: [ 
			graph nodes: {anObject}.
			traversed add: anObject.
			self 
				objectsToTraverseWithoutCollectionsFrom: anObject 
				do: [ :each | 
					each ifNotNil: [
						self doTraverse: each.
						graph edges: { each } from: [ :x | anObject ] to: [ :x | x ] ] ] ]
]

{ #category : #accessing }
MalObjectTraverser >> graph [
	^ graph
]

{ #category : #accessing }
MalObjectTraverser >> graph: anObject [
	graph := anObject
]

{ #category : #private }
MalObjectTraverser >> hasAlreadyTraversed: anEntity [
	^ self traversed includes: anEntity
]

{ #category : #initialization }
MalObjectTraverser >> initialize [ 
	traversed := IdentitySet new.
	graph := MalGraphStructure new nodeClass: MalTraverserGraphNode; yourself.
]

{ #category : #private }
MalObjectTraverser >> objectToTraverseFrom: anObject do: aBlock [
	self subclassResponsibility 
]

{ #category : #private }
MalObjectTraverser >> objectsToTraverseWithoutCollectionsFrom: anObject do: aBlock [
	self objectToTraverseFrom: anObject do: [ :eachObject |
		eachObject isCollection 
			ifTrue: [ 
					eachObject do: [ :each | 
						aBlock value: each.
						self 
							objectsToTraverseWithoutCollectionsFrom: each 
							do: aBlock ] ]
			ifFalse: [ aBlock value: eachObject ] ]
]

{ #category : #'public interface' }
MalObjectTraverser >> traverse: anObject [
	self doTraverse: anObject.
	^ self traversed
]

{ #category : #accessing }
MalObjectTraverser >> traversed [
	^ traversed
]
