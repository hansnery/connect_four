3.times do
      diagonal = create_diagonals(0, 0 + i)
      i += 1
      result << diagonal if diagonal.size > 3
    end