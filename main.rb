part_1_bars = 4
interlude_bars = 2


live_loop :flibble do
  cue :flibble_go
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
  cue :flibble_pause
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

ambience_notes = scale(:E3, :minor)
ambience_amp = 0.75

in_thread(name: :ambience) do
  use_synth :dark_ambience
  ambience_note = play ambience_notes.pick, sustain: 2000.000 , note_slide: 1, amp: ambience_amp, amp_slide: 1
  
  in_thread(name: :flibble_watcher) do
    sync :flibble_pause
    control ambience_note, amp: ambience_amp * 0.25
    sync :flibble_go
    control ambience_note, amp: ambience_amp
  end
  
  loop do
    sleep 4
    control ambience_note, note: ambience_notes.pick
  end
end