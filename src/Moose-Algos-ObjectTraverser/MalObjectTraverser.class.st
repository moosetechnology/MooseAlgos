"
The traverser has three responsibilities:
1. traverse objects,
2. mark traversed objects
3. trigger actions for each traversed object and each relation between two traversed objects

1. is handled via  the MalObjectTraversal hierarchy
"
Class {
	#name : #MalObjectTraverser,
	#superclass : #Object,
	#instVars : [
		'traversed',
		'traversal'
	],
	#category : #'Moose-Algos-ObjectTraverser'
}

{ #category : #'instance creation' }
MalObjectTraverser class >> withCustomTraversal: aBlock [
	"we provide a utility method for handling block traversals
	given that this is likely to be the most common use case"
	^ self new 
		traversal: (MalCustomObjectTraversal with: aBlock)
]

{ #category : #private }
MalObjectTraverser >> actOnObject: anObject [
	"override this method in subclasses to trigger
	behavior associated with each traversed object"
]

{ #category : #private }
MalObjectTraverser >> actOnRelationFrom: originObject to: targetObject [
	"override this method in subclasses to trigger
	behavior associated with the relation between 
	the origin and the target of a traversed relation"
]

{ #category : #private }
MalObjectTraverser >> doTraverse: anObject [
	"This method performs the actual traversal and markes the traversed objects.
	It uses two hooks for triggering custom behavior for each object,
	and each relation between two objects."

	(self isObjectAlreadyTraversed: anObject)
		ifTrue: [ ^ self ].
	self actOnObject: anObject.
	traversed add: anObject.
	self
		objectsToTraverseWithoutCollectionsFrom: anObject
		do: [ :each | 
			each
				ifNotNil: [ 
					self doTraverse: each.
					self actOnRelationFrom: each to: anObject ] ]
]

{ #category : #initialization }
MalObjectTraverser >> initialize [ 
	traversed := IdentitySet new
]

{ #category : #private }
MalObjectTraverser >> isObjectAlreadyTraversed: anEntity [
	^ self traversedObjects includes: anEntity
]

{ #category : #private }
MalObjectTraverser >> objectsToTraverseFrom: anObject do: aBlock [	
	^ self traversal objectsToTraverseFrom: anObject do: aBlock
]

{ #category : #private }
MalObjectTraverser >> objectsToTraverseWithoutCollectionsFrom: anObject do: aBlock [
	self objectsToTraverseFrom: anObject do: [ :eachObject |
		eachObject isCollection 
			ifTrue: [ 
					"we ignore collections"
					eachObject do: [ :each | 
						aBlock value: each.
						self 
							objectsToTraverseWithoutCollectionsFrom: each 
							do: aBlock ] ]
			ifFalse: [ aBlock value: eachObject ] ]
]

{ #category : #accessing }
MalObjectTraverser >> traversal [
	^ traversal
]

{ #category : #accessing }
MalObjectTraverser >> traversal: aBlock [
	traversal := aBlock
]

{ #category : #'public interface' }
MalObjectTraverser >> traverse: anObject [
	self doTraverse: anObject.
	^ self traversedObjects
]

{ #category : #accessing }
MalObjectTraverser >> traversedObjects [
	^ traversed
]
