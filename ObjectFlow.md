#  Object Flow

This document is intended to serve as a means of understanding the composition of objects presented within this project.

# Composition

The basic composition is a basic Model-View-Controller architecture, which, from a top-level perspective, and defined within this project is, wherein '~>' denotes "is owned by":

`<Any Models>` ~>  `<GalleryControllerProtocol>` <~ `<GalleryViewProtocol>`

With respect to concrete classes used, there are two levels of ownership, described as:

`<M: Pokemon` ~> `<C: GalleryController>` <~   `<C: GalleryViewController>`

And for composition of networking components:

`<GalleryController>` <- `<PokeService>`

# Model Components

There are two types of models used:

1. a basic data-model represented by `Pokemon`, owned by `GalleryControllerProtocol` adopters.

2. models used to describe the complexities and requirements of the networking requests, `PSMonRequest` and `PSImageRequest`; created by `GalleryControllerProtocol` adopters and provided to `PokeService` for use.
