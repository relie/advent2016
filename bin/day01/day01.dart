import 'dart:io';

void day01() {
  File('./bin/day01/input.txt').readAsString().then((String contents) {
    part2(contents.split(', '));
  });
}

void part1(List<String> movements) {
  String currentForward = 'N';
  int northSteps = 0;
  int eastSteps = 0;

  for (final movement in movements) {
    List<String> moveParts = movement.split('');
    int currentSteps = int.parse(movement.substring(1));
    print('Current movement is $movement.');

    if (movement[0] == 'L') {
      switch(currentForward) {
        case 'N':
          currentForward = 'W';
          eastSteps -= currentSteps;
          print('Turned west, moved $currentSteps.');
          break;
        case 'E':
          currentForward = 'N';
          northSteps += currentSteps;
          print('Turned north, moved $currentSteps.');
          break;
        case 'W':
          currentForward = 'S';
          northSteps -= currentSteps;
          print('Turned south, moved $currentSteps.');
          break;
        case 'S':
          currentForward = 'E';
          eastSteps += currentSteps;
          print('Turned east, moved $currentSteps.');
          break;
        default: break;
      }
    } else if (moveParts[0] == 'R') {
      switch(currentForward) {
        case 'N':
          currentForward = 'E';
          eastSteps += currentSteps;
          print('Turned east, moved $currentSteps.');
          break;
        case 'E':
          currentForward = 'S';
          northSteps -= currentSteps;
          print('Turned south, moved $currentSteps.');
          break;
        case 'W':
          currentForward = 'N';
          northSteps += currentSteps;
          print('Turned north, moved $currentSteps.');
          break;
        case 'S':
          currentForward = 'W';
          eastSteps -= currentSteps;
          print('Turned west, moved $currentSteps.');
          break;
        default: break;
      }
    }
    print('We are now $northSteps steps north and $eastSteps steps east. That is ${northSteps.abs() + eastSteps.abs()} blocks away.\n');
  }
}

void part2(List<String> movements) {
  String currentForward = 'N';
  int northSteps = 0;
  int eastSteps = 0;
  List<List<int>> visited = [];
  List<List<int>> currentVisits = [];
  bool hasTwice = false;
  List<int> firstTwice = [];

  for (final movement in movements) {
    List<String> moveParts = movement.split('');
    int currentSteps = int.parse(movement.substring(1));
    print('Current movement is $movement.');

    if (movement[0] == 'L') {
      switch(currentForward) {
        case 'N':
          currentForward = 'W';
          currentVisits = getNewXCoords(currentForward, currentSteps, eastSteps, northSteps);
          eastSteps -= currentSteps;
          print('Turned west, moved $currentSteps.');
          break;
        case 'E':
          currentForward = 'N';
          currentVisits = getNewYCoords(currentForward, currentSteps, eastSteps, northSteps);
          northSteps += currentSteps;
          print('Turned north, moved $currentSteps.');
          break;
        case 'W':
          currentForward = 'S';
          currentVisits = getNewYCoords(currentForward, currentSteps, eastSteps, northSteps);
          northSteps -= currentSteps;
          print('Turned south, moved $currentSteps.');
          break;
        case 'S':
          currentForward = 'E';
          currentVisits = getNewXCoords(currentForward, currentSteps, eastSteps, northSteps);
          eastSteps += currentSteps;
          print('Turned east, moved $currentSteps.');
          break;
        default: break;
      }
    } else if (moveParts[0] == 'R') {
      switch (currentForward) {
        case 'N':
          currentForward = 'E';
          currentVisits = getNewXCoords(
              currentForward, currentSteps, eastSteps, northSteps);
          eastSteps += currentSteps;
          print('Turned east, moved $currentSteps.');
          break;
        case 'E':
          currentForward = 'S';
          currentVisits = getNewYCoords(
              currentForward, currentSteps, eastSteps, northSteps);
          northSteps -= currentSteps;
          print('Turned south, moved $currentSteps.');
          break;
        case 'W':
          currentForward = 'N';
          currentVisits = getNewYCoords(
              currentForward, currentSteps, eastSteps, northSteps);
          northSteps += currentSteps;
          print('Turned north, moved $currentSteps.');
          break;
        case 'S':
          currentForward = 'W';
          currentVisits = getNewXCoords(
              currentForward, currentSteps, eastSteps, northSteps);
          eastSteps -= currentSteps;
          print('Turned west, moved $currentSteps.');
          break;
        default:
          break;
      }
    }

    for (final currentVisit in currentVisits) {
      // print(currentVisit);
      // print(visited);
      print('Log ${visited.any((element) => element[0] == currentVisit[0] && element[1] == currentVisit[1]) ? 'contains' : 'does not contain'} current coords.');
      if (visited.any((element) => element[0] == currentVisit[0] && element[1] == currentVisit[1])) {
        if (!hasTwice) {
          hasTwice = true;
          firstTwice = currentVisit;
        }
      }
      visited.add(currentVisit);
    }

    print('We are now $northSteps steps north and $eastSteps steps east. That is ${northSteps.abs() + eastSteps.abs()} blocks away.\n');
  }

  print('First coordinates to be visited twice is $firstTwice');
}

List<List<int>> getNewXCoords(String dir, int i, int eastSteps, int northSteps) {
  List<List<int>> newCoords = [];
  if (dir == 'E') {
    print('R is ${eastSteps+1}, end is ${eastSteps+i}');
    for (int r = eastSteps+1; r <= eastSteps+i; r++) {
      newCoords.add([northSteps, r]);
    }
  } else if (dir == 'W') {
    print('R is ${eastSteps-1}, end is ${eastSteps-i}');
    for (int r = eastSteps-1; r >= eastSteps-i; r--) {
      newCoords.add([northSteps, r]);
    }
  }
  // print('New coordinates are $newCoords');
  return newCoords;
}

List<List<int>> getNewYCoords(String dir, int i, int eastSteps, int northSteps) {
  List<List<int>> newCoords = [];
  if (dir == 'N') {
    print('R is ${northSteps+1}, end is ${northSteps+i}');
    for (int r = northSteps+1; r <= northSteps+i; r++) {
      newCoords.add([r, eastSteps]);
    }
  } else if (dir == 'S') {
    print('R is ${northSteps-1}, end is ${northSteps-i}');
    for (int r = northSteps-1; r >= northSteps-i; r--) {
      newCoords.add([r, eastSteps]);
    }
  }
  // print('New coordinates are $newCoords');
  return newCoords;
}
