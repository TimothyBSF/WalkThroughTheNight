part_1_bars = 4
interlude_bars = 2


live_loop :flibble do
  part_1_bars. times do
    sample :guit_em9, rate: 0.5
    sleep 4
  end
  interlude_bars. times do
    sample :guit_e_fifths
    sleep 4
  end
  interlude_bars. times do
    sample :guit_em9, rate: 0.5
    sample :guit_e_fifths
    sleep 4
  end
  interlude_bars. times do
    sleep 4
  end
end

live_loop :drumBase do
  part_1_bars. times do
    baseBeat
  end
  interlude_bars. times do
    beatVariation
  end
  part_1_bars. times do
    baseBeat
  end
end


define :baseBeat do
  sample :drum_bass_soft
  sleep 1
  sample :drum_snare_hard
  sleep 0.5
  sample :drum_bass_soft
  sleep 1
  sample :drum_bass_soft
  sleep 0.5
  sample :drum_snare_hard
  sleep 1
end


define :beatVariation do
  sample :drum_bass_soft
  sleep 0.5
  sample :drum_cymbal_hard
  sleep 0.5
  sample :drum_cymbal_soft
  sleep 0.5
  sample :drum_tom_mid_soft
  sleep 1
  sample :drum_tom_lo_soft
  sleep 1
  sample :drum_bass_soft
  sleep 0.5
end