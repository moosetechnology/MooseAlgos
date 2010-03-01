Extension { #name : #SequenceableCollection }

{ #category : #'*Moose-Algos-LinearAlgebra' }
SequenceableCollection >> hasSize: size [

	^ self size = size.
]

{ #category : #'*Moose-Algos-LinearAlgebra' }
SequenceableCollection class >> withSize: size [

	^ self new: size
]
