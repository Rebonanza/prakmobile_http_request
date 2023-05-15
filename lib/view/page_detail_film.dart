import 'package:flutter/material.dart';
import 'package:praktikum_pertemuan8_ifc/model/detail_film.dart';
import '../controller/api_data_source.dart';
import '../model/list_film.dart';

class DetailFilm extends StatefulWidget {
  final String? id;
  const DetailFilm({Key? key, required this.id}) : super(key: key);

  @override
  State<DetailFilm> createState() => _DetailFilmState();
}

class _DetailFilmState extends State<DetailFilm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Film"),
      ),
      body: _buildListUsersBody(),
    );
  }

  Widget _buildListUsersBody() {
    return Container(
      child: FutureBuilder(
        future: ApiDataSource.instance.getDetailFilm(widget.id),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            // Jika data ada error maka akan ditampilkan hasil error
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            // Jika data ada dan berhasil maka akan ditampilkan hasil datanya
            DetailFilms filmModel = DetailFilms.fromJson(snapshot.data);
            return _buildItemUsers(filmModel);
          }
          return _buildLoadingSection();
        },
      ),
    );
  }

  Widget _buildErrorSection() {
    return Text("Error");
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  // Widget _buildSuccessSection(DetailFilms filmModel) {
  //   return ListView.builder(
  //     itemCount: 1,
  //     itemBuilder: (BuildContext context, int index) {
  //       return _buildItemUsers(filmModel.search![index]);
  //     },
  //   );
  // }

  Widget _buildItemUsers(DetailFilms film) {
    return InkWell(
      onTap: () => {},
      child: Card(
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.Center,
          children: [
            Container(
              width: 100,
              child: Image.network(film.poster!),
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(film.title!),
                Text(film.year!),
                Text(film.plot!),
                Text(film.genre!)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
