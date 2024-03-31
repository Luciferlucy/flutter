abstract class CounterStates {}
class CounterInitialState extends CounterStates {}
class CounterminusState extends CounterStates {
  final int count;
  CounterminusState(this.count);
}
class CounterplusState extends CounterStates {
  final int count;
  CounterplusState(this.count);
}
