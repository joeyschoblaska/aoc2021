require "set"
require "json"
require_relative "execute"

candidates = {}

if File.exists?("24/dcandidates.json")
  candidates = JSON.parse(File.read("24/candidates.json"))
else
  (0..13).to_a.reverse.each do |i|
    candidates[i] = []

    ztargets =
      i == 13 ? Set.new([0]) : Set.new(candidates[i + 1].map { |c| c[1] })

    (1..9).each do |n|
      p [i, n]
      (0..1_000_000).each do |zin|
        result = execute(@instruction_sets[i], [n], 0, 0, 0, zin)
        zout = result[3]
        candidates[i] << [n, zin, zout] if ztargets.include?(zout)
      end
    end

    if candidates[i].empty?
      File.open("24/candidates.json", "w") { |f| f.puts candidates.to_json }
      raise "no candidates found"
    end
  end

  File.open("24/candidates.json", "w") { |f| f.puts candidates.to_json }
end
