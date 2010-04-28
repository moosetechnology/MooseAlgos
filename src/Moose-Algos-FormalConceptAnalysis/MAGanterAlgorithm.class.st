Class {
	#name : #MAGanterAlgorithm,
	#superclass : #Object,
	#instVars : [
		'context',
		'attributesMask',
		'objectsMask'
	],
	#category : #'Moose-Algos-FormalConceptAnalysis'
}

{ #category : #'instance creation' }
MAGanterAlgorithm class >> on: formalContext [
	
	^self basicNew on: formalContext
]

{ #category : #accessing }
MAGanterAlgorithm >> allConcepts [
	
	| intent |
	^self findExtents
		collect:
			[:extent | 
			intent := self commonAttributesOf: extent.
			MAFormalConcept on: context extent: extent intent: intent]
]

{ #category : #algorithm }
MAGanterAlgorithm >> closureFor: objectMask [
	
	^self commonObjectsOf: (self commonAttributesOf: objectMask)
]

{ #category : #algorithm }
MAGanterAlgorithm >> commonAttributesOf: objectMask [
	
	| mask |
	mask := attributesMask.
	objectMask
		bitMaskDo:
			[:index | mask := mask bitAnd: (context objects at: index) bits].
	^mask
]

{ #category : #algorithm }
MAGanterAlgorithm >> commonObjectsOf: attributeMask [
	
	| mask |
	mask := objectsMask.
	attributeMask
		bitMaskDo:
			[:index | mask := mask bitAnd: (context attributes at: index) bits].
	^mask
]

{ #category : #algorithm }
MAGanterAlgorithm >> findExtents [
	
	| extents |
	self setUp.
	extents := "ArrayList" OrderedCollection  with: 0.
	[extents last = objectsMask]
		whileFalse: [extents add: (self findNextExtent: extents last)].
	^extents
]

{ #category : #algorithm }
MAGanterAlgorithm >> findNextExtent: extent [
	
	context objects size
		to: 1
		by: -1
		do:
			[:index | 
			| nextExtent |
			nextExtent := self closureFor: (extent copyUpToPlusIndex: index).
			(nextExtent upToPlusIndex: index isLargerThan: extent)
				ifTrue: [^nextExtent]].
	self error: nil
]

{ #category : #'initialize-release' }
MAGanterAlgorithm >> on: formalContext [
	
	context := formalContext
]

{ #category : #algorithm }
MAGanterAlgorithm >> setUp [
	
	attributesMask := Integer maskTrue: context attributes size.
	objectsMask := Integer maskTrue: context objects size
]
