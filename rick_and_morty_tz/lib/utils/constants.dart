// ignore_for_file: constant_identifier_names

const String baseUrl = "https://rickandmortyapi.com/api/";
const String characterEndpoint = "${baseUrl}character";

// Success

const SUCCESS = 200;

// Errors
const USER_INVALID_RESPONSE = 100;
const NO_INTERNET = 101;
const INVALID_FORMAT = 102;
const UNKNOWN_ERROR = 103;


// Favourites
const String favouriteKey = 'favourite_characters';
const int maxFavourites = 8;