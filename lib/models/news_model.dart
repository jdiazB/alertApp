class NewsModel {
  NewsModel({
    this.id,
    required this.link,
    required this.titulo,
    required this.fecha,
    required this.imagen,
  });

  int? id;
  String link;
  String titulo;
  DateTime fecha;
  String imagen;

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
    id: json["id"],
    link: json["link"]== null ? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT4NgAAqFP1fuNdQIuKlfFf9mn34Ot8UFMS73XEeF57&s":json["link"] ,
    titulo: json["titulo"],
    fecha: DateTime.parse(json["fecha"]),
    imagen: json["imagen"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "link": link,
    "titulo": titulo,
    "fecha": "${fecha.year.toString().padLeft(4, '0')}-${fecha.month.toString().padLeft(2, '0')}-${fecha.day.toString().padLeft(2, '0')}",
    "imagen": imagen,
  };
}