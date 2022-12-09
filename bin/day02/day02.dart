import 'dart:convert';
import 'dart:io';

void day02() {
  File('./bin/day02/input.txt').readAsString().then((String contents) {
    part1(LineSplitter().convert(contents));
    part2(LineSplitter().convert(contents));
  });
}

void part1(List<String> input) {
  int x = 0;
  int y = 0;
  String combo = '';

  for (final line in input) {
    List<String> dirs = line.split('');
    for (final dir in dirs) {
      switch(dir) {
        case 'L':
          if (x != -1) {
            x--;
          }
          break;
        case 'R':
          if (x != 1) {
            x++;
          }
          break;
        case 'U':
          if (y != 1) {
            y++;
          }
          break;
        case 'D':
          if (y != -1) {
            y--;
          }
          break;
        default: break;
      }
    }

    combo += getButton(x, y);
  }

  print('The combination is $combo');
}

void part2(List<String> input) {
  int x = 0;
  int y = 2;
  List<List<String>> keypad = [
    [' ', ' ', '1', ' ', ' '],
    [' ', '2', '3', '4', ' '],
    ['5', '6', '7', '8', '9'],
    [' ', 'A', 'B', 'C', ' '],
    [' ', ' ', 'D', ' ', ' '],
  ];

  print('Starting loc is ${keypad[y][x]}');
  String combo = '';

  for (final line in input) {
    List<String> dirs = line.split('');
    for (final dir in dirs) {
      print('Direction is $dir');
      switch(dir) {
        case 'L':
          int z = x-1;
          if (z >= 0 && z <= 4) {
            if (keypad[y][z].trim().isNotEmpty) {
              x = z;
              print(keypad[y][x]);
            }
          }
          break;
        case 'R':
          int z = x+1;
          if (z >= 0 && z <= 4) {
            if (keypad[y][z].trim().isNotEmpty) {
              x = z;
              print(keypad[y][x]);
            }
          }
          break;
        case 'U':
          int z = y-1;
          if (z >= 0 && z <= 4) {
            if (keypad[z][x].trim().isNotEmpty) {
              y = z;
              print(keypad[y][x]);
            }
          }
          break;
        case 'D':
          int z = y+1;
          if (z >= 0 && z <= 4) {
            if (keypad[z][x].trim().isNotEmpty) {
              y = z;
              print(keypad[y][x]);
            }
          }
          break;
        default: break;
      }
    }

    combo += keypad[y][x];
  }

  print('The combination is $combo');
}

String getButton(int x, int y) {
  switch(x) {
    case -1:
      switch(y) {
        case -1:
          return '7';
        case 0:
          return '4';
        case 1:
          return '1';
        default: break;
      }
      break;
    case 0:
      switch(y) {
        case -1:
          return '8';
        case 0:
          return '5';
        case 1:
          return '2';
        default: break;
      }
      break;
    case 1:
      switch(y) {
        case -1:
          return '9';
        case 0:
          return '6';
        case 1:
          return '3';
        default: break;
      }
      break;
    default: break;
  }
  return '';
}