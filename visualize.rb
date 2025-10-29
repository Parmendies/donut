require 'gnuplot'

class Point3D
  @@counter = 0
  attr_reader :x, :y, :z, :id

  def initialize(x, y, z)
    @x, @y, @z = x, y, z
    @id = @@counter
    @@counter += 1
  end

  def to_s
    "(#{@x}, #{@y}, #{@z}) id: #{@id}"
  end
end

R = 10.0
r = 5.0
alpha = 0.1
beta = 0.1

def main
  points = []

  tempA = 0.0
  while tempA < 2 * Math::PI
    tempB = 0.0
    while tempB < 2 * Math::PI
      x = ((R + (r * Math.cos(tempA))) * Math.cos(tempB)).round
      y = ((R + (r * Math.cos(tempA))) * Math.sin(tempB)).round
      z = (r * Math.sin(tempA)).round
      points << Point3D.new(x, y, z)
      tempB += beta
    end
    tempA += alpha
  end

  print_points(points)
  visualize_3d(points)
end

def print_points(points)
  points.each { |p| puts p.to_s }
end

def visualize_3d(points)
  xs = points.map(&:x)
  ys = points.map(&:y)
  zs = points.map(&:z)

  Gnuplot.open do |gp|
    Gnuplot::Plot.new(gp) do |plot|
      plot.title  "3D Torus Points"
      plot.xlabel "X"
      plot.ylabel "Y"
      plot.zlabel "Z"
      plot.data << Gnuplot::DataSet.new([xs, ys, zs]) do |ds|
        ds.with = "points"
        ds.title = "Torus"
        ds.linewidth = 1
        ds.pointtype = 7
      end
    end
  end
end

main
