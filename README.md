# Slashdot-API
#### Custom built API for Slashdot

## Version 0.1

API for Archiving and accessing Slashdot Postings, associated metadata,
and URLS per posting.

Currently hosted at:
[slashdot-api.herokuapp.com](http:/slashdot-api.herokuapp.com)

## Features

Version 0.1.0 of Slashdot API contains basic metadata on
SlashdotPostings.  Author, Title, Permalinks, and most importantly
Associated Urls.

This Slashdot-API was built to serve the Discuss-It app and provide easy
access and searching of Slashdot Postings.

Slashdot does not have an API so results from Slashdot are aggregated
by our own API which scrapes the most recent postings and stores them
as listing objects in a database.

## API

Want to use our app for easy searching?

Slashdot API results can be conveniently accessed with a request to our slashdot_postings
page. All results are currently served up as JSON:
```
http://localhost:5000/slashdot_postings/search?url=http://singularityhub.com/2013/07/27/canvas-camera-brush-and-algorithms-enable-robot-artists-beautiful-paintings/
```

## Documentation

* [changelog](http://github.com/theoretick/slashdot-api/blob/master/CHANGELOG.md)
* [wiki](http://github.com/theoretick/slashdot-api/wiki)

## Created and maintained by

**theoretick** :: [github](https://github.com/theoretick), [twitter](https://twitter.com/theoretick)

**ericalthatcher** :: [github](https://github.com/ericalthatcher), [twitter](https://twitter.com/ericalthatcher)

**CodingAntecedent** :: [github](https://github.com/CodingAntecedent), [twitter](https://twitter.com/JohannBenedikt)


_Find a bug? Contributions welcome._

## License

See [LICENSE](http://github.com/theoretick/slashdot-api/blob/master/LICENSE) for the full license text.
