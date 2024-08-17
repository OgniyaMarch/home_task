abstract class PeopleFilterEvent {}

class NameChanged extends PeopleFilterEvent {
  NameChanged(this.name);

  String name;
}

class AgeChanged extends PeopleFilterEvent {
  AgeChanged(this.ageRanges);

  List<bool> ageRanges;
}

class AgeFilterChanged extends PeopleFilterEvent {
  AgeFilterChanged(this.index, this.isSelected);

  final bool isSelected;
  int index;
}
