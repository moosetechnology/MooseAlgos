Class {
	#name : #MOGraphFixture,
	#superclass : #Object,
	#category : #'MooseAlgos-Graph-Tests'
}

{ #category : #fixtures }
MOGraphFixture class >> complexCycleGraph: builder [

	| nodes edges |
	nodes := $a to: $h.
	edges := #(($a $b) ($a $c) ($a $g) ($b $e) ($c $b) ($c $d) ($d $f) ($f $c) ($g $h) ($g $d) ($h $g)).

	builder nodes: nodes.
	builder edges: edges from: #first to: #second.
	^ builder
]

{ #category : #fixtures }
MOGraphFixture class >> complexWeightedGraph: builder [

	| nodes edges |
	nodes := $a to: $s.
	edges := #(($a $b 30) ($b $s 1) ($b $p 4) ($b $c 30) ($d $e 30) ($d $f 20) ($d $j 10) ($e $a 15) ($f $m 8) ($g $h 20) ($g $r 3) ($i $a 14) ($i $k 4) ($i $d 3) ($j $q 5) ($k $l 10) ($k $g 5) ($m $n 7) ($m $o 6) ($n $c 5) ($p $b 5) ($q $i 4)).

	builder nodes: nodes.
	builder edges: edges from: #first to: #second weight: #third.
	^ builder

]

{ #category : #fixtures }
MOGraphFixture class >> cycleGraph: builder [

	| nodes edges |
	nodes := $a to: $d.
	edges := #(($a $b) ($b $c) ($c $a) ($d $c)).

	builder nodes: nodes.
	builder edges: edges from: #first to: #second.
	^ builder
]

{ #category : #fixtures }
MOGraphFixture class >> dependencyGraph: builder [

	| nodes edges |
	nodes := $a to: $k.
	edges := #(($a $b) ($a $c) ($c $a) ($c $k) ($d $e) ($d $g) ($d $i) ($e $c) ($e $f) ($f $j) ($g $f) ($g $h) ($g $i) ($h $j)).

	builder nodes: nodes.
	builder edges: edges from: #first to: #second.
	^ builder
]

{ #category : #fixtures }
MOGraphFixture class >> nestedCycleGraph: builder [

	| nodes edges |
	nodes := $a to: $i.
	edges := #(($a $b) ($b $c) ($c $d) ($d $e) ($e $a) ($b $e) ($e $b) ($e $f) ($f $g) ($g $h) ($h $f) ($g $i) ($i $g)).

	builder nodes: nodes.
	builder edges: edges from: #first to: #second.
	^ builder	

]

{ #category : #fixtures }
MOGraphFixture class >> simpleGraph: builder [

	| nodes edges |
	nodes := $a to: $d.
	edges := #(($a $b) ($b $c) ($d $c)).

	builder nodes: nodes.
	builder edges: edges from: #first to: #second.
	^ builder

]

{ #category : #fixtures }
MOGraphFixture class >> simpleWeightedGraph: builder [

	| nodes edges |
	nodes := 1 to: 5.
	edges := #((1 2 5) (1 3 4) (2 3 2) (3 4 5) (2 4 3) (4 5 1) (5 1 2) (1 5 3)).

	builder nodes: nodes.
	builder edges: edges from: #first to: #second weight: #third.
	^ builder

]
