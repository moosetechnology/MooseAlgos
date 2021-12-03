# MooseAlgos

Moose Algos contains generic libraries for various analysis algorithms.

## Install MooseAlgos

To install MooseAlgos on your Pharo image you can just execute the following script:

```Smalltalk
Metacello new
    githubUser: 'moosetechnology' project: 'MooseAlgos' commitish: 'master' path: 'src';
    baseline: 'MooseAlgos';
    load
```

To add MooseAlgos to your baseline just add this:

```Smalltalk
    spec
    	baseline: 'MooseAlgos'
    	with: [ spec repository: 'github://moosetechnology/MooseAlgos:master/src' ]
```

Note that you can replace the #master by another branch as #development or a tag as #v1.0.0, #v1.? or #v1.2.? .

## Clustering

see https://en.wikipedia.org/wiki/Hierarchical_clustering

- [complete linkage](https://en.wikipedia.org/wiki/Complete-linkage_clustering)
- single linkage
- average linkage
- centroid
- [Wards method](https://en.wikipedia.org/wiki/Ward%27s_method)

### Example:
```Smalltalk
input := #(#(1 2 3 5) #(11 12 15) #(21 22 23 25) #(31 32 35) #(41 42 43 45 47)).
clusty := MalClusterEngine with: input flatten shuffle.
clusty hierarchicalClusteringUsing: #centroid.
clusters := clusty dendrogram breakInto: 5.
```

## Word compacting

### Example:
```Smalltalk
(MalKontractor reduce: 'Hello' upTo: 3) >>> 'Hlo'
```

## Linear algebra

- operations with matrices

## Version management

This project use semantic versionning to define the releases. This mean that each stable release of the project will get associate a version number of the form `vX.Y.Z`.

- **X** define the major version number
- **Y** define the minor version number
- **Z** define the patch version number

When a release contains only bug fixes, the patch number increase. When the release contains new features backward compatibles, the minor version increase. When the release contains breaking changes, the major version increase.

Thus, it should be safe to depend on a fixed major version and moving minor version of this project.
