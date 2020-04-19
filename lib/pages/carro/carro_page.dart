import 'package:cached_network_image/cached_network_image.dart';
import 'package:carros/pages/carro/loripsum_api.dart';
import 'package:carros/pages/favoritos/favorito_service.dart';
import 'package:carros/widgets/text.dart';
import 'package:carros/widgets/text_error.dart';
import 'package:flutter/material.dart';

import 'carro.dart';

class CarroPage extends StatefulWidget {
  Carro carro;

  CarroPage(this.carro);

  @override
  _CarroPageState createState() => _CarroPageState();
}

class _CarroPageState extends State<CarroPage> {
  final _loripsumApiBloc = LoripsumBloc();

  IconData icon = Icons.favorite_border;
  Color color = Colors.grey;

  bool favorito = false;

  Carro get carro => widget.carro;

  @override
  void initState() {
    super.initState();

    _loripsumApiBloc.fetch();

    FavoritoService.isFavorito(carro).then((favorito) {
      setState(() {
        color = favorito ? Colors.red : Colors.grey;
        icon = favorito ? Icons.favorite : Icons.favorite_border;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.carro.nome),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.place), onPressed: _onClickMapa),
          IconButton(icon: Icon(Icons.videocam), onPressed: _onClickVideo),
          PopupMenuButton(
              onSelected: (String value) => _onClickPopupMenu(value),
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    value: "Editar",
                    child: Text("Editar"),
                  ),
                  PopupMenuItem(
                    value: "Deletar",
                    child: Text("Deletar"),
                  ),
                  PopupMenuItem(
                    value: "Share",
                    child: Text("Share"),
                  ),
                ];
              })
        ],
      ),
      body: _body(),
    );
  }

  _body() {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView(
        children: <Widget>[
          CachedNetworkImage(imageUrl: widget.carro.urlFoto),
          _bloco1(),
          Divider(),
          _bloco2(),
        ],
      ),
    );
  }

  Row _bloco1() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            text(
              widget.carro.nome,
              fontSize: 20,
              bold: true,
            ),
            text(
              widget.carro.tipo,
              fontSize: 16,
            ),
          ],
        ),
        Row(
          children: <Widget>[
            IconButton(
                icon: Icon(
                  icon,
                  color: color,
                  size: 40,
                ),
                onPressed: _onClickFavorito),
            IconButton(
                icon: Icon(
                  Icons.share,
                  size: 40,
                ),
                onPressed: _onClickShare)
          ],
        ),
      ],
    );
  }

  void _onClickMapa() {}

  void _onClickVideo() {}

  _onClickPopupMenu(String value) {
    switch (value) {
      case "Editar":
        print("Editar");
        break;

      case "Deletar":
        print("Deletar");
        break;

      case "Share":
        print("Share");
        break;
    }
  }

  void _onClickFavorito() async {
    bool favorito = await FavoritoService.favoritar(carro);

    setState(() {
      color = favorito ? Colors.red : Colors.grey;
      icon = favorito ? Icons.favorite : Icons.favorite_border;
    });

  }

  void _onClickShare() {}

  _bloco2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        text(widget.carro.descricao, fontSize: 16, bold: true),
        SizedBox(
          height: 20,
        ),
        StreamBuilder<String>(
            stream: _loripsumApiBloc.stream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return TextError("Não foi possível acessar a api");
              }

              return Text(
                snapshot.data,
                style: TextStyle(
                  fontSize: 16,
                ),
              );
            }),
      ],
    );
  }
}
