import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<http.Response> fetchWord(String search) {
  return http.get('http://dati.provincia.mc.it/dataset?q='+ search);
}