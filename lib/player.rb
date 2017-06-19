class Player
  attr_accessor :cell_index_x, :cell_index_y, :color, :target_x, :target_y, :is_moving, :path
  def initialize
    @color = Color::RED
    @cell_index_x = @cell_index_y = 0
    @is_moving = false
    @path = nil
    set_target
    @x = @target_x
    @y = @target_y
    
  end
  
  # def set_position(cell_index_x, cell_index_y)
  #   @cell_index_x = cell_index_x
  #   @cell_index_y = cell_index_y
  #   @x = (@cell_index_x * $cell_size) + $cell_size/2 - $player_size/2
  #   @y = (@cell_index_y * $cell_size) + $cell_size/2 - $player_size/2
  # end

  def set_target
    @target_x = (@cell_index_x * $cell_size) + $cell_size/2 - $player_size/2
    @target_y = (@cell_index_y * $cell_size) + $cell_size/2 - $player_size/2
    # puts 'set target successfull'
  end

  def check_for_path(ignored_path)
    # print 'ignored_path: '
    # puts ignored_path
    path = nil
    $cells[@cell_index_x + @cell_index_y * $cols].walls.each_with_index do |wall, i|
      if !wall and i != ignored_path
        if path == nil
          path = i
        else
          path = nil
          break
        end
      end
    end
    return path
  end

  def move
    if @is_moving
      if @x == @target_x && @y == @target_y
        # puts '(x,y) == (target_x, target_y)'
        # check for available path, 
        # and ignore the the opposite of the LAST path 
        # cuz you don't wanna go back where you just left
        @path = check_for_path(@path == 0 ? 2:
                              @path == 1 ? 3:
                              @path == 2 ? 0: 1)
        if @path != nil
          # puts '@path != nil'
          # set new player's cell index depend on "current @path"
          if @path == 0 
            @cell_index_y -= 1
          elsif @path == 1 
            @cell_index_x += 1
          elsif @path == 2 
            @cell_index_y += 1 
          else
            @cell_index_x -= 1
          end
          set_target
        else
          
          # no "available" @path found player stop moving
          # puts '@path == nil -> is moving = false'
          @is_moving = false
        end
      else

        # target's position is different than curent position, 
        # move to the target
        if @x < @target_x
          @x += $speed_per_tick
        elsif @x > @target_x
          @x -= $speed_per_tick
        end

        if @y < @target_y
          @y += $speed_per_tick
        elsif @y > @target_y
          @y -= $speed_per_tick
        end

      end
    end
  end

  def move_to_target
    # if @x == @target_x and @y == @target_y
    #   @is_moving = false
    #   set_position(@cell_index_x, @cell_index_y)
    # else
      # if @x < @target_x
      #   @x += 4
      # elsif @x > @target_x
      #   @x -= 4
      # end

      # if @y < @target_y
      #   @y += 4
      # elsif @y > @target_y
      #   @y -= 4
      # end
    # end
  end


  def move_up
    @cell_index_y -= 1
    # set_position(@cell_index_x, @cell_index_y)
    
    # path = check_for_path(2)
    # if path != nil
    #   # move to the cell to the "path"
    #   move_up if path == 0
    #   move_left if path == 3
    #   move_right if path == 1
    # end
  end

  def move_down
    @cell_index_y += 1
    # set_position(@cell_index_x, @cell_index_y)
    
    # path = check_for_path(0)
    # if path != nil
    #   # move to the cell to the "path"
    #   move_down if path == 2
    #   move_left if path == 3
    #   move_right if path == 1
    # end
  end

  def move_left
    @cell_index_x -= 1
    # set_position(@cell_index_x, @cell_index_y)

    # path = check_for_path(1)
    # if path != nil
    #   # move to the cell to the "path"
    #   move_up if path == 0
    #   move_left if path == 3
    #   move_down if path == 2
    # end
  end

  def move_right
    @cell_index_x += 1
    # set_position(@cell_index_x, @cell_index_y)

    # path = check_for_path(3)
    # if path != nil
    #   # move to the cell to the "path"
    #   move_up if path == 0
    #   move_down if path == 2
    #   move_right if path == 1
    # end
  end

  def draw
    draw_quad @x, @y, @color,
              @x+$player_size, @y, @color,
              @x+$player_size, @y+$player_size, @color,
              @x, @y+$player_size, @color

    # draw_line @x, @y, Color::GREEN,
    #           @x+PLAYER_SIZE, @y, Color::GREEN

    # draw_line @x+PLAYER_SIZE, @y, Color::GREEN,
    #           @x+PLAYER_SIZE, @y+PLAYER_SIZE, Color::GREEN

    # draw_line @x+PLAYER_SIZE, @y+PLAYER_SIZE, Color::GREEN,
    #           @x, @y+PLAYER_SIZE, Color::GREEN

    # draw_line @x, @y+PLAYER_SIZE, Color::GREEN,
    #           @x, @y, Color::GREEN

  end
end