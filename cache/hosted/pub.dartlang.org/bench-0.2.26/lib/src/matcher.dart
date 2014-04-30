part of bench;

const Matcher isTimeoutException = const _TimeoutExceptionMatcher();

class _TimeoutExceptionMatcher extends TypeMatcher {
  const _TimeoutExceptionMatcher() : super("TimeoutException");
  bool matches(item, Map matchState) => item is TimeoutException;
}

const Matcher isStackOverflowError = const _StackOverflowErrorMatcher();

class _StackOverflowErrorMatcher extends TypeMatcher {
  const _StackOverflowErrorMatcher() : super("StackOverflowError");
  bool matches(item, Map matchState) => item is StackOverflowError;
}

const Matcher atLeastOnce = const _TimesMatcher(1);
const Matcher atMostOnce = const _TimesMatcher(0, 1);
const Matcher once = const _TimesMatcher(1, 1);
const Matcher never = const _TimesMatcher(0, 0);
const Matcher twice = const _TimesMatcher(2, 2);

Matcher atLeast(int count) => new _TimesMatcher(count);
Matcher atMost(int count) => new _TimesMatcher(0, count);
Matcher exactly(int count) => new _TimesMatcher(count, count);

class _TimesMatcher extends Matcher {
  
  final int min, max;

  const _TimesMatcher(this.min, [this.max = -1]);

  bool matches(calls, Map matchState) => calls.length >= min &&
      (max < 0 || calls.length <= max);

  Description describe(Description description) {
    description.add('to be called ');
    if (max < 0) {
      description.add('at least $min');
    } else if (max == min) {
      description.add('$max');
    } else if (min == 0) {
      description.add('at most $max');
    } else {
      description.add('between $min and $max');
    }
    return description.add(' times');
  }

  Description describeMismatch(calls, Description mismatchDescription,
                               Map matchState, bool verbose) =>
      mismatchDescription.add('was called ${calls.length} times');
}
