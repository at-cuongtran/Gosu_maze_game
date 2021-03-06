class Cell
  attr_accessor :cell_index_x, :cell_index_y, :walls, :visited, :neigh_bors, :is_current
  def initialize(cell_index_x, cell_index_y)
    @cell_index_x = cell_index_x
    @cell_index_y = cell_index_y
    
    @walls = [true, true, true, true]
    @visited = false
    @color = Color::GREEN
    @is_current = false
  end

  def cell_index(i, j, cells_length)
    if i < 0 || j < 0 || i > $cols-1 || j > $rows-1
      return cells_length
    else
      return i + j * $cols
    end
  end

  def check_neigh_bors(cells)
    @neigh_bors = Array.new

    top    = cells[cell_index(cell_index_x, cell_index_y - 1, cells.length)]
    right  = cells[cell_index(cell_index_x + 1, cell_index_y, cells.length)]
    bottom = cells[cell_index(cell_index_x, cell_index_y + 1, cells.length)]
    left   = cells[cell_index(cell_index_x - 1, cell_index_y, cells.length)]

    if top
      if !top.visited
        @neigh_bors.push(top);
      end
    end

    if right
      if !right.visited
        @neigh_bors.push(right);
      end
    end

    if bottom
      if !bottom.visited
        @neigh_bors.push(bottom);
      end
    end

    if left
      if !left.visited
        @neigh_bors.push(left);
      end
    end

    if @neigh_bors.length > 0
      max = @neigh_bors.length - 1
      random_index = rand(0..max)
      return @neigh_bors[random_index]
    else 
      return nil
    end
  end

  def draw(cell_size, color)
    x = @cell_index_x * cell_size
    y = @cell_index_y * cell_size

    # if @is_current
    #   draw_quad x, y, Color::CYAN,
    #             x + cell_size, y, Color::CYAN,
    #             x + cell_size, y + cell_size, Color::CYAN,
    #             x, y + cell_size, Color::CYAN
    # end

    if @walls[0] 
      draw_line x, y, color,
                x + cell_size, y, color
    end

    if @walls[1] 
      draw_line x + cell_size, y, color,
                x + cell_size, y + cell_size, color
    end

    if @walls[2] 
      draw_line x + cell_size, y + cell_size, color,
                x, y + cell_size, color
    end

    if @walls[3] 
      draw_line x, y + cell_size, color,
                x, y, color
    end
  end
end