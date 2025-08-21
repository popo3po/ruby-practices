#!/usr/bin/env ruby
# frozen_string_literal: true

def collect_current_directory_files
  current_directory_files = Dir.glob('*') if ARGV.empty?
  exit if current_directory_files.empty?

  current_directory_files
end

def align_ranges(current_directory_files)
  files = []
  # binding.break
  max_name_length = current_directory_files.map(&:length).max

  current_directory_files.each do |file|
    files << if File.directory?(file)
               "\e[34m#{file}\e[0m/" + ' ' * (max_name_length - file.length)
             elsif File.executable?(file)
               "\e[31m#{file}\e[0m*" + ' ' * (max_name_length - file.length)
             else
               file + ' ' * (max_name_length - (file.length - 1))
             end
  end
  files
end

def adjust_column(files, column)
  slices = []

  files << nil while files.size % column != 0
  files.each_slice(files.size / column) { |s| slices << s }

  slices.transpose.each do |row|
    puts row.join(' '.ljust(1))
  end
end

align_ranges = align_ranges(collect_current_directory_files)
adjust_column(align_ranges, 3)
