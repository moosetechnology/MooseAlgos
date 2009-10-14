Extension { #name : #Number }

{ #category : #'*moosealgos-linearalgebra' }
Number >> quotientFromVector: aVector [

	^aVector collect: [ :a | a / self ]
]
