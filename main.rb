# Walk Through The Night
# Copyright: Tomphi & Niklas
# Scale: E minor (E, F♯, G, A, B, C, D)

use_debug false
use_bpm 60

part_1_bars = 4
interlude_bars = 2

synthia_type = :dpulse
synthia_amp = 0.5

define :play_synthia do | note, extended = false |
  use_synth synthia_type
  with_fx :level, amp: synthia_amp do
    if( extended ) then
      play note, attack: 0.5, sustain: 1.3, release: 0.2
      sleep 1
    end
    play note
    sleep 1
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
  sample :drum_splash_hard
  sleep 1
  sample :drum_bass_soft
  sleep 1
  sample :drum_bass_soft
  sleep 0.5
  sample :drum_bass_soft
  sleep 1
  sample :drum_bass_soft
  sleep 0.5
end

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
    sample :guit_em9, rate: 0.5, pan: 1
    sample :guit_e_fifths, pan: -1
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

in_thread(name: :synthia_does_what_synthia_does) do
  use_bpm 120
  sync :flibble_go
  loop do
    part_1_bars. times do
      play_synthia chord(:E4, :minor), extended: true
      play_synthia chord(:G, :major7)
      sleep 1
      play_synthia chord(:Fs, :diminished), extended: true
      play_synthia chord(:A, :minor)
      sleep 1
    end
    interlude_bars. times do
      sleep 2
      play_synthia chord(:E4, :minor), extended: true
      sleep 4
    end
    interlude_bars. times do
      play_synthia chord(:B, :minor), extended: true
      play_synthia chord(:D, :major)
      sleep 1
      play_synthia chord(:Fs, :diminished), extended: true
      play_synthia chord(:D, :major)
      sleep 1
    end
    interlude_bars. times do
      play_synthia chord(:Fs4, :diminished), extended: true
      play_synthia chord(:A, :minor)
      play_synthia chord(:C, :major)
      play_synthia chord(:D, :major), extended: true
      play_synthia chord(:C, :major), extended: true
    end
  end
end



