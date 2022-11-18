
# Bonsai Neglect
# Key = Bb Minor
use_debug false

define :strum do |c|
  3. times do
    play c, attack: 0.1, sustain: 0.1, release: 0.1
    sleep 0.5
  end
end


in_thread(name: :chords) do
  ##| stop
  use_bpm 60
  use_synth :rodeo
  
  loop do
    cue :chords_go
    strum chord :Bb, :minor
    strum chord :Eb, :minor
    strum chord :Gb, :major
    strum chord :Ab, :major
  end
end

# Bb Db Eb F Ab
melody = ring( :Bb , :Eb, :Ab, :Eb5 )

define :play_melody_1 do
  play melody[1]
  sleep 2
  3. times do
    play melody[2]
    sleep 1
  end
  play melody[0]
  sleep 2
  play melody[1]
  sleep 1
  play melody[1]
end

define :play_melody_2 do
  play melody[1]
  sleep 2
  3. times do
    play melody[2]
    sleep 1
  end
  play melody[0]
  sleep 2
  play melody[1]
  sleep 1
  play melody[3]
  sleep 1
  play melody[1]
end

in_thread(name: :melody) do
  ##| stop
  use_bpm 240
  use_synth :dsaw
  
  loop do
    sync :chords_go
    play_melody_1
    sync :chords_go
    play_melody_2
  end
end

in_thread(name: :drums) do
  use_bpm 60
  sync :chords_go
  loop do
    6. times do |i|
      sample :drum_heavy_kick , amp: 0.7
      sleep 0.5
      sample :elec_soft_kick
      sleep 0.5
      sample :drum_snare_soft, rate: 4  if i % 2 == 0
    end
  end
end



