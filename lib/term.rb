class Term
  class << self
   def windows?
      (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil
    end

    def mac?
      (/darwin/ =~ RUBY_PLATFORM) != nil
    end

    def unix?
      !windows?
    end

    def linux?
      unix? and not mac?
    end
   end
    # Running this C code tells you what TIOCGWINSZ is on your platform:
    #
    # #include <sys/ioctl.h>
    # #include <stdio.h>
    # #include <unistd.h>
    #
    # int main(int argc, char *argv[])
    # {
    #   printf("0x%x\n", (int) TIOCGWINSZ);
    #   return 0;
    # }
    TIOCGWINSZ =
      if mac?
        0x40087468
      elsif windows?
        0x5401
      else
        0x5413
      end

  class << self
    attr_reader :height, :width
  end

  def self.get_terminal_size
    @height, @width = [Integer(`tput li`), Integer(`tput co`)]
  end

  get_terminal_size
  Signal.trap("WINCH") do
    get_terminal_size
    puts "New Size: #{@height} X #{@width}"
  end
end
