import 'package:flutter/material.dart';
import '/controllers/movie_controller.dart';
import '/models/movie.dart';
import '/widgets/bottom_nav.dart';
import '/widgets/modal.dart';

class MovieView extends StatefulWidget {
  MovieView({super.key});

  @override
  State<MovieView> createState() => _MovieViewState();
}

class _MovieViewState extends State<MovieView> {
  MovieController movie = MovieController();
  TextEditingController titleInput = TextEditingController();
  TextEditingController gambarInput = TextEditingController();
  TextEditingController voteAverage = TextEditingController();
  TextEditingController deskripsiInput = TextEditingController();
  TextEditingController stock = TextEditingController();
  TextEditingController penerbitInput = TextEditingController();
  TextEditingController pengarangInput = TextEditingController();
  final formKey = GlobalKey<FormState>();
  ModalWidget modal = ModalWidget();

  List<String> listAct = ["Ubah", "Hapus"];
  List<Movie>? film;
  int? film_id;
  getFilm() {
    setState(() {
      film = movie.movie;
    });
  }

  addFilm(data) {
    film!.add(data);
    getFilm();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFilm();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Perpustakaan"),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  film_id = null;
                });
                titleInput.text = '';
                gambarInput.text = '';
                voteAverage.text = '';
                deskripsiInput.text = '';
                penerbitInput.text = '';
                pengarangInput.text = '';
                stock.text = '';
                modal.showFullModal(context, fromTambah(null));
              },
              icon: Icon(Icons.add_sharp))
        ],
      ),
      body: film != null
          ? ListView.builder(
              padding: EdgeInsets.all(12),
              itemCount: film!.length,
              itemBuilder: (context, index) {
                return Card(
                    child: ListTile(
                  leading: Image(
                    image: AssetImage(film![index].posterPath),
                  ),
                  title: Column(
                    children: [
                        Text(film![index].title),
                        Row(
                          children: [
                            Text("Rating: " + film![index].voteAverage.toString()),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Deskripsi: " + film![index].deskripsi),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Stock: " + film![index].stock.toString()),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Penerbit: " + film![index].penerbit),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Pengarang: " + film![index].pengarang),
                          ],
                        ),
                    ],
                  ),
                  trailing: PopupMenuButton<String>(
                    icon: const Icon(
                      Icons.more_vert,
                      color: Color.fromARGB(255, 0, 0, 0),
                      size: 30.0,
                    ),
                    // onSelected: choiceAction,
                    itemBuilder: (BuildContext context) {
                      return listAct.map((String choice) {
                        return PopupMenuItem<String>(
                          value: choice,
                          child: Text(choice),
                          onTap: () {
                            if (choice == "Ubah") {
                              setState(() {
                                film_id = film![index].id;
                              });

                              titleInput.text = film![index].title;
                              gambarInput.text = film![index].posterPath;
                              deskripsiInput.text = film![index].deskripsi;
                              stock.text = film![index].stock.toString();
                              penerbitInput.text = film![index].penerbit;
                              pengarangInput.text = film![index].pengarang;
                              voteAverage.text =
                                  film![index].voteAverage.toString();
                      
                              modal.showFullModal(context, fromTambah(index),); 
                            } else if (choice == "Hapus") {
                              film!.removeWhere(
                                  (item) => item.id == film![index].id);
                              getFilm();
                            }
                          },
                        );
                      }).toList();
                    },
                  ),
                ));
              })
          : Text("Data Kosong"),
      bottomNavigationBar: BottomNav(2),
    );
  }

  Widget fromTambah(index) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          Text("Tambah Data"),
          TextFormField(
            controller: titleInput,
            decoration: InputDecoration(label: Text("Title")),
            validator: (value) {
              if (value!.isEmpty) {
                return 'harus diisi';
              } else {
                return null;
              }
            },
          ),
          TextFormField(
            controller: gambarInput,
            decoration: InputDecoration(label: Text("Gambar")),
            validator: (value) {
              if (value!.isEmpty) {
                return 'harus diisi';
              } else {
                return null;
              }
            },
          ),
          TextFormField(
            controller: voteAverage,
            decoration: InputDecoration(label: Text("VoteAverage")),
            validator: (value) {
              if (value!.isEmpty) {
                return 'harus diisi';
              } else {
                return null;
              }
            },
          ),
            TextFormField(
            controller: deskripsiInput,
            decoration: InputDecoration(label: Text("Deskripsi")),
            validator: (value) {
              if (value!.isEmpty) {
              return 'harus diisi';
              } else {
              return null;
              }
            },
            ),
            TextFormField(
            controller: stock,
            decoration: InputDecoration(label: Text("Stock")),
            validator: (value) {
              if (value!.isEmpty) {
              return 'harus diisi';
              } else {
              return null;
              }
            },
            ),
            TextFormField(
            controller: penerbitInput,
            decoration: InputDecoration(label: Text("Penerbit")),
            validator: (value) {
              if (value!.isEmpty) {
              return 'harus diisi';
              } else {
              return null;
              }
            },
            ),
            TextFormField(
            controller: pengarangInput,
            decoration: InputDecoration(label: Text("Pengarang")),
            validator: (value) {
              if (value!.isEmpty) {
              return 'harus diisi';
              } else {
              return null;
              }
            },
            ),
          ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  if (index != null) {
                    film![index].id = film_id!;
                    film![index].title = titleInput.text;
                    film![index].posterPath = gambarInput.text;
                    film![index].voteAverage = double.parse(voteAverage.text);
                    film![index].title = titleInput.text;
                    film![index].stock = int.parse(stock.text);
                    film![index].deskripsi = deskripsiInput.text;
                    film![index].penerbit = penerbitInput.text;
                    film![index].pengarang = pengarangInput.text;
                    
                    getFilm();
                  } else {
                    film_id = film!.length + 1;
                    Movie data = Movie(
                      id: film_id!,
                      title: titleInput.text,
                      posterPath: gambarInput.text,
                      voteAverage: double.parse(voteAverage.text),
                      deskripsi: deskripsiInput.text,
                      stock: int.parse(stock.text),
                      penerbit: penerbitInput.text,
                      pengarang: pengarangInput.text,
                    );
                    addFilm(data);
                  }
                  Navigator.pop(context);
                }
              },
              child: Text("Simpan"))
        ],
      ),
    );
  }
}
