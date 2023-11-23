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
  void changeLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
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

  @override
  void initState() {
    super.initState();
    verileriGetir();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Service İşlemleri"),
        actions: [_isLoading ? CircularProgressIndicator() : SizedBox.shrink()],
      ),
      body: ListView.builder(
          itemCount: _items?.length ?? 0,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text(_items?[index].title ?? '',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.red)),
                subtitle: Text(_items?[index].body ?? ''),
              ),
            );
          }),
    );
  }
}
