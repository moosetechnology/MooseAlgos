"
The traverser has three responsibilities:
1. traverse objects,
2. mark traversed objects,
3. trigger actions for each traversed object and each relation between two traversed objects

1. is handled via  the MalObjectTraversal hierarchy
2. is the responsibility of the traverse itself
3. is handled by the MalObjectAction hierarchy
"
Class {
	#name : #MalTraverser,
	#superclass : #Object,
	#instVars : [
		'traversed',
		'traversal',
		'action',
		'firstObjectAction'
	],
	#category : #'Moose-Algos-ObjectTraverser'
}

{ #category : #'instance creation' }
MalTraverser class >> withCustomTraversal: aBlock [
	"we provide a utility method for handling block traversals
	given that this is likely to be the most common use case"
	^ self new 
		traversal: (MalCustomTraversal with: aBlock)
]

{ #category : #'as yet unclassified' }
MalTraverser >> actOnFirstObject: anObject [
	^ firstObjectAction executeOnObject: anObject
]

{ #category : #private }
MalTraverser >> actOnObject: anObject [
	^ action executeOnObject: anObject
]

{ #category : #private }
MalTraverser >> actOnRelationFrom: originObject to: targetObject [
	
	^ self action executeOnRelationFrom: originObject to: targetObject
]

{ #category : #accessing }
MalTraverser >> action [
	^ action
]

{ #category : #accessing }
MalTraverser >> action: anAction [
	action := anAction
]

{ #category : #private }
MalTraverser >> doTraverse: anObject [
	"This method performs the actual traversal and markes the traversed objects.
	The logic ignores collections and nil.
	It uses two hooks for triggering custom behavior for each object,
	and each relation between two objects."
	traversed add: anObject.
	self
		objectsToTraverseWithoutCollectionsFrom: anObject
		do: [ :each | 
			(each isNil or: [ self isObjectAlreadyTraversed: each ])
					ifFalse: [ 
						self actOnObject: each.
						self doTraverse: each.
						self actOnRelationFrom: anObject to: each ] ]
]

{ #category : #'as yet unclassified' }
MalTraverser >> firstObjectAction [
	^ firstObjectAction
]

{ #category : #'as yet unclassified' }
MalTraverser >> firstObjectAction: anAction [
	firstObjectAction := anAction
]

{ #category : #initialization }
MalTraverser >> initialize [ 
	traversed := IdentitySet new.
	action := MalNullActionStrategy new.
	firstObjectAction := MalNullActionStrategy new
]

{ #category : #private }
MalTraverser >> isObjectAlreadyTraversed: anEntity [
	^ self traversedObjects includes: anEntity
]

{ #category : #private }
MalTraverser >> objectsToTraverseFrom: anObject do: aBlock [	
	^ self traversal objectsToTraverseFrom: anObject do: aBlock
]

{ #category : #private }
MalTraverser >> objectsToTraverseWithoutCollectionsFrom: anObject do: aBlock [
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
MalTraverser >> traversal [
	^ traversal
]

{ #category : #accessing }
MalTraverser >> traversal: aBlock [
	traversal := aBlock
]

{ #category : #'public interface' }
MalTraverser >> traverse: anObject [
	"This is the main public method that
	starts the traversal and associated logic"
	self actOnFirstObject: anObject.
	self doTraverse: anObject.
	^ self traversedObjects
]

{ #category : #accessing }
MalTraverser >> traversedObjects [
	^ traversed
]
