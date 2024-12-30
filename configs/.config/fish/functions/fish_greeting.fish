function fish_greeting
    echo Hello Jeremy 👋
    echo ""

    fastfetch

    # Get the short (less than 160 characters) fortune
    set fortune_output (fortune -s ~/dotfiles/extra_fortunes fortunes computers riddles men-women literature love magic linuxcookie drugs pets art law goedel education ethnic science ascii-art miscellaneous sports zippy politics startrek wisdom news work medicine people food humorists platitudes cookie songs-poems definitions kids fortunes translate-me)

    # Select a random cowsay option, use it 1 in 4 times
    set selected_option (random choice -b -d -g -p -s -t -w -y)
    if test (random 1 4) -eq 4
      set diff_cow true
    else
      set diff_cow false
    end

    # Do lolcat 1 in 10 times for some extra color
    if test (random 1 10) -eq 1
      set lolcat true
    else
      set lolcat false
    end

    # Do super lolcat 1 in 10 times (therefore 1 in 100 times)
    if test (random 1 10) -eq 1
      set superlolcat true
    else
      set superlolcat false
    end

    echo ""

    # Output the fortune with cowsay and lolcat options
    if $diff_cow && $lolcat && $superlolcat
      echo "Jackpot! 💰"
      echo $fortune_output | cowsay $selected_option | lolcat -a -t -d 6
    else if $diff_cow && $lolcat
      echo $fortune_output | cowsay $selected_option | lolcat -t
    else if $diff_cow
      echo $fortune_output | cowsay $selected_option
    else
      echo $fortune_output | cowsay
    end
end
