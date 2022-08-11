<a name="readme-top"></a>

<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/ktbatou/xkcd_App">
    <img src="https://docs.google.com/uc?export=download&id=1rLIEGga7rSnvRsoTkJvbrskloYYKIn4m" alt="Logo">
  </a>

<h2 align="left">Xkcd  Comics Application</h2>
</br>
<!-- PROJECT LOGO -->


  <p align="left">
   <a href= "https://xkcd.com/">xkcd</a> Application to navigate across comics and get their explanation.  
   </p>
   
   [![made-with-flutter](https://img.shields.io/badge/Made%20with-Flutter-1f425f.svg)](https://flutter.dev/)  
   
</br>



<!-- ABOUT THE PROJECT -->
## Demo



<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- Features -->
## Features

-	browse through the comics.
-   see the comic details, including its description.
-   search for comics by the comic number.
-   get the comic explanation
-   favorite the comics, which would be available offline too,
-   send comics to others.
-   support multiple form factors.
### Additional Features
- Cache browsed comics for off-line availability.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- Plugins -->
## Plugins


Plugin | Usage
------------ | -------------
[internet_connection_checker](https://pub.dev/packages/internet_connection_checker) | For determining if a data connection is actually available.
[connectivity_plus](https://pub.dev/packages/connectivity_plus) | For listening to network state changes
[cached_network_image](https://pub.dev/packages/cached_network_image) | For displaying and caching comics images
[shared_preferences](https://pub.dev/packages/shared_preferences) | For caching comics and other data.
[pinch_zoom](https://pub.dev/packages/pinch_zoom) |for making comic's images pich zooming
[infinite_scroll_pagination](https://pub.dev/packages/infinite_scroll_pagination) | For implementing infinite scroll
[skeletons](https://pub.dev/packages/skeletons) | For skeleton widgets to mimic the image's layout while loading.
[share_plus](https://pub.dev/packages/intl) | for sharing comic.
[http](https://pub.dev/packages/http) | for http requests.
[html](https://pub.dev/packages/html) | for parsing html5 text.
[dartz](https://pub.dev/packages/dartz) | For using Either.
[provider](https://pub.dev/packages/provider) | for state management.
[mockito](https://pub.dev/packages/mockito) | mocking abstarct classes impls for test.
[build_runner](https://pub.dev/packages/build_runner) | For mockito's generated mock classes
[equatable](https://pub.dev/packages/equatable) | 

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!--  Directory Structure -->

## Directory Structure
<details>
 <summary>Click to spand</summary>
 
```
├── core
│   ├── error
│   ├── functions
│   ├── network
│   ├── page
│   └── provider
├── features
│   ├── comic_explanation
│   │   ├── data
│   │   │   ├── datasources
│   │   │   ├── models
│   │   │   └── repositories
│   │   ├── domain
│   │   │   ├── entities
│   │   │   ├── repositories
│   │   │   └── usecases
│   │   └── presentation
│   │       ├── pages
│   │       ├── provider
│   │       └── widgets
│   ├── comics_feed
│   │   ├── data
│   │   │   ├── datasources
│   │   │   ├── models
│   │   │   └── repositories
│   │   ├── domain
│   │   │   ├── entities
│   │   │   ├── repositories
│   │   │   └── usecases
│   │   └── presentation
│   │       ├── pages
│   │       ├── provider
│   │       └── widgets
│   ├── favorite_comics
│   │   ├── data
│   │   │   ├── datasources
│   │   │   ├── models
│   │   │   └── repositories
│   │   ├── domain
│   │   │   ├── entities
│   │   │   ├── repositories
│   │   │   └── usecases
│   │   └── presentation
│   │       ├── pages
│   │       ├── provider
│   │       └── widgets
│   └── search
│       ├── data
│       │   ├── datasources
│       │   ├── models
│       │   └── repositories
│       ├── domain
│       │   ├── entities
│       │   ├── repositories
│       │   └── usecases
│       └── presentation
│           ├── pages
│           ├── provider
│           └── widgets
└── test
    ├── core
    │   └── fixtures
    └── features
        └── comics_feed
            ├── data
            │   ├── datasources
            │   └── model
            └── domain
                └── usecases
```
</details>
<p align="right">(<a href="#readme-top">back to top</a>)</p>


<!-- GETTING STARTED -->

##  Getting Started

###  Prerequisites
  If you don't have Flutter SDK installed, please visit official  [Flutter](https://flutter.dev/)  site.
###  Installation

* Clone this repository :

```sh

	git clone https://github.com/ktbatou/xkcd_App.git

```

* Run the app with Android Studio or VS Code. Or the command line:

```sh
	flutter clean
	flutter pub get
	flutter run
```

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- Realease -->
## Release

Please download apk from  [Releases](https://github.com/ktbatou/xkcd_App/releases) 

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- CONTACT -->
## Contact

Don't hesitate to visite my <strong>[Portfolio](https://ktbatou.tech/)</strong>.
[![twitter][twitter-shield]][twitter-url]
[![LinkedIn][linkedin-shield]][linkedin-url]

  ### Don't forget to :star: the repo

<p align="right">(<a href="#readme-top">back to top</a>)</p>


<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->

[twitter-shield]: 
https://img.shields.io/badge/Twitter-1DA1F2?style=for-the-badge&logo=twitter&logoColor=white
[twitter-url]: https://twitter.com/Kaoutar_TBATOU

[linkedin-shield]: https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white
[linkedin-url]: https://www.linkedin.com/in/ktbatou/

