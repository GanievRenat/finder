class TickerState {
  final int tickCount;

  const TickerState({this.tickCount = 0});

  TickerState copyWith({int? tickCount}) {
    return TickerState(tickCount: tickCount ?? this.tickCount);
  }
}
