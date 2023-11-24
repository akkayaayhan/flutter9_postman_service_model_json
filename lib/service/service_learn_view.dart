import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'post_model.dart';

class ServiceLearn extends StatefulWidget {
  const ServiceLearn({super.key});

  @override
  State<ServiceLearn> createState() => _ServiceLearnState();
}

class _ServiceLearnState extends State<ServiceLearn> {
  List<PostModel>? _items;
  bool _isLoading = false;
  late final Dio _dio;
  final _baseUrl='https://jsonplaceholder.typicode.com/';



  void changeLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

   @override
  void initState() {
    super.initState();
    _dio=Dio(BaseOptions(baseUrl: _baseUrl));
    verileriGetir();
  }


  Future<void> verileriGetir() async {
    changeLoading();// Veri var mı yok mu kontrolü
    final response =
        await Dio().get('https://jsonplaceholder.typicode.com/posts');
    if (response.statusCode == HttpStatus.ok) {
      final _datas = response.data;
      if (_datas is List) {
        setState(() {
          _items = _datas.map((e) => PostModel.fromJson(e)).toList();
        });
      }
    }
    changeLoading();
  }

  Future<void> verileriGetirAdvanced() async {
    changeLoading();// Veri var mı yok mu kontrolü
    final response =await _dio.get('posts');
    if (response.statusCode == HttpStatus.ok) {
      final _datas = response.data;
      if (_datas is List) {
        setState(() {
          _items = _datas.map((e) => PostModel.fromJson(e)).toList();
        });
      }
    }
    changeLoading();
  }


 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Service İşlemleri"),
        actions: [_isLoading ? CircularProgressIndicator() : SizedBox.shrink()],
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(8),
          itemCount: _items?.length ?? 0,
          itemBuilder: (context, index) {
            return _PostCard(model: _items?[index]);
          }),
    );
  }
}

class _PostCard extends StatelessWidget {
  const _PostCard({
    super.key,
    required PostModel? model,
  }) : _model = model;

  final PostModel? _model;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: ListTile(
        title: Text(_model?.title ?? '',
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.red)),
        subtitle: Text(_model?.body ?? ''),
      ),
    );
  }
}
