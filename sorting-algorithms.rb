require 'pry'
class Array
  # Test them out with some random numbers #
  def self.big
    arr = []

    1000000.times do
      arr << rand(1000000)
    end

    arr
  end

# Do not use bubblesort on an Array.big... you will be stuck waiting a long time #
  def bubblesort
    n = self.length - 1

    loop do
      swapped = false

      n.times do |i|
        k = i + 1
        if self[i] > self[k]
          self[i], self[k] = self[k], self[i]
          swapped = true
        end
      end

      break if swapped == false
    end
    self
  end


  def dual_quicksort
    return [] if self.empty?

    pivot1 = self.delete_at(self.length - 1)
    left, mid_right = self.partition { |e| e < pivot1 }

    pivot2 = mid_right.delete_at(mid_right.length - 1)
    middle, right = mid_right.partition { |e| e < pivot2 }

    return *left.dual_quicksort, *pivot1, *middle.dual_quicksort, *pivot2, *right.dual_quicksort
  end


  def heapify(length, root)
    largest = root
    left = 2 * root + 1
    right = left + 1

    if left < length && self[left] > self[largest]
      largest = left
    end

    if right < length && self[right] > self[largest]
      largest = right
    end

    if largest != root
      self[root], self[largest] = self[largest], self[root]
      self.heapify(length, largest)
    end
  end


  def heapsort
    length = self.length
    last_parent = length / 2 - 1
    last_child = length - 1

    while last_parent >= 0
      self.heapify(length, last_parent)
      last_parent -= 1
    end

    while last_child >= 0
      self[0], self[last_child] = self[last_child], self[0]
      self.heapify(last_child, 0)
      last_child -= 1
    end
    self
  end


  def merge(left, right)
    merged = []

    while !left.empty? and !right.empty?
      if left.first < right.first
        merged << left.shift
      else
        merged << right.shift
      end
    end

    merged + left + right
  end


  def mergesort
    if self.length <= 1
      self
    else
      mid = (self.length / 2).floor
      left = self[0..mid - 1].mergesort
      right = self[mid..self.length].mergesort
      self.merge(left, right)
    end
  end


  def quicksort
    return [] if self.empty?

    pivot = self.delete_at(rand(self.size))
    left, right = self.partition { |e| e < pivot }
    return *left.quicksort, pivot, *right.quicksort
  end
end

Pry.start
