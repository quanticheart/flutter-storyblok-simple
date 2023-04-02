import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Fetch?> fetchStory(String name) async {
  var url = Uri.https('api.storyblok.com', '/v1/cdn/stories/$name',
      {'token': '----', 'version': 'draft'});

  final http.Response response = await http.get(url);

  if (response.statusCode == 200) {
    final Map<String, dynamic> json = jsonDecode(response.body);
    String story = json['story'];
    Fetch fetch = Fetch.fromFetch(story);
    return fetch;
  }

  return null;
}

Future<List<Fetch>?> fetch() async {
  var url = Uri.https('api.storyblok.com', '/v1/cdn/stories', {
    'per_page': '100',
    'token': '----',
    'version': 'draft'
  });

  final http.Response response = await http.get(url);

  if (response.statusCode == 200) {
    final Map<String, dynamic> json = jsonDecode(response.body);
    List<Fetch> fetchList = [];
    List list = json['stories'];
    list.map((i) {
      Fetch fetch = Fetch.fromFetch(i);
      fetchList.add(fetch);
    }).toList();

    return fetchList;
  }

  return null;
}

class Fetch {
  final name;
  final created;
  final published;
  final alternates;
  final id;
  final uuid;
  final content;
  final slug;
  final full_slug;
  final default_full_slug;
  final sort_by_date;
  final position;
  final tag_list;
  final isStartPage;
  final parent_id;
  final meta_data;
  final release_id;
  final lang;
  final path;
  final translated_slugs;

  Fetch(
      {this.name,
      this.created,
      this.published,
      this.alternates,
      this.id,
      this.uuid,
      this.content,
      this.slug,
      this.full_slug,
      this.default_full_slug,
      this.sort_by_date,
      this.position,
      this.tag_list,
      this.isStartPage,
      this.parent_id,
      this.meta_data,
      this.release_id,
      this.lang,
      this.path,
      this.translated_slugs});

  factory Fetch.fromFetch(map) {
    return Fetch(
        name: map["name"],
        created: map["created_at"],
        published: map["published_at"],
        alternates: map["alternates"],
        id: map["id"],
        uuid: map["uuid"],
        content: map["content"],
        slug: map["slug"],
        full_slug: map["full_slug"],
        default_full_slug: map["default_full_slug"],
        sort_by_date: map["sort_by_date"],
        position: map["position"],
        tag_list: map["tag_list"],
        isStartPage: map["is_startpage"],
        parent_id: map["parent_id"],
        meta_data: map["meta_data"],
        release_id: map["release_id"],
        lang: map["lang"],
        path: map["path"],
        translated_slugs: map["translated_slugs"]);
  }

  @override
  String toString() {
    return 'Fetch{name: $name, created: $created, published: $published, alternates: $alternates, id: $id, uuid: $uuid, content: $content, slug: $slug, full_slug: $full_slug, default_full_slug: $default_full_slug, sort_by_date: $sort_by_date, position: $position, tag_list: $tag_list, isStartPage: $isStartPage, parent_id: $parent_id, meta_data: $meta_data, release_id: $release_id, lang: $lang, path: $path, translated_slugs: $translated_slugs}';
  }
}
