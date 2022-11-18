#

# key: Gb major
# G♭, A♭, B♭, C♭, D♭, E♭, F


use_bpm 60
use_debug false

in_thread(name: :ambience) do
  #stop
  use_synth :hollow
  with_fx :reverb do
    loop do
      play [ :Db4, :Eb5, :F5, :Eb5 ].tick, attack: 4, sustain: 4, decay: 4
      sleep 7.5
    end
  end
end

in_thread(name: :drums_base) do
  #stop
  use_bpm 120
  loop do
    sample :tabla_ke1
    sleep 1
    sample :tabla_ke3
    sleep 1
  end
end

in_thread(name: :drums_base_ext) do
  #stop
  use_bpm 120
  sleep 4
  loop do
    sleep 0.5
    sample [ :tabla_na_s, :tabla_re].tick
    sleep 0.5
  end
end


in_thread(name: :drums) do
  #stop
  sleep 8
  use_bpm 120
  loop do
    
    1. times do
      sample :tabla_te1
      sample :tabla_tas1
      sleep 0.5
      sample :tabla_te1
      sample :tabla_tas1
      sleep 0.5
      sample :tabla_te1
      sample :tabla_tas1
      sleep 1
    end
    
    1. times do
      sample :tabla_te_ne
      sample :tabla_tas2
      sleep 0.5
      sample :tabla_te_ne
      sample :tabla_tas2
      sleep 0.5
      sample :tabla_te_ne
      sample :tabla_tas2
      sleep 1
    end
    
    
    if( [ 1, 0, 0 ].tick == 0 ) then
      2. times do
        sample :tabla_na
        sleep 0.25
        sample :tabla_tun2
        sleep 0.25
        sample :tabla_tun1
        sleep 0.25
        sample :tabla_ghe2
        sleep 1
      end
      sample :tabla_ghe8
      sleep 0.5
    end
    
    sample :tabla_na_o
    cue :drum_solo_done
    sleep 4
    
  end
end


# G♭, A♭, B♭, C♭, D♭, E♭, F

in_thread(name: :melody) do
  use_bpm 120
  
  loop do
    
    use_synth :chipbass
    sync :drum_solo_done
    
    4. times do
      play [:Cb3, :Eb3].tick
      sleep 4
    end
    
    use_synth :chiplead
    if [0,1].tick == 0 then
      play :Cb3
      sleep 1
      play :Eb3
      sleep 0.5
      play :Gb3
      sleep 1
      play :F3
      sleep 0.5
      play :Bb3
      sleep 0.5
      play :Ab3
      
      sleep 2
    else
      4. times do | i |
        play :Cb3
        sleep 1
        play :Bb4
        sleep 1
        play :Ab4
        sleep 0.75
        play :F4
        sleep 0.75
        2. times do
          play :Gb3
          sleep 1
        end
        play :Db4
        sleep 0.5
        ((i % 2 == 1) ? 3 : 1). times do
          play :Ab4
          sleep 0.5
        end
        
        sleep i % 2 == 0 ? 1.5 : 0.5
      end
    end
    
  end
end








