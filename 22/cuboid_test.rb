require_relative "cuboid"
require "test/unit"

class CuboidTest < Test::Unit::TestCase
  setup do
    @cuboid = Cuboid.new(0..3, 0..3, 0..3)
    @poking = Cuboid.new(1..4, 1..2, 1..2)
    @contained = Cuboid.new(1..2, 1..2, 1..2)
    @containing = Cuboid.new(-1..4, -1..4, -1..4)
    @no_overlap = Cuboid.new(4..5, 4..5, 4..5)
    @touching = Cuboid.new(3..4, 0..3, 0..3)
    @same = Cuboid.new(0..3, 0..3, 0..3)
    @partial_full_overlap = Cuboid.new(1..3, 0..3, 0..3)
    @slices = Cuboid.new(1..2, -1..4, -1..4)
  end

  def test_intersects_poking
    assert_true(@cuboid.intersects?(@poking))
    assert_true(@poking.intersects?(@cuboid))
  end

  def test_intersects_contained
    assert_true(@cuboid.intersects?(@contained))
    assert_true(@contained.intersects?(@cuboid))
  end

  def test_intersects_containing
    assert_true(@cuboid.intersects?(@containing))
    assert_true(@containing.intersects?(@cuboid))
  end

  def test_doesnt_intersect_no_overlap
    assert_false(@cuboid.intersects?(@no_overlap))
    assert_false(@no_overlap.intersects?(@cuboid))
  end

  def test_doesnt_intersect_touching
    assert_false(@cuboid.intersects?(@touching))
    assert_false(@touching.intersects?(@cuboid))
  end

  def test_intersects_same
    assert_true(@cuboid.intersects?(@same))
    assert_true(@same.intersects?(@cuboid))
  end

  def test_intersects_partial_full_overlap
    assert_true(@cuboid.intersects?(@partial_full_overlap))
    assert_true(@partial_full_overlap.intersects?(@cuboid))
  end

  def test_intersects_slices
    assert_true(@cuboid.intersects?(@slices))
    assert_true(@slices.intersects?(@cuboid))
  end

  def test_subtract_poking
    remaining = @cuboid.subtract(@poking)
    assert_equal(17, remaining.count)
    assert_equal(25, remaining.sum(&:volume))
  end

  def test_subtract_contained
    remaining = @cuboid.subtract(@contained)
    assert_equal(26, remaining.count)
    assert_equal(26, remaining.sum(&:volume))
  end

  def test_subtract_containing
    remaining = @cuboid.subtract(@containing)
    assert_equal(0, remaining.count)
  end

  def test_subtract_no_overlap
    remaining = @cuboid.subtract(@no_overlap)
    assert_equal(1, remaining.count)
    assert_equal(27, remaining.sum(&:volume))
  end

  def test_subtract_touching
    remaining = @cuboid.subtract(@touching)
    assert_equal(1, remaining.count)
    assert_equal(27, remaining.sum(&:volume))
  end

  def test_subtract_same
    remaining = @cuboid.subtract(@same)
    assert_equal(0, remaining.count)
  end

  def test_subtract_partial_full_overlap
    remaining = @cuboid.subtract(@partial_full_overlap)
    p remaining
    assert_equal(1, remaining.count)
    assert_equal(9, remaining.sum(&:volume))
  end

  def test_subtract_slices
    remaining = @cuboid.subtract(@slices)
    assert_equal(2, remaining.count)
    assert_equal(18, remaining.sum(&:volume))
  end
end
