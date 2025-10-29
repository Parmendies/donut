import sys

def parse_point(line):
    """Parse a line like '(x, y, z) id: n' and return (x, y, z)"""
    try:
        # Remove '(', ')', and split by comma
        parts = line.strip().replace('(', '').replace(')', '').split(',')
        if len(parts) >= 3:
            x = int(parts[0].strip())
            y = int(parts[1].strip())
            z = int(parts[2].strip().split()[0])  # Remove 'id: n' part
            return (x, y, z)
    except:
        return None
    return None

def print_3d_points_ascii(points):
    """Print 3D points as ASCII art on 2D plane (x, y)"""
    if not points:
        print("No points to display")
        return
    
    # Find min and max for x and y
    min_x = min(p[0] for p in points)
    max_x = max(p[0] for p in points)
    min_y = min(p[1] for p in points)
    max_y = max(p[1] for p in points)
    
    width = max_x - min_x + 1
    height = max_y - min_y + 1
    
    # Create 2D grid
    grid = [[' ' for _ in range(width)] for _ in range(height)]
    
    # Create a dictionary to store the closest point (max z) at each (x, y)
    point_dict = {}
    for x, y, z in points:
        key = (x, y)
        if key not in point_dict or z > point_dict[key][2]:
            point_dict[key] = (x, y, z)
    
    # Fill grid with points (using z-buffer concept)
    for x, y, z in point_dict.values():
        grid_x = x - min_x
        grid_y = y - min_y
        if 0 <= grid_y < height and 0 <= grid_x < width:
            # Use different characters based on depth
            if z > 30:
                grid[grid_y][grid_x] = '@'
            elif z > 10:
                grid[grid_y][grid_x] = '#'
            elif z > 0:
                grid[grid_y][grid_x] = '+'
            elif z > -10:
                grid[grid_y][grid_x] = '-'
            elif z > -30:
                grid[grid_y][grid_x] = '.'
            else:
                grid[grid_y][grid_x] = '·'
    
    # Print grid
    print(f"\nDimensions: {width} x {height}")
    print(f"X range: [{min_x}, {max_x}]")
    print(f"Y range: [{min_y}, {max_y}]")
    print("\n" + "=" * width)
    for row in grid:
        print(''.join(row))
    print("=" * width + "\n")

def main():
    points = []
    
    # Read from stdin or file
    if len(sys.argv) > 1:
        # Read from file
        with open(sys.argv[1], 'r') as f:
            for line in f:
                point = parse_point(line)
                if point:
                    points.append(point)
    else:
        # Read from stdin
        print("Reading points from stdin (paste Dart output, Ctrl+D to finish):")
        for line in sys.stdin:
            point = parse_point(line)
            if point:
                points.append(point)
    
    print(f"\nTotal points parsed: {len(points)}")
    
    if points:
        # Print statistics
        print("\nStatistics:")
        print(f"X: min={min(p[0] for p in points)}, max={max(p[0] for p in points)}")
        print(f"Y: min={min(p[1] for p in points)}, max={max(p[1] for p in points)}")
        print(f"Z: min={min(p[2] for p in points)}, max={max(p[2] for p in points)}")
        
        # Print ASCII representation
        print_3d_points_ascii(points)

if __name__ == "__main__":
    main()