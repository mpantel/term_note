class Presenter

  def self.present
    self.new.play if ARGV[0] !~ /RECORD/
    self.new.record if ARGV[0] =~ /RECORD/
  end

  def initialize(first_slide = 1)
    @web = Web.new
    self.current = @current = first_slide
  end

  attr_reader :current, :web

  def current=(position)
    if position < 1
      @current = 1
    elsif position > size
      @current = size
    else
      @current = position
    end
  end

  def play
    while current <= size
      display_slide
      key = STDIN.gets.chomp
      case key
      when 'b'
        self.current -= 1
      when /[0-9][0-9]*/
        self.current = key.to_i
      when 'q'
        exit
      when 'h', '?'
        print_help
      else
        self.current += 1
      end
      system('clear')
    end
  end

  def presentation_name
    $0.split('.').first
  end

  def record # requires MacOS + ImageMagick
    (1..size).each do |index|
      self.current = index
      next unless @@slides_to_record.include?(index)
      display_slide
    end
    `convert #{presentation_name}_slide_*.png #{presentation_name}_presentation_recorded#{ ARGV[0] =~ /LONG/ ? '_long' : ''}.pdf`
  end

  def print_help
    system('clear')
    puts "Press...   to:"
    puts "h,?   print this help"
    puts "q     quit"
    puts "<number> go to slide <number>"
    puts "<enter>  go to next slide"
    puts "b  go to previous slide"
    puts "Run... to:"
    puts "ruby #{$0} RECORD, to generate pdf of presentation"
    puts "ruby #{$0} NOTES, to include notes"
    STDIN.gets.chomp
  end

  def slides
    @slides ||= self.class.public_instance_methods(true).
      grep(/\Aslide_/).
      map(&:to_s).
      sort_by { |s| s.split('_').last.to_i }.
      map(&:to_sym)
  end

  def size
    slides.size
  end

  def display_slide
    slide = self.send(@slides[@current - 1])
    content, format = slide&.first&.split('#')
    if format =~ /SNAPSHOT/
      filename = @web.url(content, format: :square)
      if ARGV[0] =~ /RECORD/
        FileUtils.copy_file("#{filename}.png", "#{presentation_name}_slide_#{"%04d" % (@current)}.png")
      else
        puts filename.center(Term.width)
        puts File.read("#{filename}.six")
      end
    else
      center(slide)
    end
    if ARGV[0] =~ /RECORD/ && format !~ /SNAPSHOT/
      sleep 1
      `screencapture -x -o -l$(osascript -e 'tell app "Terminal" to id of window 1') #{presentation_name}_slide_#{"%04d" % (@current)}.png`
    end
  end

  def split_screen
    ["", "", "", "#underline", "", "", ""]
  end

  def center(slide)
    lines = slide.size
    blank = Term.height - lines
    half, rest = blank.divmod(2)

    puts "\n" * half
    notes = []
    slide.each do |l|
      content, format = l.split('#')
      content ||= l
      format = (format || '').split('.')
      format -= ['blink'] if ARGV[0] =~ /RECORD/

      display = format.include?('CODE') ? content.ljust(Term.width - 10) : content.center(Term.width)
      if format.include?('URL')
        `open '#{content}'`
        puts "See browser window for #{content}".center(Term.width)
      elsif format.include?('NOTES')
        notes << (format - %w(NOTES CODE)).inject(display) { |res, f| res.send(f.to_sym) }

      else
        puts (format - ['CODE']).inject(display) { |res, f| res.send(f.to_sym) }
      end

    end
    puts "\n" * (half + rest + notes.size)

    notes.each { |n| puts n } if ARGV[0] =~ /NOTES/
    # end
  rescue ArgumentError => e
    "Παρακαλώ μεγαλώστε το παράθυρο για εμφανιστεί η σελίδα..."
    puts "Error: #{e.message}"
    puts e.backtrace
    puts ["lines:", lines, "height:", Term.height, "width:", Term.width, "blank:", blank, "half:", half, "rest:", rest].join("  ")
    @current -= 1
  ensure
    pager, prompt = if ARGV[0] !~ /RECORD/
                      ["Slide: %d / %d >" % [current, size],
                       "b: back one,<number>: goto slide, <enter>: next, h,?: help, q: quit"]
                    else
                      current_index = @@slides_to_record.find_index(current)
                      previous_shown = (current_index == 0 ? 0 : @@slides_to_record[current_index - 1]) + 1
                      ["Slide: #{[previous_shown, current].uniq.join(' - ')} / %d >" % @@slides_to_record.last, ""]
                    end
    printf prompt + pager.rjust(Term.width - prompt.size - 3)
  end

  def run_tests(sequence)
    ['Run Tests'] +
      if ARGV[0] !~ /RUN_TESTS/
        `ruby testing.rb #{['RUN_TESTS', sequence].join('_')}`
      end.split("\n").map { |c| c + '#CODE' }
  end

  def method_source(class_name, method, hide = //)
    ["class #{class_name.to_s}", ""] +
      class_name.
        instance_method(method).
        source.
        gsub(hide, '').
        split("\n").
        map { |c| c + '#CODE' }
  end

  def self.define_slide_sequence(class_name, method, test_class_name, test_method, test_sequence, variant = nil)
    if class_name
      define_slide(record: false, variant: variant, class_name: class_name) do
        method_source(class_name, method, /_slow|_fast|_wrong|_correct/)
      end
      define_slide(record: false) { run_tests(test_sequence.split('_')[0..-2].join('_')) }
    end
    if test_class_name
      define_slide(include: class_name ? -2 : 0) { method_source(test_class_name, test_method) }
      define_slide { run_tests(test_sequence) }
    end
  end

  def self.define_slide(record: true, include: 0, variant: nil, class_name: nil, &contents)
    @@slide_counter += 1
    slide = proc { |number| self.send("slide_#{number}".to_sym) }
    @@slides_to_record << @@slide_counter if record || ARGV[0] =~ /LONG/
    define_method "slide_#{@@slide_counter}".to_sym do
      instance_eval("#{class_name}.send(:#{variant.to_s})") if variant
      current_number = __method__.to_s.split('_').last.to_i
      (include != 0 ? instance_exec(current_number + include, &slide) : []) +
        instance_exec(&contents)
    end
  end

  @@slide_counter = 0
  @@slides_to_record = []
end
