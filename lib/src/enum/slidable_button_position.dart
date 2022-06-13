/// Position of button which on the left or right
enum SlidableButtonPosition {
  @Deprecated('This api is deprecated, please use [start] or [end].')
  left,
  @Deprecated('This api is deprecated, please use [start] or [end].')
  right,

  start,
  end,

  /// Only available if `tristate` is true
  sliding,
}
