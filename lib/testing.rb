require 'test/unit'
require 'method_source'
require 'colorize'

class MyList

  def initialize(a = [])
    @list = a
  end

  def contents
    @list
  end

  def append(a)
    @list.append(a)
  end

  def find_first_position_of(a)
    i = 0
    position = nil
    while i < @list.length
      if @list[i] == a
        position = i
        break
      end
      i += 1
    end
    return position
  end

  def find_positions_of(a)
    positions = []
    i = 0
    while i < @list.length
      if @list[i] == a
        positions.append i
      end
      i += 1
    end
    return positions
  end

  def maximum
    i = 0
    max = @list[0]
    while i < @list.length
      if @list[i] > max
        max = @list[i]
      end
      i += 1
    end
    return max
  end

  def minimum_wrong
    i = 0
    min = @list[0]
    while i < @list.length
      if @list[i] > min
        min = @list[i]
      end
      i += 1
    end
    return min
  end

  def minimum_correct
    i = 0
    min = @list[0]
    while i < @list.length
      if @list[i] < min
        min = @list[i]
      end
      i += 1
    end
    return min
  end

  def min_max_slow
    [minimum, maximum]
  end

  def min_max_fast
    i = 0
    min = @list[0]
    max = @list[0]
    while i < @list.length
      min = @list[i] if @list[i] < min
      max = @list[i] if @list[i] > max
      i += 1
    end
    [min, max]
  end

  def self.set_slow
    alias_method :min_max, :min_max_slow
  end

  def self.set_fast
    alias_method :min_max, :min_max_fast
  end

  def self.set_wrong
    alias_method :minimum, :minimum_wrong
  end

  def self.set_correct
    alias_method :minimum, :minimum_correct
  end

  self.set_fast
  self.set_correct

end

if ARGV[0] =~ /RUN_TESTS/
  class MyListClassTests < Test::Unit::TestCase;
  end
else
  class MyListClassTests;
  end
end

MyList.set_slow if ARGV[0] =~ /SLOW/
MyList.set_wrong if ARGV[0] =~ /WRONG/

class MyListClassTests
  def self.in_sequence(sequence)
    ARGV[0] =~ /#{sequence}/ || ARGV[0].nil? || ARGV[0] =~ /RECORD/
  end

  if in_sequence('T1')
    def test_new
      assert_kind_of MyList, MyList.new([1, 2, 3])
    end
  end
  if in_sequence('T2')
    def test_contents
      assert_equal [1, 2, 3], MyList.new([1, 2, 3]).contents
    end
  end
  if in_sequence('T3')
    def test_append
      my_list = MyList.new([1, 2, 3])
      my_list.append(4)
      assert_equal [1, 2, 3, 4], my_list.contents
      assert_includes my_list.contents, 4
    end
  end
  if in_sequence('T4')
    def test_find_first_position_of
      my_list = MyList.new([1, 2, 3, 2, 5])
      assert_equal 1, my_list.find_first_position_of(2)
      assert_equal 0, my_list.find_first_position_of(1)
      assert_equal 4, my_list.find_first_position_of(5)
    end
  end

  if in_sequence('T5')
    def test_find_positions_of
      my_list = MyList.new([1, 2, 3, 2, 5])
      assert_equal [1, 3], my_list.find_positions_of(2)
      assert_equal [0], my_list.find_positions_of(1)
      assert_equal [4], my_list.find_positions_of(5)
    end
  end
  if in_sequence('T6')
    def test_maximum
      my_list = MyList.new([1, 2, 3, 2, 5, 16, 7, 12])
      assert_equal 16, my_list.maximum
      my_list = MyList.new([12, 2, 33, 2, 5, 16, 7, 12])
      assert_equal 33, my_list.maximum
    end
  end
  if in_sequence('T7')
    def test_minimum
      my_list = MyList.new([1, 2, 3, 2, 5, 16, 7, 12])
      assert_equal 1, my_list.minimum
      my_list = MyList.new([12, 1, 2, 3, 2, 25, 16, 7])
      assert_equal 1, my_list.minimum
    end
  end
  if in_sequence('T8')
    def test_min_max
      my_list = MyList.new([1, 2, 3, 2, 5, 16, 7, 12])
      assert_equal [1, 16], my_list.min_max
      my_list = MyList.new([12, 2, 33, 2, 5, 16, 7, 12])
      assert_equal [2, 33], my_list.min_max
      my_list = MyList.new([12, 1, 2, 3, 2, 25, 16, 7])
      assert_equal [1, 25], my_list.min_max
    end
  end
end

if ARGV[0] !~ /RUN_TESTS/
  class Term
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

  class Presenter

    def initialize(first_slide = 1)
      self.current = @current = first_slide
    end

    attr_reader :current

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

    def record # requires MacOS + ImageMagick
      (1..size).each do |index|
        self.current = index
        next unless @@slides_to_record.include?(index)
        display_slide
        sleep 1
        `screencapture -x -o -l$(osascript -e 'tell app "Terminal" to id of window 1') slide_#{"%04d" % (index)}.png`
      end
      `convert slide_*.png presentation.pdf`
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
      center(self.send(@slides[@current - 1]))
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
        display = format.include?('CODE') ? content.ljust(Term.width - 10) : content.center(Term.width)
        if format.include?('NOTES')
          notes << (format - %w(NOTES CODE)).inject(display) { |res, f| res.send(f.to_sym) }
        else
          puts (format - ['CODE']).inject(display) { |res, f| res.send(f.to_sym) }
        end
      end
      puts "\n" * (half + rest + notes.size)

      notes.each { |n| puts n } if ARGV[0] =~ /NOTES/

    rescue ArgumentError => e
      "Παρακαλώ μεγαλώστε το παράθυρο για εμφανιστεί η σελίδα..."
      puts "Error: #{e.message}"
      puts e.backtrace
      puts ["lines:", lines, "height:", Term.height, "width:", Term.width, "blank:", blank, "half:", half, "rest:", rest].join("  ")
      @current -= 1
    ensure
      current_index = @@slides_to_record.find_index(current)
      previous_shown = (current_index == 0 ? 0 : @@slides_to_record[current_index - 1]) + 1
      pager, prompt = if ARGV[0] !~ /RECORD/
                        ["Slide: %d / %d >" % [current, size],
                          "b: back one,<number>: goto slide, <enter>: next, h,?: help, q: quit"]
                      else
                        ["Slide: #{[previous_shown,current].uniq.join(' - ')} / %d >" % @@slides_to_record.last, ""]
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
        define_slide(variant: variant, class_name: class_name) do
          method_source(class_name, method, /_slow|_fast|_wrong|_correct/)
        end
        define_slide { run_tests(test_sequence.split('_')[0..-2].join('_')) }
      end
      if test_class_name
        define_slide(include: class_name ? -2 : 0) { method_source(test_class_name, test_method) }
        define_slide { run_tests(test_sequence) }
      end
    end

    def self.define_slide(record: true, include: 0, variant: nil, class_name: nil, &contents)
      @@slide_counter += 1
      slide = proc { |number| self.send("slide_#{number}".to_sym) }
      @@slides_to_record << @@slide_counter if record
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

  class Presentation < Presenter
    define_slide { [
        "Unit Testing", "",
        "Πως μπορούμε να εξασφαλίσουμε την ορθότητα των προγραμμάτων;",
    ] }

    define_slide { ["Παντελέλης Μιχάλης#light_magenta",
                    "email: mpantel@aegean.gr#magenta", "",
                    "Ηλεκτρολόγος Μηχανικός & Μηχανικός Η/Υ#magenta", "",
                    "Ειδικός Λογαριασμός Ερευνας Π.Αιγαίου",
                    "Προϊστάμενος Τμήματος Διαχείρισης Πληροφοριακών Συστημάτων"]
    }

    define_slide(record: false) { ["Μπορούμε να αποδείξουμε ότι ένα πρόγραμμα είναι ορθό;"] }
    define_slide(record: false, include: -1) { ["", "", "Για οποιαδήποτε είσοδο;"] }
    define_slide(include: -1) { ["", "", "Αυτοματοποιημένα;"] }
    define_slide(record: false) { ["Με το ερώτημα αυτό ασχολήθηκαν από τις αρχές του περασμένου αιώνα..."] }

    #David Hilbert (https://en.wikipedia.org/wiki/David_Hilbert)
    #His attempt to support axiomatized mathematics with definitive principles, which could banish theoretical uncertainties, ended in failure.
    #    (Entscheidungsproblem, 1928
    define_slide(include: -1) { ["", "Ο David Hilbert (https://en.wikipedia.org/wiki/David_Hilbert):", "",
                                 "Θεωρείται πατέρας της \"Μαθηματικής Λογικής\"", "",
                                 "Προσπαθούσε να αποδείξει ότι αν έχουμε ορίσει",
                                 "ένα σύνολο από κανόνες (αξιώματα και θεωρήματα),",
                                 "και ένα τρόπο να παράγουμε συμπεράσματα από αυτούς τους κανόνες,", "",
                                 "μπορούμε να φτιάξουμε συστήματα πλήρη και συνεπή ...",
                                 "Αξίωμα: 2 σημεία ορίζουν μία ευθεία#NOTES.CODE",
                                 "Αξίωμα: α + β = β + α#NOTES.CODE",
                                 "Πληρότητα: βασισμένοι στα αξιώματα μπορούμε να αποδείξουμε όλα τα θεωρήματα#NOTES.CODE",
                                 "Συνέπεια: δεν έχουμε αντιφάσεις#NOTES.CODE",
    ] }

    #Kurt  Gödel (https://en.wikipedia.org/wiki/Kurt_G%C3%B6del)
    # Gödel demonstrated that any non-contradictory formal system, which was comprehensive enough to include at least arithmetic,
    # cannot demonstrate its completeness by way of its own axioms. In 1931 his incompleteness theorem showed that Hilbert's
    # grand plan was impossible as stated. The second point cannot in any reasonable way be combined with the first point,
    # as long as the axiom system is genuinely finitary.
    # Nevertheless, the subsequent achievements of proof theory at the very least clarified consistency
    # as it relates to theories of central concern to mathematicians.
    # Hilbert's work had started logic on this course of clarification; the need to understand Gödel's work then
    # led to the development of recursion theory and then mathematical logic as an autonomous discipline in the 1930s.
    # The basis for later theoretical computer science, in the work of Alonzo Church and Alan Turing, also grew directly out of this 'debate'.

    define_slide(include: -2) { ["", "", "Ο Kurt Gödel (https://en.wikipedia.org/wiki/Kurt_G%C3%B6del):", "",
                                 "Απέδειξε το θεώρημα της ΜΗ πληρότητας (1931)#bold", "",
                                 "Οπότε τα σχέδια του Hilbert ναυάγησαν :-("] }


    #Alan Turing (https://en.wikipedia.org/wiki/Alan_Turing)
    #Turing's proof (https://en.wikipedia.org/wiki/Turing%27s_proof)
    #https://en.wikipedia.org/wiki/Halting_problem
    #In computability theory, the halting problem is the problem of determining, from a description of an arbitrary
    # computer program and an input, whether the program will finish running, or continue to run forever.
    # Alan Turing proved in 1936 that a general algorithm to solve the halting problem for all possible program-input
    # pairs cannot exist. For any program f that might determine if programs halt, a "pathological" program g called
    # with an input can pass its own source and its input to f and then specifically do the opposite of
    # what f predicts g will do. No f can exist that handles this case. A key part of the proof was a mathematical
    # definition of a computer and program, which became known as a Turing machine; the halting problem is undecidable
    # over Turing machines. Turing's proof is one of the first cases of decision problems to be concluded.
    # The theoretical conclusion that it is not solvable is significant to practical computing efforts, defining
    # a class of applications which no programming invention can possibly perform perfectly.

    define_slide(include: -3) { ["", "", "O Alan Turing (https://en.wikipedia.org/wiki/Alan_Turing):", "", "",
                                 "Απέδειξε ότι ΔΕΝ υπάρχει αλγόριθμος που να αποφασίζει πάντα και σωστά", "",
                                 "για ένα οποιοδήποτε πρόγραμμα και την είσοδό του", "",
                                 "αν το πρόγραμμα θα σταματήσει όταν το εκτελέσουμε με την είσοδο αυτή"
    ] }

    define_slide(record: false) { ["Γλώσσες Προγραμματισμού - Γενικός Διαχωρισμός"] }
    define_slide(include: -1) { ["", "Low Level / High Level"] }
    define_slide(record: false, include: -2) { ["",
                                                "Low Level: Machine Code, Assembly"] }
    define_slide(include: -1) { ["",
                                 "High Level: Java, Javascript, C/C++, ADA, Pascal"] }

    define_slide(include: -1) { ["", "", "Compiled / Interpreted"] }
    define_slide(record: false, include: -2) { ["", "", "Compiled: Java, Javascript, C/C++, ADA, Pascal"] }
    define_slide(include: -1) { ["", "", "Interpreted: Javascript, Python, Ruby . . ."] }

    define_slide(record: false) {
      ["Γλώσσες Προγραμματισμού Python vs Ruby", "", "",
      ] }
    define_slide(include: -1) { ["print \"Hello, world!\"#CODE"] }
    define_slide(include: -2) {
      ["for i in [1,2,3]:#CODE",
       "  print i #CODE",
       *split_screen,
       "for i in [1,2,3]#CODE",
       "  print i #CODE",
       "end#CODE",
      ] }
    define_slide(include: -3) {

      ["list                                   @list", "",
       "len(list)                       @list.length", "",
       "indentation and colons(:)      begin ... end"

      ] }
    define_slide(record: false) {
      ["Γλώσσες Προγραμματισμού", "",
      ] }
    define_slide(record: false, include: -1) do
      ["Έχουν παρόμοιες δομές και συντακτικό", "",
       "ανά οικογένεια γλωσσών#NOTES.CODE",]
    end
    define_slide(record: false, include: -1) do
      ["Υλοποιούμε τους ίδιους αλγορίθμους... με άλλα λόγια", "",
       "όλες οι γλώσσες που είδαμε παραπάνω μπορούν να λύσουν τα ίδια προβλήματα#NOTES.CODE",
       "άλλες ευκολότερα, άλλες δυσκολότερα:#NOTES.CODE",
       "https://en.wikipedia.org/wiki/Turing_completeness#NOTES.CODE#"]
    end
    define_slide(record: false, include: -1) do
      ["Δεν πρέπει να τρομάζουμε βλέποντας μία διαφορετική γλώσσα", ""]
    end
    define_slide(record: false, include: -1) do
      ["Συνήθως η επιλογή γλώσσας είναι θέμα (προσωπικής) προτίμησης", ""]
    end
    define_slide(include: -1) do
      ["Όσα θα περιγράψουμε στην συνέχεια μπορείτε να τα εφαρμόσετε γενικά#red" + (ARGV[0] =~ /RECORD/ ? '' : '.blink')]
    end
    define_slide { ["Πώς ελέγχουμε τα προγράμματα που φτιάχουμε π.χ. για το εργαστήριο;", "",
                    "Με το χέρι...", "",
                    "Εποπτικά...", "",
                    "Εμπειρικά..."] }

    define_slide { ["Πώς ελέγχουμε μεγάλα συστήματα λογισμικού;", "",
                    "Regression Suites", "",
                    "End User Testing", "",
                    "Automated Testing", "",
                    "PyUnit https://wiki.python.org/moin/PyUnit#NOTES.CODE",
                    "Minitest https://github.com/seattlerb/minitest#NOTES.CODE",
                    "Junit https://junit.org/junit5/#NOTES.CODE",
                    "Jasmin https://jasmine.github.io/#NOTES.CODE",
    ] }

    define_slide { ["Program Development by Stepwise Refinement", "",
                    "Niklaus Wirth", "",
                    "Communications of the ACM, Vol. 14, No. 4, April 1971", "",
                    "http://sunnyday.mit.edu/16.355/wirth-refinement.html#italic"
    ] }

    define_slide { ["Test-Driven Development",
                    "(Martin Fowler: https://martinfowler.com/bliki/TestDrivenDevelopment.html)", "",
                    "Είναι τεχνική για τη κατασκευή λογισμικού",
                    "που οδηγείται από της συγγραφή tests", "",
                    "Αναπτύχθηκε από τον  Kent Beck στα τέλη της δεκαετίας του 1990",
                    "ως τμήμα της μεθοδολογίας Extreme Programming.", "",
    ] }
    define_slide(record: false) { ["Test-Driven Development", "", "",
                                   "Πρακτικά αποτελείται από τρία επαναλαμβανόμενα βήματα:", "",] }

    define_slide(record: false, include: -1) { [
        "1. Γράφουμε πρώτα τα test για τη λειτουργικότητα",
        "που θα προσθέσουμε στην εφαρμογή.", "",
    ] }

    define_slide(record: false, include: -1) do
      ["2. Γράφουμε τον κώδικα της εφαρμογής μέχρι να ικανοποιήσουμε",
       "τiς απαιτήσεις του test.", ""]
    end

    define_slide(record: false, include: -1) { ["3. Αναδιατάσουμε το κώδικα (Refactor) μέχρι να έρθει", "στην δομική μορφή που επιθυμούμε."] }

    define_slide(record: false) { ["RED - GREEN - REFACTOR", "", ""] }
    define_slide(record: false, include: -1) { ["RED: Γράφουμε tests (που αρχικά δεν ικανοποιούνται)", "", ""] }
    define_slide(record: false, include: -1) { ["GREEN: Γράφουμε κώδικα που ικανοποιεί τα tests", "", ""] }
    define_slide(include: -1) { ["REFACTOR: Βελτιώνουμε τη ποιότητα του κώδικα", "", ""] }

    define_slide(record: false) { (["Refactoring (Martin Fowler, https://refactoring.com/)", "", "",
                                    "Ουσιαστικό (refactoring): αλλαγή στην εσωτερική δομή του λογισμικού ώστε:",
                                    "να γίνει εύκολότερη η κατανόησή του",
                                    "και οικονομικότερη η εξέλιξή του,",
                                    "ΧΩΡΙΣ να αλλάξει η εξωτερική του συμπεριφορά.",
                                    "", "",]) }

    define_slide(include: -1) { ["Ρήμα (refactor): η διαδικασία της αναδιάταξης του κώδικα μέσω",
                                 "μίας σαφούς αλληλουχίας βημάτων με τρόπο τέτοιο ώστε ",
                                 "να μήν αλλάξει η εξωτερική του συμπεριφορά."] }

    define_slide { (["Testing Frameworks", "", "",
                     "Διαθέσιμα πλέον στις περισσότερες γλώσσες προγραμματισμού", "",
                     "Διαφορετικές Φιλοσοφίες (TDD - testing, BDD - Behaviour)", "",
                     "Διαφορετικά επίπεδα testing (unit, integration, front end...)", "",
                     "Διαφορετική αποδοχή από της κοινότητες προγραμματιστών", "",
    ]) }

    define_slide { [
        "TDD: Assertions - Διαβεβαιώσεις (Ruby)", "", "",
        "assert_equal 2, @size#CODE", "",
        "assert_includes @list, \"item\"#CODE", "",
        "assert_instance_of Array, @list#CODE", "",
        "assert_kind_of Array, @list#CODE", "",
        "assert_nil#CODE"
    ] }

    define_slide { ["Παραδείγματα"] }
    define_slide_sequence(MyList, :initialize, MyListClassTests, :test_new, 'T1')
    define_slide_sequence(MyList, :contents, MyListClassTests, :test_contents, 'T1_T2')
    define_slide_sequence(MyList, :append, MyListClassTests, :test_append, 'T1_T2_T3')
    define_slide_sequence(MyList, :find_first_position_of, MyListClassTests, :test_find_first_position_of, 'T1_T2_T3_T4')
    define_slide_sequence(MyList, :find_positions_of, MyListClassTests, :test_find_positions_of, 'T1_T2_T3_T4_T5')
    define_slide_sequence(MyList, :maximum, MyListClassTests, :test_maximum, 'T1_T2_T3_T4_T5_T6')
    define_slide_sequence(MyList, :minimum, MyListClassTests, :test_minimum, 'WRONG_T1_T2_T3_T4_T5_T6_T7', :set_wrong)
    define_slide_sequence(MyList, :minimum, nil, nil, 'T1_T2_T3_T4_T5_T6_T7_CORRECT', :set_correct)
    define_slide_sequence(MyList, :min_max, MyListClassTests, :test_min_max, 'SLOW_T1_T2_T3_T4_T5_T6_T7_T8', :set_slow)
    define_slide_sequence(MyList, :min_max, nil, nil, 'T1_T2_T3_T4_T5_T6_T7_T8_FAST', :set_fast)

    define_slide(record: false) { ["Συμπεράσματα - Unit Testing", "", "",] }
    define_slide(record: false, include: -1) { ["1. Είναι σημαντικό να ελέγχουμε τα προγράμματα που γράφουμε", "",] }
    define_slide(record: false, include: -1) { ["2. Μπορούμε να επικεντρωθούμε στις συνοριακές περιπτώσεις", "",] }
    define_slide(record: false, include: -1) { ["3. Είναι σημαντικό ο έλεγχος να γίνεται αυτοματοποιημένα", "",] }
    define_slide(record: false, include: -1) { ["4. Μπορεί να μας καθοδηγήσει στη βελτίωση του κωδικά που γράφουμε", ""] }
    define_slide(include: -1) { ["5. Είναι ίσως το σημαντικότερο εργαλείο που διαθέτουμε ως προγραμματιστές", "",] }
    define_slide(record: false) { ["Ευχαριστώ για τη προσοχή σας..."] }

  end

  Presentation.new.play if ARGV[0] !~ /RECORD/
  Presentation.new.record if ARGV[0] =~ /RECORD/
end
