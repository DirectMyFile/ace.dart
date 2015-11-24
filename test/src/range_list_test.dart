library ace.test.range_list;

import 'package:ace/ace.dart';
import 'package:ace/proxy.dart';
import 'package:unittest/unittest.dart';

RangeList rangeList;

setup() {  
  implementation = ACE_PROXY_IMPLEMENTATION;
  rangeList = new RangeList();
}

void testPointIndex() {
  rangeList.ranges = [
      new Range(1,2,3,4),
      new Range(4,2,5,4),
      new Range(8,8,9,9)
  ];
  expect(rangeList.pointIndex(const Point(0, 1)), -1);
  expect(rangeList.pointIndex(const Point(1, 2)), 0);
  expect(rangeList.pointIndex(const Point(1, 3)), 0);
  expect(rangeList.pointIndex(const Point(3, 4)), 0);
  expect(rangeList.pointIndex(const Point(4, 1)), -2);
  expect(rangeList.pointIndex(const Point(5, 1)), 1);
  expect(rangeList.pointIndex(const Point(8, 9)), 2);
  expect(rangeList.pointIndex(const Point(18, 9)), -4);
}

void testPointIndexExcludeEdges() {
  rangeList.ranges = [
      new Range(1,2,3,4),
      new Range(4,2,5,4),
      new Range(8,8,9,9),
      new Range(10,10,10,10)
  ];
  expect(rangeList.pointIndex(const Point(0, 1), excludeEdges: true), -1);
  expect(rangeList.pointIndex(const Point(1, 2), excludeEdges: true), -1);
  expect(rangeList.pointIndex(const Point(1, 3), excludeEdges: true), 0);
  expect(rangeList.pointIndex(const Point(3, 4), excludeEdges: true), -2);
  expect(rangeList.pointIndex(const Point(4, 1), excludeEdges: true), -2);
  expect(rangeList.pointIndex(const Point(5, 1), excludeEdges: true), 1);
  expect(rangeList.pointIndex(const Point(8, 9), excludeEdges: true), 2);
  expect(rangeList.pointIndex(const Point(10, 10), excludeEdges: true), 3);
  expect(rangeList.pointIndex(const Point(18, 9), excludeEdges: true), -5);
}

void testAdd() {
  rangeList.addList([
      new Range(9,0,9,1),
      new Range(1,2,3,4),
      new Range(8,8,9,9),
      new Range(4,2,5,4),
      new Range(3,20,3,24),
      new Range(6,6,7,7)
  ]);
  expect(rangeList.ranges.length, 5);
  rangeList.add(new Range(1,2,3,5));
  expect(rangeList.ranges[0], new Range(1,2,3,5));
  expect(rangeList.ranges.length, 5);
  rangeList.add(new Range(7,7,7,7));
  expect(rangeList.ranges[3], new Range(7,7,7,7));
  rangeList.add(new Range(7,8,7,8));
  expect(rangeList.ranges[4], new Range(7,8,7,8));
}

void testAddEmpty() {
  rangeList.addList([
      new Range(7,10,7,10),
      new Range(9,10,9,10),
      new Range(8,10,8,10)
  ]);
  expect(rangeList.ranges.length, 3);
  rangeList.add(new Range(9,10,9,10));
  expect(rangeList.ranges[0], new Range(7,10,7,10));
  expect(rangeList.ranges[1], new Range(8,10,8,10));
  expect(rangeList.ranges[2], new Range(9,10,9,10));
}

void testMerge() {
  rangeList.addList([
      new Range(1,2,3,4),
      new Range(4,2,5,4),
      new Range(6,6,7,7),
      new Range(8,8,9,9)
  ]);
  var removed = [];
  expect(rangeList.ranges.length, 4);
  
  var ranges = rangeList.ranges;
  ranges[1].end = new Point(7, ranges[1].end.column);
  rangeList.ranges = ranges;
  removed = rangeList.merge();
  expect(removed.length, 1);
  expect(rangeList.ranges[1], new Range(4,2,7,7));
  expect(rangeList.ranges.length, 3);

  ranges = rangeList.ranges;
  ranges[0].end = new Point(10, ranges[0].end.column);
  rangeList.ranges = ranges;
  removed = rangeList.merge();
  expect(rangeList.ranges[0], new Range(1,2,10,4));
  expect(removed.length, 2);
  expect(rangeList.ranges.length, 1);

  rangeList.add(new Range(10,10,10,10));
  rangeList.add(new Range(10,10,10,10));
  removed = rangeList.merge();
  expect(rangeList.ranges.length, 2);
}

void testRemove() {
  rangeList.addList([
      new Range(1,2,3,4),
      new Range(4,2,5,4),
      new Range(6,6,7,7),
      new Range(8,8,9,9)
  ]);
  expect(rangeList.ranges.length, 4);
  rangeList.substractPoint(const Point(1, 2));
  expect(rangeList.ranges.length, 3);
  rangeList.substractPoint(const Point(6, 7));
  expect(rangeList.ranges.length, 2);
}
