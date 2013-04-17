Class {
	#name : #MalHgUtilities,
	#superclass : #Object,
	#instVars : [
		'cache'
	],
	#classInstVars : [
		'instance'
	],
	#category : #'Moose-Algos-HierarchicalGraph'
}

{ #category : #accessing }
MalHgUtilities class >> flush [
	instance := nil.
]

{ #category : #accessing }
MalHgUtilities class >> instance [
	instance isNil ifTrue: [
		instance := self new.
	].

	^ instance.
]

{ #category : #cache }
MalHgUtilities >> cache [
	"General purpose cache."
	cache isNil ifTrue: [
		cache := Dictionary new.
	].

	^ cache.
]

{ #category : #math }
MalHgUtilities >> chooseLinearGrowthEquation: weightExtrema sizeExtrema: sizeExtrema [
	
	"Use normal linear equation if we have negative weights"
	(weightExtrema x < 0 or: weightExtrema y < 0) ifTrue: [
		^ self linearGrowthEquation: weightExtrema sizeExtrema: sizeExtrema.
	].
	
	"Else use a squared linear equation, which smoothes-out outliers."
	 ^ self linearGrowthEquationSquared: weightExtrema sizeExtrema: sizeExtrema.
]

{ #category : #math }
MalHgUtilities >> chooseLinearGrowthEquationSquared: weightExtrema sizeExtrema: sizeExtrema [
	
	"Use normal linear equation if we have negative weights"
	(weightExtrema x < 0 or: weightExtrema y < 0) ifTrue: [
		^ self linearGrowthEquation: weightExtrema sizeExtrema: (self nodeSizeRange).
	].
	
	"Else use a squared linear equation, which smoothes-out outliers."
	 ^ self linearGrowthEquationSquared: weightExtrema sizeExtrema: (self nodeSizeRange).
]

{ #category : #cache }
MalHgUtilities >> flushCache [
	"Flush the general purpose cache."
	cache := nil.
]

{ #category : #math }
MalHgUtilities >> linearGrowthEquation: weightExtrema sizeExtrema: sizeExtrema [
	"Returns a linear function which can be used to calculate a certain size for a given weight,
	based on given extremas (as Points) of weight and size.
	The linear function returns a float that has been rounded to a precision of 0.001.
	
	We need to solve for m and b in y = mx + b so we can
	return length = m*weight + b."
	| minPoint maxPoint m b dy dx |

	minPoint := (weightExtrema x)@(sizeExtrema x).
	maxPoint := (weightExtrema y)@(sizeExtrema y).
	
	dy := (maxPoint y - minPoint y).
	dx := (maxPoint x - minPoint x).
	
	m := dy / dx.
	b :=  (-1 * m *  (maxPoint x)) + (maxPoint y).

	^  [ :weight | self makeNumber: ((m * weight + b) roundTo: 0.001 asFloat) between: sizeExtrema x and: sizeExtrema y ].
]

{ #category : #math }
MalHgUtilities >> linearGrowthEquationSquared: weightExtrema sizeExtrema: sizeExtrema [
	"Returns a linear function which can be used to calculate a certain size for a given weight,
	based on given extremas (as Points) of weight and size.
	The linear function returns a float that has been rounded to a precision of 0.001.
	
	This method squares extremas and square roots the results which smoothens the size curve.
	It only works with positive weight and size extrema!
	
	We need to solve for m and b in y = mx + b so we can
	return length = m*weight + b."
	| minPoint maxPoint m b dy dx |
	
	self assert: (weightExtrema x >= 0) description: 'weightExtrema can not be negative in a squared linear equation.'.
	self assert: (weightExtrema y >= 0) description: 'weightExtrema can not be negative in a squared linear equation.'.
	self assert: (sizeExtrema x >= 0) description: 'sizeExtrema can not be negative in a squared linear equation.'.
	self assert: (sizeExtrema y >= 0) description: 'sizeExtrema can not be negative in a squared linear equation.'.

	minPoint := (weightExtrema x squared)@(sizeExtrema x squared).
	maxPoint := (weightExtrema y squared)@(sizeExtrema y squared).
	
	dy := (maxPoint y - minPoint y).
	dx := (maxPoint x - minPoint x).
	
	m := dy / dx.
	b :=  (-1 * m *  (maxPoint x)) + (maxPoint y).

	^  [ :weight | 
		| result safeWeight |
    		safeWeight := weight.
    		(safeWeight < weightExtrema x) ifTrue: [ safeWeight := weightExtrema x].
    		(safeWeight > weightExtrema y) ifTrue: [ safeWeight := weightExtrema y].
    		result := (m * safeWeight squared + b).
    		result < 0 ifTrue: [
      		result := result * -1.
     			 result := (result sqrt * -1 roundTo: 0.001) asFloat.
   		 ] ifFalse: [
     			 result := (result sqrt roundTo: 0.001) asFloat.
   		 ].
    		self makeNumber: result between: sizeExtrema x and: sizeExtrema y "A dirty trick... :("
	 ].
]

{ #category : #math }
MalHgUtilities >> makeNumber: aNumber between: min and: max [
	aNumber < min ifTrue: [ ^ min ].
	aNumber > max ifTrue: [ ^ max ].
	^ aNumber.

]

{ #category : #cache }
MalHgUtilities >> removeFromCache: aKey [
	(cache includesKey: aKey) ifTrue: [
		cache removeKey: aKey.
		^ true. "Removed entry with given key"
	].
	^ false. "Nothing removed"
]
