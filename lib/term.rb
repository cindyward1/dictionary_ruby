class Term
  @@all_terms = []

  def Term.all
    @@all_terms
  end

  def Term.clear
    @@all_terms = []
  end

  def Term.by_index(index)
    @@all_terms[index]
  end

  def Term.term_delete(index)
    term = @@all_terms.delete_at(index)
  end

  def Term.term_sort
    @@all_terms.sort! { |term_1, term_2 | term_1.word <=> term_2.word }
  end

  def initialize (word,definition)
    @definitions = []
    @word = word # {English => "House", Spanish => "Casa"}
    @definitions << definition
  end

  def term_add
    @@all_terms << self
  end

  def word
    @word
  end

  def definitions
    @definitions
  end

  def definition_add(definition)
    @definitions << definition
  end

  def definition_edit(index,new_definition)
    @definitions[index] = new_definition
  end

  def definition_delete(index)
    definition = @definitions.delete_at(index)
  end

end
