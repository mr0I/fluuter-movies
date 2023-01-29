import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../movie/movie_provider.dart';

class EditMovieScreen extends StatefulWidget {
  static const routeName = './edit-movie';

  @override
  State<EditMovieScreen> createState() => _EditMovieScreenState();
}

class _EditMovieScreenState extends State<EditMovieScreen> {
  final _priceFocus = FocusNode();
  final _descriptionFocus = FocusNode();
  final _imageUrlFocus = FocusNode();
  final _imageUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();

  var _editedMovie = Movie(
    id: null,
    title: '',
    poster: '',
    year: 0,
  );

  var _isInit = true;
  var _initValues = {
    'title': '',
    'poster': '',
    'year': '',
  };

  @override
  void initState() {
    _imageUrlFocus.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final movieId = ModalRoute.of(context).settings.arguments as String;
      if (movieId != null) {
        _editedMovie =
            Provider.of<Movies>(context, listen: false).findById(movieId);
        _initValues = {
          'title': _editedMovie.title,
          'poster': '',
          'year': _editedMovie.year.toString(),
        };
        _imageUrlController.text = _editedMovie.poster;
      }
    }

    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageUrlFocus.removeListener(_updateImageUrl);
    _priceFocus.dispose();
    _descriptionFocus.dispose();
    _imageUrlFocus.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocus.hasFocus) {
      if ((!_imageUrlController.text.startsWith('http') &&
              !_imageUrlController.text.startsWith('https')) ||
          (!_imageUrlController.text.endsWith('png') &&
              !_imageUrlController.text.endsWith('jpg') &&
              !_imageUrlController.text.endsWith('jpeg'))) {
        return;
      }

      setState(() {});
    }
  }

  void _submitForm() {
    final isValid = _form.currentState.validate();
    if (!isValid) return;
    _form.currentState.save();
    print(_editedMovie.toJson());
    if (_editedMovie.id != null) {
      Provider.of<Movies>(context, listen: false)
          .updateMovie(_editedMovie.id, _editedMovie);
    } else {
      Provider.of<Movies>(context, listen: false).addMovie(_editedMovie);
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Movie'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _submitForm,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
              TextFormField(
                initialValue: _initValues['title'],
                decoration: InputDecoration(labelText: 'title'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocus);
                },
                validator: (value) {
                  if (value.isEmpty) return 'Please provide some value';
                  return null;
                },
                onSaved: (value) {
                  _editedMovie = Movie(
                    id: _editedMovie.id,
                    isFavorite: _editedMovie.isFavorite,
                    title: value,
                    poster: _editedMovie.poster,
                    year: _editedMovie.year,
                  );
                },
              ),
              TextFormField(
                  initialValue: _initValues['year'],
                  decoration: InputDecoration(labelText: 'price'),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  focusNode: _priceFocus,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_descriptionFocus);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please provide some value';
                    } else if (double.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    } else if (double.parse(value) <= 0) {
                      return 'Please enter a number grater than zero';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _editedMovie = Movie(
                      id: _editedMovie.id,
                      isFavorite: _editedMovie.isFavorite,
                      title: _editedMovie.title,
                      poster: _editedMovie.poster,
                      year: double.parse(value),
                    );
                  }),
              TextFormField(
                decoration: InputDecoration(labelText: 'description'),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                focusNode: _descriptionFocus,
                // onSaved: (value) {
                //   _editedMovie = Movie(
                //     id: null,
                //     title: _editedMovie.title,
                //     poster: _editedMovie.poster,
                //     year: _editedMovie.year,
                //   );
                // },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(top: 8, right: 10),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                    ),
                    child: _imageUrlController.text.isEmpty
                        ? Text('Enter image URL!')
                        : FittedBox(
                            child: Image.network(_imageUrlController.text),
                            fit: BoxFit.cover,
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                        decoration: InputDecoration(labelText: 'Image URL'),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        controller: _imageUrlController,
                        focusNode: _imageUrlFocus,
                        onFieldSubmitted: (_) {
                          _submitForm();
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please provide some value';
                          } else if (!value.startsWith('http') &&
                              !value.startsWith('https')) {
                            return 'Please enter a valid url';
                          } else if (!value.endsWith('png') &&
                              !value.endsWith('jpg') &&
                              !value.endsWith('jpeg')) {
                            return 'Please enter a valid format';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _editedMovie = Movie(
                            id: _editedMovie.id,
                            isFavorite: _editedMovie.isFavorite,
                            title: _editedMovie.title,
                            poster: value,
                            year: _editedMovie.year,
                          );
                        }),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
