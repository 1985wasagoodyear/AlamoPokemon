#  AlamoPokemon

##### Date created: November 10, 2019

This toy App is meant to demonstrate the networking and boilerplate abstractions that are given in Alamofire, as well as provide a sample of using such high-level descriptions.

To do so, this application uses [PokéAPI](https://pokeapi.co/), which contains 
>All the Pokémon data you'll ever need in one place, easily accessible through a modern RESTful API.


## Objectives:

1. To demonstrate an effective use of Alamofire.
2. To depthfully provide an adequate use-case for this framework beyond being "a wrapper around URLSession", which is the worst use of this framework.
3. To use Alamofire as a high-level description.
4. To leverage at least one advantageous benefit in Alamofire, of which the equivalent means to do so would consume a cumbersome amount of time to develop, test, and adequately scale for use.


## To use:

This project uses the following dependencies:

* `Alamofire`
* `MBProgressHUD`

And installs these dependencies via CocoaPods. Please be sure to perform  `pod install` before usage.


## Details of Implementation:

1. Handles network status changes using Apple's Reachability framework, in `GalleryController`, with the `NetworkReachabilityManager`.
2. Wraps and gives an easier means of abstracting the networking details in  `PokeService` in `requestPokemon:request:completion`.
3. Describing Model objects for networking responses with `PSMonRequest` and `PSImageRequest`.


## Future Adjustments:

1. Customize session used for Alamofire.
2. Describe model objects for networking requests.
3. Set up routing/retry handling for min-X tries for any failed download attempts with Alamofire.


## Resources:

1. [Alamofire](https://github.com/Alamofire/Alamofire)
2. [PokéAPI](https://pokeapi.co/)
