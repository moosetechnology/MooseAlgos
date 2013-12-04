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
		'firstObjectAction',
		'toTraverse'
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

{ #category : #private }
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
	It does not make use of recursion to limit problems related to the stack
	when traversing large graphs.
	The logic ignores collections and nil.
	It uses two hooks for triggering custom behavior for each object,
	and each relation between two objects."
	| currentObject |

	toTraverse := OrderedCollection with: anObject.

	 [ toTraverse isEmpty ] whileFalse: [
			currentObject := toTraverse removeFirst.
			traversed add: currentObject.
			self
				objectsToTraverseWithoutCollectionsFrom: currentObject
				do: [ :each | 
					( self shouldTraverse: each ) ifTrue: [ 
								toTraverse add: each.
								self actOnObject: each.
								self actOnRelationFrom: currentObject to: each ] ] ] 
]

{ #category : #accessing }
MalTraverser >> firstObjectAction [
	^ firstObjectAction
]

{ #category : #accessing }
MalTraverser >> firstObjectAction: anAction [
	firstObjectAction := anAction
]

{ #category : #initialization }
MalTraverser >> initialize [ 
	traversed := IdentitySet new.
	toTraverse := OrderedCollection new. "the order of the objects to traverse matters"
	action := MalNullActionStrategy new.
	firstObjectAction := MalNullActionStrategy new
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

{ #category : #private }
MalTraverser >> shouldTraverse: anObject [
	^ anObject notNil and: [
		(traversed includes: anObject) not and: [ 
			(toTraverse includes: anObject) not ] ]
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
