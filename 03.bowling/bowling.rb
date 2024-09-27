#!/usr/bin/env ruby
# frozen_string_literal: true

score = ARGV[0]
scores = score.split(',')
shots = []

scores.each do |s|
  if s == 'X'
    shots << 10
    shots << 0
  else
    shots << s.to_i
  end
end

frames = shots.each_slice(2).to_a

point = frames.each_with_index.sum do |frame, index|
  next_frame = frames[index + 1]
  next2_frame = frames[index + 2]

  bonus_point = 0

  if index < 9 # 1〜9フレーム目までの計算
    if frame[0] == 10 # ストライクの場合
      bonus_point = if next_frame[0] == 10 # 2フレームストライクだった場合
                      next_frame[0] + next2_frame[0]
                    else
                      next_frame[0] + next_frame[1]
                    end
    elsif frame.sum == 10 # スペアの場合
      bonus_point = next_frame[0]
    end
  end
  frame.sum + bonus_point
end

puts point
